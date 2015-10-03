
//
//	HSPVAR utility
//	onion software/onitama 2008/4
//
#include <stdio.h>
#include <stdlib.h>

#include "../hsp3/hsp3struct.h"
#include "../hsp3/stack.h"
#include "../hsp3/strbuf.h"
#include "../hsp3/hsp3code.h"
#include "hspvar_util.h"

/*------------------------------------------------------------*/
/*
		extra header
*/
/*------------------------------------------------------------*/

/*------------------------------------------------------------*/
/*
		system data
*/
/*------------------------------------------------------------*/

extern CHSP3_TASK __HspTaskFunc[];		// hsp3cnvで生成されるタスク関数リスト
void __HspEntry( void );				// hsp3cnvで生成されるエントリーポイント

static	HSPCTX *hspctx;					// HSPのコンテキスト
static	CHSP3_TASK curtask;				// 次に実行されるタスク関数
static int *c_type;
static int *c_val;
static HSPEXINFO *exinfo;				// Info for Plugins

PVal *mem_var;							// 変数用のメモリ

static	HSP3TYPEINFO *intcmd_info;
static	HSP3TYPEINFO *extcmd_info;
static	HSP3TYPEINFO *extsysvar_info;
static	HSP3TYPEINFO *intfunc_info;
static	HSP3TYPEINFO *sysvar_info;
static	HSP3TYPEINFO *progfunc_info;

/*------------------------------------------------------------*/

static HspVarProc *varproc;
static STMDATA *stm1;
static STMDATA *stm2;
static int tflag;
static int arrayobj_flag;

static inline char * PrepareCalc( void )
{
	//		スタックから２項目取り出し計算の準備を行なう
	//
	char *calc_ptr;

	stm2 = StackPeek;
	stm1 = StackPeek2;
	tflag = stm1->type;

	mpval = HspVarCoreGetPVal( tflag );
	varproc = HspVarCoreGetProc( tflag );

	if ( mpval->mode == HSPVAR_MODE_NONE ) {					// 型に合わせたテンポラリ変数を初期化
		if ( varproc->flag == 0 ) {
			throw HSPERR_TYPE_INITALIZATION_FAILED;
		}
		HspVarCoreClearTemp( mpval, tflag );					// 最小サイズのメモリを確保
	}

	varproc->Set( mpval, (PDAT *)mpval->pt, STM_GETPTR(stm1) );	// テンポラリ変数に初期値を設定

	calc_ptr = STM_GETPTR(stm2);
	if ( tflag != stm2->type ) {								// 型が一致しない場合は変換
		if ( stm2->type >= HSPVAR_FLAG_USERDEF ) {
			calc_ptr = (char *)HspVarCoreGetProc(stm2->type)->CnvCustom( calc_ptr, tflag );
		} else {
			calc_ptr = (char *)varproc->Cnv( calc_ptr, stm2->type );
		}
	}
	//calcprm( varproc, (PDAT *)mpval->pt, op, ptr );				// 計算を行なう
	return calc_ptr;
}


static inline void AfterCalc( void )
{
	//		計算後のスタック処理
	//
	int basesize;
	StackPop();
	StackPop();

	if ( varproc->aftertype != tflag ) {						// 演算後に型が変わる場合
		tflag = varproc->aftertype;
		varproc = HspVarCoreGetProc( tflag );
	}
	basesize = varproc->basesize;
	if ( basesize < 0 ) {
		basesize = varproc->GetSize( (PDAT *)mpval->pt );
	}
	StackPush( tflag, mpval->pt, basesize );
}


