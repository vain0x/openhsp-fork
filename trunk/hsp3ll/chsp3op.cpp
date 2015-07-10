//
//			HSP3 script generator
//			onion software/onitama 2008/5
//
#include <stdio.h>
#include <string>
#include <map>
#include <set>
#include <vector>
#include <stack>
#include <boost/format.hpp>

#include "supio.h"
#include "hsp3r.h"
#include "hsp3op.h"
#include "chsp3op.h"

#ifdef HSPWIN
#include <windows.h>
#endif


using std::string;
using boost::format;

/*------------------------------------------------------------*/
CHsp3Op::CHsp3Op()
{
}

string CHsp3Op::MakeImmidiateCPPVarName( int type, int val, char *opt )
{
	//		変数名の生成
	//		(追加できない型の場合は-1を返す)
	//
	switch( type ) {
	case TYPE_VAR:
		if ( opt != NULL ) {
			return CPPHED_HSPVAR + GetHSPVarName( val ) + opt;
		} else {
			return CPPHED_HSPVAR + GetHSPVarName( val );
		}
	case TYPE_STRUCT:
		{
			const STRUCTPRM *prm = GetMInfo( val );
			if ( prm->subid != STRUCTPRM_SUBID_STACK ) {
				return "_modprm" + std::to_string( val - curprmindex );
			} else {
				return "_prm" + std::to_string( val - curprmindex );
			}
		}
	default:
		return GetHSPName( type, val );
	}
	return "";
}


void CHsp3Op::MakeCPPTask( int id, const string& name, int nexttask )
{
	//		タスクの区切り
	//			funcdef=新しい関数定義
	//			nextttask=次のタスク(ラベルID)
	//

	if ( tasknum ) {
		if ( nexttask >= 0 ) {
			if ( reachable ) {
				curTask->operations.push_back( new TaskSwitchOp( nexttask ) );
			}
		}
	}

	curTask = new Block();
	curTask->id = id;
	curTask->name = name;
	tasks[name] = curTask;
	//	Alert((char*)name);

	reachable = true;

	tasknum++;
}


void CHsp3Op::MakeCPPTask( int nexttask )
{
	//		単純タスクの生成
	//
	string name = ( format( "L%1$04x" ) % nexttask ).str();
	MakeCPPTask( nexttask, name, nexttask );
}


void CHsp3Op::MakeCPPTask2( int nexttask, int newtask )
{
	//		単純タスクの生成
	//
	string name = ( format( "L%1$04x" ) % newtask ).str();
	MakeCPPTask( newtask, name, nexttask );
}

void CHsp3Op::MakeCPPProgramInfoFuncParam( int structid )
{
	//		定義命令パラメーター生成
	//		structid : パラメーターID
	//
	const STRUCTDAT *fnc = GetFInfo( structid );
	const STRUCTPRM *prm = GetMInfo( fnc->prmindex );
	int max = fnc->prmmax;
	int locnum = 0;
	curprmindex = fnc->prmindex;

	for(int i=0;i<max;i++) {
		prmcnv_locvar[i] = -1;
		switch( prm[i].mptype ) {
		case MPTYPE_VAR:
			break;
		case MPTYPE_STRING:
		case MPTYPE_LOCALSTRING:
			break;
		case MPTYPE_DNUM:
			break;
		case MPTYPE_INUM:
			break;
		case MPTYPE_LABEL:
			break;
		case MPTYPE_LOCALVAR:
			prmcnv_locvar[i] = locnum;
			locnum++;
			break;
		case MPTYPE_ARRAYVAR:
			break;
		case MPTYPE_SINGLEVAR:
			break;
		default:
			break;
		}
	}

//	fnc->size = locnum;		// size項目にローカル変数の数を入れておく(runtimeで必要)
	curprmlocal = locnum;

	int prmid = locnum;
	for(int i=0;i<max;i++) {
		switch( prm[i].mptype ) {
		case MPTYPE_LOCALVAR:
			break;
		case MPTYPE_VAR:
		case MPTYPE_STRING:
		case MPTYPE_LOCALSTRING:
		case MPTYPE_DNUM:
		case MPTYPE_INUM:
		case MPTYPE_LABEL:
		case MPTYPE_ARRAYVAR:
		case MPTYPE_SINGLEVAR:
		default:
			prmcnv_locvar[i] = prmid;
			prmid++;
			break;
		}
	}
}