static inline void code_arrayint2( PVal *pval, int offset )
{
	//		配列要素の指定 (index)
	//		( Reset後に次元数だけ連続で呼ばれます )
	//
	if ( pval->arraycnt >= 5 ) throw HSPVAR_ERROR_ARRAYOVER;
	if ( pval->arraycnt == 0 ) {
		pval->arraymul = 1;			// 最初の値
	} else {
		pval->arraymul *= pval->len[ pval->arraycnt ];
	}
	pval->arraycnt++;
	if ( offset < 0 ) throw HSPVAR_ERROR_ARRAYOVER;
	if ( offset >= (pval->len[ pval->arraycnt ]) ) {
		if ((pval->arraycnt >= 4 )||( pval->len[ pval->arraycnt+1 ]==0 )) {
			if ( pval->support & HSPVAR_SUPPORT_FLEXARRAY ) {
				//Alertf("Expand.(%d)",offset);
				HspVarCoreReDim( pval, pval->arraycnt, offset+1 );	// 配列を拡張する
				pval->offset += offset * pval->arraymul;
				return;
			}
		}
		throw HSPVAR_ERROR_ARRAYOVER;
	}
	pval->offset += offset * pval->arraymul;
}


static APTR CheckArray( PVal *pval, int ar )
{
	//		Check PVal Array information
	//		(配列要素(int)の取り出し)
	//
	int chk,i;
	int val;
	PVal temp;
	arrayobj_flag = 0;
	HspVarCoreReset( pval );							// 配列ポインタをリセットする
	if ( pval->support & HSPVAR_SUPPORT_MISCTYPE ) {	// 連想配列の場合
		return 0;
	}

	for(i=0;i<ar;i++) {
		HspVarCoreCopyArrayInfo( &temp, pval );			// 状態を保存
		chk = code_get();
		if ( chk<=PARAM_END ) { throw HSPERR_BAD_ARRAY_EXPRESSION; }
		if ( mpval->flag != HSPVAR_FLAG_INT ) { throw HSPERR_TYPE_MISMATCH; }
		HspVarCoreCopyArrayInfo( pval, &temp );			// 状態を復帰
		val = *(int *)(mpval->pt);
		HspVarCoreArray( pval, val );					// 配列要素指定(整数)
	}
	return HspVarCoreGetAPTR( pval );
}


/*------------------------------------------------------------*/

void VarUtilInit( HSPCTX *ctx )
{
	//		HSPVAR utilityの初期化
	//
	hspctx = ctx;
	mem_var = hspctx->mem_var;
	exinfo = hspctx->exinfo2;
	c_type = exinfo->nptype;
	c_val = exinfo->npval;

	//		typeinfoを取得しておく
	intcmd_info = code_gettypeinfo( TYPE_INTCMD );
	extcmd_info = code_gettypeinfo( TYPE_EXTCMD );
	extsysvar_info = code_gettypeinfo( TYPE_EXTSYSVAR );
	intfunc_info = code_gettypeinfo( TYPE_INTFUNC );
	sysvar_info = code_gettypeinfo( TYPE_SYSVAR );
	progfunc_info = code_gettypeinfo( TYPE_PROGCMD );

	//		最初のタスク実行関数をセット
	curtask = (CHSP3_TASK)__HspEntry;
}


void VarUtilTerm( void )
{
	//		HSPVAR utilityの終了処理
	//
}


/*------------------------------------------------------------*/
/*
		stack operation
*/
/*------------------------------------------------------------*/

void PushInt( int val )
{
	StackPushi( val );
}


void PushStr( char *st )
{
	StackPushStr( st );
}


void PushDouble( double val )
{
	StackPush( HSPVAR_FLAG_DOUBLE, (char *)&val, sizeof(double) );
}


void PushLabel( int val )
{
	StackPush( HSPVAR_FLAG_LABEL, (char *)&val, sizeof(int)  );
}


void PushVar( PVal *pval, int aval )
{
	//	変数の値をpushする
	int basesize;
	APTR aptr;
	PDAT *ptr;

	aptr = CheckArray( pval, aval );
	ptr = HspVarCorePtrAPTR( pval, aptr );

	tflag = pval->flag;
	varproc = HspVarCoreGetProc( tflag );
	basesize = varproc->basesize;
	if ( basesize < 0 ) { basesize = varproc->GetSize( ptr ); }
	StackPush( tflag, (char *)ptr, basesize );
}