void CHsp3Op::MakeCPPLabel( void )
{
	//		ラベルを生成
	//
	int otmax;
	int labindex;
	int myot;

	otmax = GetOTCount();
	if ( otmax == 0 ) return;
	myot = (int)(mcs_last - mcs_start);

	labindex = 0;
	while(1) {
		if ( labindex>=otmax ) break;
		if ( myot == GetOT( labindex ) ) {
			if ( GetOTInfo( labindex ) == -1 ) {
				MakeCPPTask( labindex );
			} else {
				MakeCPPTask( labindex );
//				MakeProgramInfoFuncParam( GetOTInfo( labindex ) );
				MakeCPPProgramInfoFuncParam( GetOTInfo( labindex ) );
			}
		}
		labindex++;
	}
}


int CHsp3Op::GetCPPExpressionSub( bool addop, int flg )
{
	//		C/C++の計算式フォーマットでパラメーターを展開する(短項目)
	//
	int op;
	int cstype0 = cstype;
	int csval0 = csval;
	int vflag;

	vflag = 0;
	switch(cstype) {
		case TYPE_MARK:
			//		記号(スタックから取り出して演算)
			//
			op = csval;
			if ( reachable && addop ) {
				curTask->operations.push_back( new CalcOp( op ) );
			}
			getCS();
			break;
		case TYPE_VAR:
			{
			//		変数をスタックに積む
			//
			int va;
			getCS();
			//		配列要素を付加する
			va = MakeCPPVarExpression( addop );
			if ( reachable && addop ) {
				if ( flg == 1 && va == 0) {
					curTask->operations.push_back( new PushVarPtrOp( csval0, va ) );
				} else {
					curTask->operations.push_back( new PushVarOp( csval0, va ) );
				}
			}
			vflag = 1;
			break;
			}
		case TYPE_DNUM:
			{
			//		直実数値をスタックに積む
			//
			double immval = GetDSf( csval );
			if ( reachable && addop ) {
				curTask->operations.push_back( new PushDnumOp( immval ) );
			}
			getCS();
			break;
			}
		case TYPE_INUM:
		case TYPE_LABEL:
			//		直値をスタックに積む
			//
			if ( reachable && addop ) {
				switch (cstype0) {
				case TYPE_INUM:
					curTask->operations.push_back( new PushInumOp( csval ) );
					break;
				case TYPE_LABEL:
					curTask->operations.push_back( new PushLabelOp( csval ) );
					break;
				}
			}

			getCS();
			break;
		case TYPE_STRUCT:
			{
			//		パラメーターをスタックに積む
			//
			int va = 0;
			int prmid;
			const STRUCTPRM *prm = GetMInfo( csval );
			switch( prm->mptype ) {
			case MPTYPE_LOCALVAR:
				prmid = GetLocalPrm(csval);
				getCS();
				va = MakeCPPVarExpression( addop );
				vflag = 1;
				break;
			case MPTYPE_VAR:
			case MPTYPE_ARRAYVAR:
			case MPTYPE_SINGLEVAR:
				prmid = GetLocalPrm(csval);
				getCS();
				va = MakeCPPVarExpression( addop );
				vflag = 1;
				break;
			default:
				prmid = GetLocalPrm(csval);
				getCS();
				break;
			}
			if ( reachable && addop ) {
				if ( flg == 1 && vflag && va == 0 ) {
					curTask->operations.push_back( new PushFuncPrmPtrOp( csval0, prmid, va ) );
				} else {
					curTask->operations.push_back( new PushFuncPrmOp( csval0, prmid, va ) );
				}
			}
			break;
			}
		case TYPE_STRING:
			//		文字列をスタックに積む
			//
			if ( reachable && addop ) {
				curTask->operations.push_back( new PushStrOp( csval ) );
			}
			getCS();
			break;
#if 0
			// TODO
		case TYPE_MODCMD:
			{
			//		モジュール関数呼び出し
			//
			}
#endif
		case TYPE_SYSVAR:
			//		システム変数として展開する
			//
			if ( reachable && addop ) {
				curTask->operations.push_back( new PushCmdOp( cstype, csval, 0 ) );
			}
			getCS();
			break;
		default:
			{
			//		関数として展開する
			//
			int va;
			int fnctype;
			int fncval;
			fnctype = cstype;
			fncval = csval;
			getCS();
			//		引数を付加する
			if ( reachable && addop ) {
				curTask->operations.push_back( new PushFuncEndOp() );
			}

			va = MakeCPPVarExpression( addop, 1, IsFuncValueParam( fnctype, fncval ) );

			if ( reachable && addop ) {
				curTask->operations.push_back( new PushCmdOp( fnctype, fncval, va ) );
			}
			break;
			}
	}
	return vflag;
}


int CHsp3Op::GetCPPExpression( int *result, bool addop, int flg )
{
	//		C/C++の計算式フォーマットでパラメーターを展開する
	//		result : 結果の格納先(-2=解析なし/-1=複数項の計算式/other=単一のパラメーターtype)
	//
	int res;
	int tres;

	*result = -2;

	if (exflag&EXFLG_1) return 1;				// パラメーター終端
	if (exflag&EXFLG_2) {						// パラメーター区切り(デフォルト時)
		exflag^=EXFLG_2;
		return -1;
	}
	if ( cstype == TYPE_MARK ) {
		if ( csval == 63 ) {					// パラメーター省略時('?')
			getCS();
			exflag&=~EXFLG_2;
			return -1;
		}
		if ( csval == ')' ) {					// 関数内のパラメーター省略時
			exflag&=~EXFLG_2;
			return 2;
		}
	}

	res = 0;
	tres = cstype;

	while(1) {
		if ( mcs > mcs_end ) {
			res = 1;			// データ終端チェック
			break;
		}

		switch(cstype) {
		case TYPE_MARK:
			//		記号(スタックから取り出して演算)
			//
			if ( csval == ')' ) {					// 引数の終了マーク
				exflag |= EXFLG_2;
				res = 2;
				break;
			}
		default:
			if ( tres >= 0 ) {
				if ( tres != cstype ) { tres = -1; }
			}
			GetCPPExpressionSub( addop, flg );
			break;
		}

		if ( exflag ) {								// パラメーター終端チェック
			exflag&=~EXFLG_2;
			break;
		}
	}
	*result = tres;
	return res;
}