void PushVAP( PVal *pval, int aval )
{
	//	変数そのもののポインタをpushする
	APTR aptr;
	//PDAT *ptr;
	aptr = CheckArray( pval, aval );
	//ptr = HspVarCorePtrAPTR( pval, aptr );
	StackPushTypeVal( HSPVAR_FLAG_VAR, (int)pval, (int)aptr );
}


void PushDefault( void )
{
	StackPushTypeVal( HSPVAR_FLAG_MARK, (int)'?', 0 );
}


void PushFuncEnd( void )
{
	StackPushTypeVal( HSPVAR_FLAG_MARK, (int)')', 0 );
}


void PushExtvar( int val, int pnum )
{
}


void PushIntfunc( int val, int pnum )
{
	char *ptr;
	int resflag;
	int basesize;

	*c_type = TYPE_MARK;
	*c_val = '(';
	ptr = (char *)intfunc_info->reffunc( &resflag, val );						// タイプごとの関数振り分け
	code_next();
	basesize = HspVarCoreGetProc( resflag )->GetSize( (PDAT *)ptr );
	StackPush( resflag, ptr, basesize );
}


void PushSysvar( int val, int pnum )
{
	char *ptr;
	int resflag;
	int basesize;

	*c_type = TYPE_MARK;
	*c_val = '(';
	ptr = (char *)sysvar_info->reffunc( &resflag, val );						// タイプごとの関数振り分け
	code_next();
	basesize = HspVarCoreGetProc( resflag )->GetSize( (PDAT *)ptr );
	StackPush( resflag, ptr, basesize );
}


void PushDllfunc( int val, int pnum )
{
}



void CalcAddI( void )
{
	char *ptr;
	ptr = PrepareCalc();
	varproc->AddI( (PDAT *)mpval->pt, ptr );
	AfterCalc();
}


void CalcSubI( void )
{
	char *ptr;
	ptr = PrepareCalc();
	varproc->SubI( (PDAT *)mpval->pt, ptr );
	AfterCalc();
}


void CalcMulI( void )
{
	char *ptr;
	ptr = PrepareCalc();
	varproc->MulI( (PDAT *)mpval->pt, ptr );
	AfterCalc();
}


void CalcDivI( void )
{
	char *ptr;
	ptr = PrepareCalc();
	varproc->DivI( (PDAT *)mpval->pt, ptr );
	AfterCalc();
}


void CalcModI( void )
{
	char *ptr;
	ptr = PrepareCalc();
	varproc->ModI( (PDAT *)mpval->pt, ptr );
	AfterCalc();
}


void CalcAndI( void )
{
	char *ptr;
	ptr = PrepareCalc();
	varproc->AndI( (PDAT *)mpval->pt, ptr );
	AfterCalc();
}


void CalcOrI( void )
{
	char *ptr;
	ptr = PrepareCalc();
	varproc->OrI( (PDAT *)mpval->pt, ptr );
	AfterCalc();
}


void CalcXorI( void )
{
	char *ptr;
	ptr = PrepareCalc();
	varproc->XorI( (PDAT *)mpval->pt, ptr );
	AfterCalc();
}


void CalcEqI( void )
{
	char *ptr;
	ptr = PrepareCalc();
	varproc->EqI( (PDAT *)mpval->pt, ptr );
	AfterCalc();
}


void CalcNeI( void )
{
	char *ptr;
	ptr = PrepareCalc();
	varproc->NeI( (PDAT *)mpval->pt, ptr );
	AfterCalc();
}


void CalcGtI( void )
{
	char *ptr;
	ptr = PrepareCalc();
	varproc->GtI( (PDAT *)mpval->pt, ptr );
	AfterCalc();
}


void CalcLtI( void )
{
	char *ptr;
	ptr = PrepareCalc();
	varproc->LtI( (PDAT *)mpval->pt, ptr );
	AfterCalc();
}


void CalcGtEqI( void )
{
	char *ptr;
	ptr = PrepareCalc();
	varproc->GtEqI( (PDAT *)mpval->pt, ptr );
	AfterCalc();
}


void CalcLtEqI( void )
{
	char *ptr;
	ptr = PrepareCalc();
	varproc->LtEqI( (PDAT *)mpval->pt, ptr );
	AfterCalc();
}