int CHsp3Op::MakeCPPParam( bool addop, int addprm, bool varval )
{
	//		パラメーターのトレース
	//
	int i;
	int prm;
	int result;
	std::vector<std::pair<MCSCONTEXT, int> > expressionContext;
	int ret = 0;

	prm = 0;

	int j;
	for(j=0;j<addprm;j++) {
		if ( exflag & EXFLG_1) break;		// パラメーター列終端
		if ( mcs > mcs_end ) break;			// データ終端チェック
		if ( prm ) {
		}

		MCSCONTEXT ctx;
		GetContext( &ctx );
		GetCPPExpressionSub( NULL );
		expressionContext.push_back( std::make_pair( ctx, -3 ) );
		prm++;
	}

	while(1) {
		if ( exflag & EXFLG_1) break;		// パラメーター列終端
		if ( mcs > mcs_end ) break;			// データ終端チェック
		if ( prm ) {
		}
		MCSCONTEXT ctx;
		GetContext( &ctx );
		ret = i = GetCPPExpression( &result, false );
		expressionContext.push_back( std::make_pair( ctx, result ) );
		if ( i > 0 ) break;
		if ( i < -1 ) break;
		if ( i == -1 ) {
			expressionContext.push_back( std::make_pair( ctx, -4 ) );
		}
		prm++;
	}

	// TODO
	MCSCONTEXT ctx;
	GetContext( &ctx );
	for ( int j = expressionContext.size() - 1; j >= 0; j-- ) {
		std::pair<MCSCONTEXT, int> &p = expressionContext[j];
		SetContext( &p.first );
		if ( p.second == -3 ) {
			GetCPPExpressionSub( addop );
		} else if ( p.second == -4 ) {
			if ( reachable && addop ) {
				curTask->operations.push_back( new PushDefaultOp() );
			}
		} else {
			if ( !varval && (p.second == TYPE_VAR || p.second == TYPE_STRUCT) ) {			// 単一項で変数が指定されていた場合
				i = GetCPPExpression( &result, addop, 1 );
			} else {
				i = GetCPPExpression( &result, addop );
			}
			if ( i == -1 ) {
			}
		}
	}
	SetContext( &ctx );

	if ( ret < -1 )
		return ret;

	return prm;
}


int CHsp3Op::GetVarExpressionOp( void )
{
	//		(同時に代入の種類を識別して返す)
	//		(retval:-1=通常代入、-2,-3=++or--、その他=演算子)
	//
	int i;
	int op;
	char arbuf[VAREXP_BUFFER_MAX];
	i = GetHSPVarExpression( arbuf );
	if ( cstype == TYPE_MARK ) {
		if ( csval == CALCCODE_EQ ) {
			return -1;
		}
		op = csval;
		getCS();
		if ( exflag & EXFLG_1) {		// ++ or --
			if ( op == CALCCODE_ADD ) return -2;
			return -3;
		}
		return op;
	}
	Alert( "CHsp3:Var Syntax unknown." );
	return -4;
}


int CHsp3Op::MakeCPPVarExpression( bool addop, int flg, bool varval )
{
	//	変数名直後に続くパラメーター(配列)を展開する
	//	ret : 0=配列なし/1～=配列あり
	//
	int i;
	int prm;
	int result;
	int ret = 0;
	std::vector<std::pair<MCSCONTEXT, int> > expressionContext;

	if ( cstype == TYPE_MARK ) {
		if ( csval == '(' ) {
			getCS();
			prm = 1;
			while(1) {
				if ( exflag & EXFLG_1) break;		// パラメーター列終端
				if ( mcs > mcs_end ) break;			// データ終端チェック

				MCSCONTEXT ctx;
				GetContext( &ctx );
				ret = i = GetCPPExpression( &result, false );
				expressionContext.push_back( std::make_pair( ctx, result ) );
				if ( i > 0 ) break;
				if ( i < -1 ) break;
				if ( i == -1 ) {
					expressionContext.push_back( std::make_pair( ctx, -4 ) );
				}
				prm++;
			}

			MCSCONTEXT ctx;
			GetContext( &ctx );
			for(int j = expressionContext.size() - 1; j >= 0; j--) {
				std::pair<MCSCONTEXT, int> &p = expressionContext[j];
				if ( p.second == -4 ) {
					if ( reachable && addop ) {
						curTask->operations.push_back( new PushDefaultOp() );
					}
				} else {
					SetContext( &p.first );
//					if ( p.second == TYPE_VAR ) {			// 単一項で変数が指定されていた場合
					if ( !varval && p.second != -1 && flg ) {
						i = GetCPPExpression( &result, addop, 1 );
					} else {
						i = GetCPPExpression( &result, addop );
					}
//i = GetCPPExpression( &result, addop );
					if ( i == -1 ) {
						if ( reachable && addop ) {
							curTask->operations.push_back( new PushDefaultOp() );
						}
					}
				}
			}
			SetContext( &ctx );

			if (ret < -1)
				return ret;

			getCS();

			return prm;
		}
	}
	return 0;
}


/*------------------------------------------------------------*/

void CHsp3Op::MakeCPPSub( int cmdtype, int cmdval )
{
	//		通常命令とパラメーターを展開
	//
	int pnum;

	getCS();
	pnum = MakeCPPParam( true, 0, IsFuncValueParam( cmdtype, cmdval ) );

	if ( reachable ) {
		curTask->operations.push_back( new CmdOp( cmdtype, cmdval, pnum ) );
	}
}


int CHsp3Op::MakeCPPMain( void )
{
	//		プログラムのトレース
	//
	int i;
	int op;
	int cmdtype, cmdval;
	MCSCONTEXT ctxbak, ctxbak2;
	int maxvar;

	//		初期化
	//
	tasknum = 0;

	MakeCPPTask( -1, "__HspEntry" );

	maxvar = hsphed->max_val;

	//		コードの変換
	//
	while(1) {
		if ( mcs > mcs_end ) break;

		//		endifのチェック
		//
		if ( ifmode[iflevel]>=2 ) {		// if end
			if ( mcs_last>=ifptr[iflevel] ) {
				ifmode[iflevel] = 0;
				if ( iflevel == 0 ) { Alert( "Invalid endif." ); return -1; }
				i = iftaskid[iflevel];
				iflevel--;
				//SetIndent( iflevel );
				MakeCPPTask( i );
				continue;
			}
		}

		//		ラベルチェック
		//
		MakeCPPLabel();

		//		行頭のコード
		//
		cmdtype = cstype;
		cmdval = csval;
		//MakeProgramInfoHSPName();
		//printf( "#%06x:CSTYPE%d VAL%d\n", mcs_last - mcs_start, cstype, csval );
		//Alert( mes );
		//out->PutStr( mes );

		//		パラメーター
		//
		switch( cmdtype ) {
		case TYPE_STRUCT:						// 代替変数(struct)
		case TYPE_VAR:							// 変数代入
			{
			int va,pnum;
			int varid;
			switch ( cmdtype ) {
			case TYPE_VAR:
				{
				varid = cmdval;
				break;
				}
			case TYPE_STRUCT:
				{
				const STRUCTPRM *prm = GetMInfo( csval );
				switch( prm->mptype ) {
				case MPTYPE_LOCALVAR:
					varid = GetLocalPrm(cmdval);
					break;
				case MPTYPE_VAR:
				case MPTYPE_ARRAYVAR:
				case MPTYPE_SINGLEVAR:
					varid = GetFuncPrm(cmdval);
					break;
				default:
					varid = GetFuncPrm(cmdval);
					break;
				}
				break;
				}
			}

			getCS();
			GetContext( &ctxbak );
			va = MakeCPPVarExpression( false );

			if ( cstype != TYPE_MARK ) {
				break;// エラー
			}

			if ( csval == CALCCODE_EQ ) {
				op = -1;
				getCS();
			} else {
				int op2 = csval;
				getCS();
				if ( exflag & EXFLG_1) {		// ++ or --
					if ( op2 == CALCCODE_ADD )
						op = -2;
					else
						op = -3;
				} else {
					op = op2;
				}
			}

			switch( op ) {
			case -1:		// 通常の代入
				pnum = MakeCPPParam( true );

				if ( reachable ) {
					GetContext( &ctxbak2 );
					SetContext( &ctxbak );
					MakeCPPVarExpression( true );
					SetContext( &ctxbak2 );

					curTask->operations.push_back( new VarSetOp( cmdtype, cmdval, varid, va, pnum ) );
				}
				break;
			case -2:		// ++
				if ( reachable ) {
					GetContext( &ctxbak2 );
					SetContext( &ctxbak );
					MakeCPPVarExpression( true );
					SetContext( &ctxbak2 );

					curTask->operations.push_back( new VarIncOp( cmdtype, cmdval, varid, va ) );
				}
				break;
			case -3:		// --
				if ( reachable ) {
					GetContext( &ctxbak2 );
					SetContext( &ctxbak );
					MakeCPPVarExpression( true );
					SetContext( &ctxbak2 );

					curTask->operations.push_back( new VarDecOp( cmdtype, cmdval, varid, va ) );
				}
				break;
			case -4:		// エラー
				break;
			default:		// 演算子付き代入
				pnum = MakeCPPParam( true );
				if ( pnum > 1 ) {
					Alert( "Too much parameters(VarCalc)." );
				}
				if ( reachable ) {
					GetContext( &ctxbak2 );
					SetContext( &ctxbak );
					MakeCPPVarExpression( true );
					SetContext( &ctxbak2 );

					curTask->operations.push_back( new VarCalcOp( cmdtype, cmdval, varid, va, op ) );
				}
				break;
			}
			break;
			}
		case TYPE_CMPCMD:						// 比較命令
			{
			int thenTask = 0;
			// C形式の出力
			if ( cmdval == 0 ) {
				iflevel++;

				thenTask = curot;
				if ( iflevel >= MAX_IFLEVEL ) {
					Alert( "Stack( If ) overflow." );
					return -2;
				}

				ifmode[iflevel] = 1;
				iftaskid[iflevel] = curot;
				i = (int)*mcs;
				ifptr[iflevel] = mcs + i + 1;
				ifmode[iflevel]++;
				curot++;
			} else {
				ifmode[iflevel] = 3;
				i = (int)*mcs;
				ifptr[iflevel] = mcs + i + 1;
				//SetIndent( iflevel-1 );
				i = iftaskid[iflevel];
				MakeCPPTask2( curot, i );
				iftaskid[iflevel] = curot;
				curot++;
			}
			mcs++;
			getCS();
			MakeCPPParam( true );

			if ( cmdval == 0 ) {
				curTask->operations.push_back( new CompareOp( thenTask ) );
			} else {
			}
			//SetIndent( iflevel );
			}
			break;
		case TYPE_PROGCMD:						// プログラム制御命令
			switch( cmdval ) {
			case 0x00:								// goto
			case 0x02:								// return
			case 0x03:								// break
			case 0x05:								// loop
			case 0x06:								// continue
			case 0x0b:								// foreach
			case 0x0c:								// (hidden)foreach check
			case 0x10:								// end
			case 0x1b:								// assert
			case 0x11:								// stop
			case 0x19:								// on
				//		後にreturnを付ける
				//
				MakeCPPSub( cmdtype, cmdval );
				reachable = false;
				break;
			case 0x01:								// gosub
			case 0x18:								// exgoto
				//		gosubの展開
				//
				{
				int pnum;
				getCS();
				pnum = MakeCPPParam( true );
				if ( reachable ) {
					curTask->operations.push_back( new PushLabelOp( curot ) );
					curTask->operations.push_back( new CmdOp( cmdtype, cmdval, pnum+1 ) );
				}
				reachable = false;
				MakeCPPTask( curot );
				curot++;
				break;
				}
			case 0x04:								// repeat
				//		repeatの展開
				//
				{
				int pnum;
				getCS();
				pnum = MakeCPPParam( true, 1 );
				if ( reachable ) {
					curTask->operations.push_back( new PushLabelOp( curot ) );
					curTask->operations.push_back( new CmdOp( cmdtype, cmdval, pnum+1 ) );
				}
				reachable = false;
				MakeCPPTask( curot );
				curot++;
				break;
				}

			case 0x07:								// wait
			case 0x08:								// await
			case 0x17:								// run
				//		タスクを区切る
				//
				MakeCPPSub( cmdtype, cmdval );
				MakeCPPTask( curot );
				curot++;
				break;
			default:
				MakeCPPSub( cmdtype, cmdval );
				break;
			}
			break;
		case TYPE_MODCMD:						// 定義命令
			{
			int pnum;
			getCS();
			pnum = MakeCPPParam( true );
			if ( reachable ) {
				curTask->operations.push_back( new PushLabelOp( curot ) );
				curTask->operations.push_back( new ModCmdOp( cmdtype, cmdval, pnum ) );
			}
			reachable = false;
			MakeCPPTask( curot );
			curot++;
			break;
			}
		default:
			//		通常命令
			//
			MakeCPPSub( cmdtype, cmdval );
			break;
		}
	}

	return 0;
}