void CalcRrI( void )
{
	char *ptr;
	ptr = PrepareCalc();
	varproc->RrI( (PDAT *)mpval->pt, ptr );
	AfterCalc();
}


void CalcLrI( void )
{
	char *ptr;
	ptr = PrepareCalc();
	varproc->LrI( (PDAT *)mpval->pt, ptr );
	AfterCalc();
}



void VarSet( PVal *pval, int aval, int pnum )
{
	//	変数代入(var=???)
	//		aval=配列要素のスタック数
	//		pnum=パラメーターのスタック数
	//
	int chk;
	HspVarProc *proc;
	APTR aptr;
	void *ptr;
	PDAT *dst;
	int pleft;
	int baseaptr;

	aptr = CheckArray( pval, aval );
	proc = HspVarCoreGetProc( pval->flag );
	dst = HspVarCorePtrAPTR( pval, aptr );

	chk = code_get();									// パラメーター値を取得
	if ( chk != PARAM_OK ) { throw HSPERR_SYNTAX; }

	ptr = mpval->pt;
	if ( pval->flag != mpval->flag ) {

		if ( pval->support & HSPVAR_SUPPORT_NOCONVERT ) {	// 型変換なしの場合
			if ( arrayobj_flag ) {
				proc->ObjectWrite( pval, ptr, mpval->flag );
				return;
			}
		}
		if ( aptr != 0 ) throw HSPERR_INVALID_ARRAYSTORE;	// 型変更の場合は配列要素0のみ
		HspVarCoreClear( pval, mpval->flag );		// 最小サイズのメモリを確保
		proc = HspVarCoreGetProc( pval->flag );
		dst = proc->GetPtr( pval );					// PDATポインタを取得
	}
	proc->Set( pval, dst, ptr );

	if ( pnum < 2 ) return;

	//	複数パラメーターがある場合
	//
	pleft = pnum - 1;
	chk = pval->len[1];
	if ( chk == 0 ) baseaptr = aptr; else baseaptr = aptr % chk;
	aptr -= baseaptr;

	while(1) {
		if ( pleft == 0 ) break;

		chk = code_get();							// パラメーター値を取得
		if ( chk != PARAM_OK ) { throw HSPERR_SYNTAX; }
		if ( pval->flag != mpval->flag ) {
				throw HSPERR_INVALID_ARRAYSTORE;	// 型変更はできない
		}
		ptr = mpval->pt;
		baseaptr++;

		pval->arraycnt = 0;							// 配列指定カウンタをリセット
		pval->offset = aptr;
		code_arrayint2( pval, baseaptr );			// 配列チェック

		dst = HspVarCorePtr( pval );
		proc->Set( pval, dst, ptr );				// 次の配列にたたき込む
		pleft--;
	}
}


void VarInc( PVal *pval, int aval )
{
	//	変数インクリメント(var++)
	//
	HspVarProc *proc;
	APTR aptr;
	int incval;
	void *ptr;
	PDAT *dst;

	aptr = CheckArray( pval, aval );
	proc = HspVarCoreGetProc( pval->flag );
	incval = 1;
	if ( pval->flag == HSPVAR_FLAG_INT ) { ptr = &incval; } else {
		ptr = (int *)proc->Cnv( &incval, HSPVAR_FLAG_INT );	// 型がINTでない場合は変換
	}
	dst = HspVarCorePtrAPTR( pval, aptr );
	proc->AddI( dst, ptr );
}


void VarDec( PVal *pval, int aval )
{
	//	変数デクリメント(var--)
	//
	HspVarProc *proc;
	APTR aptr;
	int incval;
	void *ptr;
	PDAT *dst;

	aptr = CheckArray( pval, aval );
	proc = HspVarCoreGetProc( pval->flag );
	incval = 1;
	if ( pval->flag == HSPVAR_FLAG_INT ) { ptr = &incval; } else {
		ptr = (int *)proc->Cnv( &incval, HSPVAR_FLAG_INT );	// 型がINTでない場合は変換
	}
	dst = HspVarCorePtrAPTR( pval, aptr );
	proc->SubI( dst, ptr );
}