/*------------------------------------------------------------*/


int CHsp3Op::MakeSource( int option, void *ref )
{
	//	コンパイル処理
	//
	int i;
	int otmax;

	makeoption = option;

	//		初期化ファンクションを作成する
	//
	otmax = GetOTCount();
	curot = otmax;

	i = MakeCPPMain();
	if ( i ) return i;

	//		タスク(ラベル)テーブルを作成する
	//
	max_lab = curot;
	tasks["__HspEntry"]->id = max_lab;
//sDsBasePtr = GetDS( 0 );
	return 0;
}

void CHsp3Op::UpdateOpType(Block *block, const std::map<VarId, int>& varTypes) const
{
	for (auto op : block->operations) {
		op->compile = DEFAULT;
		op->flag = HSPVAR_FLAG_MAX;
	}

	for (auto op : block->operations) {
		switch (op->GetOpCode()) {
		case PUSH_VAR_OP:
		{
			const VarId &varId = ((PushVarOp*)op)->GetVarId();
			op->flag = varTypes.find(varId)->second;
			break;
		}
		case PUSH_VAR_PTR_OP:
		{
			const VarId &varId = ((PushVarPtrOp*)op)->GetVarId();
			op->flag = varTypes.find(varId)->second;
			break;
		}
		case PUSH_DNUM_OP:
			op->flag = HSPVAR_FLAG_DOUBLE;
			break;
		case PUSH_INUM_OP:
			op->flag = HSPVAR_FLAG_INT;
			break;
		case PUSH_LABEL_OP:
			op->flag = HSPVAR_FLAG_LABEL;
			break;
		case PUSH_STR_OP:
			op->flag = HSPVAR_FLAG_STR;
			break;
		case PUSH_FUNC_END_OP:
		case PUSH_FUNC_PARAM_PTR_OP:
			break;
		case PUSH_FUNC_PARAM_OP:
		{
			PushFuncPrmOp *prmop = (PushFuncPrmOp*)op;
			const VarId &varId = prmop->GetVarId();
			const STRUCTPRM *st = GetMInfo(prmop->GetVarNo());
			switch (st->mptype) {
			case MPTYPE_LOCALVAR:
				break;
			case MPTYPE_VAR:
			case MPTYPE_ARRAYVAR:
			case MPTYPE_SINGLEVAR:
				op->flag = varTypes.find(varId)->second;
				break;
			case MPTYPE_DNUM:
				op->flag = HSPVAR_FLAG_DOUBLE;
				break;
			case MPTYPE_INUM:
				op->flag = HSPVAR_FLAG_INT;
				break;
			}
			break;
		}
		case PUSH_CMD_OP:
		{
			PushCmdOp *pcop = (PushCmdOp*)op;
			int retType = GetFuncTypeRet(pcop->GetCmdType(),
				pcop->GetCmdVal(),
				pcop->GetCmdPNum());
			op->flag = retType;
			break;
		}
		case CALC_OP:
		{
			CalcOp *calc = (CalcOp*)op;
			int tflag = GetOpTypeRet(calc->GetCalcOp(),
				op->operands[1]->flag,
				op->operands[0]->flag);
			op->flag = tflag;
		}
			break;

		case VAR_INC_OP:
		case VAR_DEC_OP:
			break;

		case VAR_CALC_OP:
			break;
		case VAR_SET_OP:
			break;
		case COMPARE_OP:
			break;
		case CMD_OP:
			break;
		case MODCMD_OP:
			break;
		case TASK_SWITCH_OP:
			break;
		default:
			break;
		}
	}
}