void VarCalc( PVal *pval, int aval, int op )
{
	//	変数演算代入(var*=???等)
	//		aval=配列要素のスタック数
	//		op=演算子コード
	//
	int chk;
	HspVarProc *proc;
	APTR aptr;
	void *ptr;
	PDAT *dst;

	aptr = CheckArray( pval, aval );

	proc = HspVarCoreGetProc( pval->flag );
	dst = HspVarCorePtrAPTR( pval, aptr );

	chk = code_get();									// パラメーター値を取得
	if ( chk != PARAM_OK ) { throw HSPERR_SYNTAX; }

	ptr = mpval->pt;
	if ( pval->flag != mpval->flag ) {					// 型が一致しない場合は変換
		ptr = HspVarCoreCnvPtr( mpval, pval->flag );
	}

	switch(op) {
	case CALCCODE_ADD:
		proc->AddI( dst, ptr );
		break;
	case CALCCODE_SUB:
		proc->SubI( dst, ptr );
		break;
	case CALCCODE_MUL:
		proc->MulI( dst, ptr );
		break;
	case CALCCODE_DIV:
		proc->DivI( dst, ptr );
		break;
	case CALCCODE_MOD:						// '%'
		proc->ModI( dst, ptr );
		break;

	case CALCCODE_AND:
		proc->AndI( dst, ptr );
		break;
	case CALCCODE_OR:
		proc->OrI( dst, ptr );
		break;
	case CALCCODE_XOR:
		proc->XorI( dst, ptr );
		break;

	case CALCCODE_EQ:
		proc->EqI( dst, ptr );
		break;
	case CALCCODE_NE:
		proc->NeI( dst, ptr );
		break;
	case CALCCODE_GT:
		proc->GtI( dst, ptr );
		break;
	case CALCCODE_LT:
		proc->LtI( dst, ptr );
		break;
	case CALCCODE_GTEQ:						// '>='
		proc->GtEqI( dst, ptr );
		break;
	case CALCCODE_LTEQ:						// '<='
		proc->LtEqI( dst, ptr );
		break;

	case CALCCODE_RR:						// '>>'
		proc->RrI( dst, ptr );
		break;
	case CALCCODE_LR:						// '<<'
		proc->LrI( dst, ptr );
		break;
	case '(':
		throw HSPERR_INVALID_ARRAY;
	default:
		throw HSPVAR_ERROR_INVALID;
	}

	if ( proc->aftertype != pval->flag ) {				// 演算後に型が変わる場合
		throw HSPERR_TYPE_MISMATCH;
	}
}


/*------------------------------------------------------------*/
/*
		Program Control Process
*/
/*------------------------------------------------------------*/


void TaskSwitch( int label )
{
	//		次のタスク関数をセット
	//		(label=タスク関数ID)
	//
	curtask = __HspTaskFunc[label];
}

void TaskExec( void )
{
	//		セットされたタスク関数を実行する
	//
	curtask();
}


/*------------------------------------------------------------*/
/*
		Normal HSP Process
*/
/*------------------------------------------------------------*/

static void HspPostExec( void )
{
	//		コマンド実行後の処理
	//
	if ( hspctx->runmode == RUNMODE_RETURN ) {
		//cmdfunc_return();
	} else {
		hspctx->msgfunc( hspctx );
	}
}

bool HspIf( void )
{
	//		スタックから値を取り出して真偽を返す
	//		(真偽が逆になっているので注意)
	//
	int i;
	i = code_geti();
	return (i==0);
}


void Extcmd( int cmd, int pnum )
{
	if ( extcmd_info->cmdfunc( cmd ) ) HspPostExec();
}


void Modcmd( int cmd, int pnum )
{
}


void Dllcmd( int cmd, int pnum )
{
}


void Prgcmd( int cmd, int pnum )
{
	if ( progfunc_info->cmdfunc( cmd ) ) HspPostExec();
}


void Intcmd( int cmd, int pnum )
{
	if ( intcmd_info->cmdfunc( cmd ) ) HspPostExec();
}
