
//
//	HSP3 internal command
//	(内蔵コマンド・関数処理)
//	onion software/onitama 2004/6
//
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <time.h>

#include "hsp3config.h"

#ifdef HSPWIN
#include <windows.h>
#include <direct.h>
#endif

#include "hspwnd.h"
#include "supio.h"
#include "dpmread.h"
#include "strbuf.h"
#include "strnote.h"

#include "hsp3int.h"
#include "hsp3code.h"

/*------------------------------------------------------------*/
/*
		system data
*/
/*------------------------------------------------------------*/

static int *type;
static int *val;
static HSPCTX *ctx;			// Current Context
static HSPEXINFO *exinfo;	// Info for Plugins
static CStrNote note;

/*------------------------------------------------------------*/
/*
		interface
*/
/*------------------------------------------------------------*/

static char *note_update( void )
{
	char *p;
	if ( ctx->note_pval == NULL ) throw HSPERR_ILLEGAL_FUNCTION;
	p = (char *)HspVarCorePtrAPTR( ctx->note_pval, ctx->note_aptr );
	note.Select( p );
	return p;
}

// デストラクタで自動的に sbFree を呼ぶ
class CAutoSbFree {
public:
	CAutoSbFree(char **pptr);
	~CAutoSbFree();
	
private:
	// uncopyable;
	CAutoSbFree( CAutoSbFree const & );
	CAutoSbFree const & operator =( CAutoSbFree const & );

private:
	char **pptr_;
};

CAutoSbFree::CAutoSbFree(char **pptr)
 : pptr_(pptr)
{}

CAutoSbFree::~CAutoSbFree() {
	sbFree(*pptr_);
}

static void cnvformat_expand( char **p, int *capacity, int len, int n )
{
	int needed_size = len + n + 1;
	int capa = *capacity;
	if ( needed_size > capa ) {
		while ( needed_size > capa ) {
			capa *= 2;
		}
		*p = sbExpand( *p, capa );
		*capacity = capa;
	}
}

static char *cnvformat( void )
{
	//		フォーマット付き文字列を作成する
	//
#if ( WIN32 || _WIN32 ) && ! __CYGWIN__
#define SNPRINTF _snprintf
#else
#define SNPRINTF snprintf
#endif

	char fstr[1024];
	char *fp;
	int capacity;
	int len;
	char *p;
	
	strncpy( fstr, code_gets(), sizeof fstr );
	fstr[sizeof(fstr)-1] = '\0';
	fp = fstr;
	capacity = 1024;
	p = sbAlloc(capacity);
	len = 0;
	
	CAutoSbFree autofree(&p);
	
	while (1) {
		char fmt[32];
		int i;
		int val_type;
		void *val_ptr;

		// '%' までをコピー
		i = 0;
		while( fp[i] != '\0' && fp[i] != '%' ) {
			i ++;
		}
		cnvformat_expand( &p, &capacity, len, i );
		memcpy( p + len, fp, i );
		len += i;
		fp += i;
		if ( *fp == '\0' ) break;

		// 変換指定を読み fmt にコピー
		i = (int)strspn( fp + 1, " #+-.0123456789" ) + 1;
		strncpy( fmt, fp, sizeof fmt );
		fmt[sizeof(fmt)-1] = '\0';
		if ( i + 1 < (int)(sizeof fmt) ) fmt[i+1] = '\0';
		fp += i;

		char specifier = *fp;
		fp ++;

#if ( WIN32 || _WIN32 ) && ! __CYGWIN__
		if ( specifier == 'I' ) {				// I64 prefix対応(VC++のみ)
			if ((fp[0]=='6')&&(fp[1]='4')) {
				memcpy( fmt+i+1, fp, 3 );
				fmt[i+4] = 0;
				specifier = 'f';
				fp += 3;
			}
		}
#endif

		if ( specifier == '\0' ) break;
		if ( specifier == '%' ) {
			cnvformat_expand( &p, &capacity, len, 1 );
			p[len++] = '%';
			continue;
		}

		// 引数を取得
		if ( code_get() <= PARAM_END ) throw HSPERR_INVALID_FUNCPARAM;
		switch (specifier) {
		case 'd': case 'i': case 'c': case 'o': case 'x': case 'X': case 'u': case 'p':
			val_type = HSPVAR_FLAG_INT;
			val_ptr = HspVarCoreCnvPtr( mpval, HSPVAR_FLAG_INT );
			break;
		case 'f': case 'e': case 'E': case 'g': case 'G':
			val_type = HSPVAR_FLAG_DOUBLE;
			val_ptr = HspVarCoreCnvPtr( mpval, HSPVAR_FLAG_DOUBLE );
			break;
		case 's':
			val_type = HSPVAR_FLAG_STR;
			val_ptr = HspVarCoreCnvPtr( mpval, HSPVAR_FLAG_STR );
			break;
		default:
			throw HSPERR_INVALID_FUNCPARAM;
		}

		// snprintf が成功するまでバッファを広げていき、変換を行う
		while (1) {
			int n;
			int space = capacity - len - 1;
			if ( val_type == HSPVAR_FLAG_INT ) {
				n = SNPRINTF( p + len, space, fmt, *(int *)val_ptr );
			} else if ( val_type == HSPVAR_FLAG_DOUBLE ) {
				n = SNPRINTF( p + len, space, fmt, *(double *)val_ptr );
			} else {
				n = SNPRINTF( p + len, space, fmt, (char *)val_ptr );
			}

			if ( n >= 0 && n < space ) {
				len += n;
				break;
			}
			if ( n >= 0 ) {
				space = n + 1;
			} else {
				space *= 2;
				if ( space < 32 ) space = 32;
			}
			cnvformat_expand( &p, &capacity, len, space );
		}
	}
	p[len] = '\0';
	
	char *result = code_stmp(len + 1);
	strcpy(result, p);
	return result;
}


static void var_set_str_len( PVal *pval, APTR aptr, char *str, int len )
{
	//		変数にstrからlenバイトの文字列を代入する
	//
	HspVarProc *proc = HspVarCoreGetProc( HSPVAR_FLAG_STR );
	if ( pval->flag != HSPVAR_FLAG_STR ) {
		if ( aptr != 0 ) throw HSPERR_INVALID_ARRAYSTORE;
		HspVarCoreClear( pval, HSPVAR_FLAG_STR );
	}
	pval->offset = aptr;
	HspVarCoreAllocBlock( pval, proc->GetPtr( pval ), len + 1 );
	char *ptr = (char *)proc->GetPtr( pval );
	memcpy( ptr, str, len );
	ptr[len] = '\0';
}



static int cmdfunc_intcmd( int cmd )
{
	//		cmdfunc : TYPE_INTCMD
	//		(内蔵コマンド)
	//
	int p1,p2,p3;
	//
	code_next();							// 次のコードを取得(最初に必ず必要です)

	switch( cmd ) {							// サブコマンドごとの分岐

	case 0x00:								// onexit
	case 0x01:								// onerror
	case 0x02:								// onkey
	case 0x03:								// onclick
	case 0x04:								// oncmd
		{

/*
	rev 45
	不具合 : (onxxx系命令) (ラベル型変数)  形式の書式でエラー
	に対処
*/

		int tval = *type;
		int opt = IRQ_OPT_GOTO;
		int cust;
		int actid;
		IRQDAT *irq;
		unsigned short *sbr;

		if ( tval == TYPE_VAR ) {
			if ( ( ctx->mem_var + *val )->flag == HSPVAR_FLAG_LABEL )
				tval = TYPE_LABEL;
		}

		if (( tval != TYPE_PROGCMD )&&( tval != TYPE_LABEL )) {		// ON/OFF切り替え
			int i = code_geti();
			code_enableirq( cmd, i );
			break;
		}

		if ( tval == TYPE_PROGCMD ) {	// ジャンプ方法指定
			opt = *val;
			if ( opt >= 2 ) throw HSPERR_SYNTAX;
			code_next();
		}

		sbr = code_getlb2();
		if ( cmd != 0x04 ) {
			code_setirq( cmd, opt, -1, sbr );
			break;
		}
		cust = code_geti();
		actid = *(exinfo->actscr);
		irq = code_seekirq( actid, cust );
		if ( irq == NULL ) irq = code_addirq();
		irq->flag = IRQ_FLAG_ENABLE;
		irq->opt = opt;
		irq->ptr = sbr;
		irq->custom = cust;
		irq->custom2 = actid;
		break;
		}

	case 0x11:								// exist
	case 0x12:								// delete
	case 0x13:								// mkdir
	case 0x14:								// chdir
		code_event( HSPEVENT_FNAME, 0, 0, code_gets() );
		code_event( HSPEVENT_FEXIST + (cmd - 0x11), 0, 0, NULL );
		break;

	case 0x15:								// dirlist
		{
		PVal *pval;
		APTR aptr;
		char *ptr;
		aptr = code_getva( &pval );
		code_event( HSPEVENT_FNAME, 0, 0, code_gets() );
		p1=code_getdi(0);
		code_event( HSPEVENT_FDIRLIST1, p1, 0, &ptr );
		code_setva( pval, aptr, TYPE_STRING, ptr );
		code_event( HSPEVENT_FDIRLIST2, 0, 0, NULL );
		break;
		}
	case 0x16:								// bload
	case 0x17:								// bsave
		{
		PVal *pval;
		char *ptr;
		int size;
		int tmpsize;
		code_event( HSPEVENT_FNAME, 0, 0, code_gets() );
		ptr = code_getvptr( &pval, &size );
		p1 = code_getdi( -1 );
		p2 = code_getdi( -1 );
		if (( p1 < 0 )||( p1 > size )) p1 = size;
		if ( cmd == 0x16 ) {
			tmpsize = p2;if ( tmpsize<0 ) tmpsize = 0;
			code_event( HSPEVENT_FREAD, tmpsize, p1, ptr );
		} else {
			code_event( HSPEVENT_FWRITE, p2, p1, ptr );
		}
		break;
		}
	case 0x18:								// bcopy
		code_event( HSPEVENT_FNAME, 0, 0, code_gets() );
		code_event( HSPEVENT_FCOPY, 0, 0, code_gets() );
		break;
	case 0x19:								// memfile
		{
		PVal *pval;
		char *ptr;
		int size;
		ptr = code_getvptr( &pval, &size );
		p1=code_getdi( 0 );
		p2=code_getdi( 0 );
		if ( p2==0 ) p2 = size - p1;
		dpm_memfile( ptr+p1, p2 );
		break;
		}

	case 0x1a:								// poke
	case 0x1b:								// wpoke
	case 0x1c:								// lpoke
		{
		PVal *pval;
		char *ptr;
		int size;
		int fl;
		int len;
		char *bp;
		ptr = code_getvptr( &pval, &size );
		p1 = code_getdi( 0 );
		if ( p1<0 ) throw HSPERR_BUFFER_OVERFLOW;
		ptr += p1;

		if ( code_get() <= PARAM_END ) {
			fl = HSPVAR_FLAG_INT;
			bp = (char *)&p2; p2 = 0;
		} else {
			fl = mpval->flag;
			bp = mpval->pt;
		}

		if ( cmd == 0x1a ) {
			switch( fl ) {
			case HSPVAR_FLAG_INT:
				if ( p1 >= size ) throw HSPERR_BUFFER_OVERFLOW;
				*ptr = *bp;
				break;
			case HSPVAR_FLAG_STR:
				len = (int)strlen( bp );
				ctx->strsize = len;
				len++;
				if ( (p1+len)>size ) throw HSPERR_BUFFER_OVERFLOW;
				strcpy( ptr, bp );
				break;
			default:
				throw HSPERR_TYPE_MISMATCH;
			}
			break;
		}

		if ( fl != HSPVAR_FLAG_INT ) throw HSPERR_TYPE_MISMATCH;
		if ( cmd == 0x1b ) {
			if ( (p1+2)>size ) throw HSPERR_BUFFER_OVERFLOW;
			*(short *)ptr = (short)(*(short *)bp);
		} else {
			if ( (p1+4)>size ) throw HSPERR_BUFFER_OVERFLOW;
			*(int *)ptr = (*(int *)bp);
		}
		break;
		}

	case 0x1d:								// getstr
		{
		PVal *pval2;
		PVal *pval;
		APTR aptr;
		char *ptr;
		char *p;
		int size;
		aptr = code_getva( &pval );
		ptr = code_getvptr( &pval2, &size );
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		p3 = code_getdi( 1024 );
		if ( p1 >= size ) throw HSPERR_BUFFER_OVERFLOW;
		ptr += p1;
		p = code_stmp( p3 + 1 );
		strsp_ini();
		ctx->stat = strsp_get( ptr, p, p2, p3 );
		ctx->strsize = strsp_getptr();
		code_setva( pval, aptr, HSPVAR_FLAG_STR, p );
		break;
		}
	case 0x1e:								// chdpm
		code_event( HSPEVENT_FNAME, 0, 0, code_gets() );
		p1 = code_getdi( -1 );
		dpm_bye();
		p2 = dpm_ini( ctx->fnbuffer, 0, -1, p1 );
		if ( p2 ) throw HSPERR_FILE_IO;
#ifndef HSP3IMP
#ifdef HSPWIN
		Sleep( 1000 );
#endif
#endif
		break;
	case 0x1f:								// memexpand
		{
		PVal *pval;
		APTR aptr;
		PDAT *ptr;
		aptr = code_getva( &pval );
		ptr = HspVarCorePtrAPTR( pval, aptr );
		if (( pval->support & HSPVAR_SUPPORT_FLEXSTORAGE ) == 0 ) throw HSPERR_TYPE_MISMATCH;
		p1 = code_getdi( 0 );
		if ( p1 < 64 ) p1 = 64;
		HspVarCoreAllocBlock( pval, ptr, p1 );
		break;
		}

	case 0x20:								// memcpy
		{
		PVal *pval;
		char *sptr;
		char *tptr;
		int bufsize_t,bufsize_s;

		tptr = code_getvptr( &pval, &bufsize_t );
		sptr = code_getvptr( &pval, &bufsize_s );
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		p3 = code_getdi( 0 );
		if( p2 < 0 || p3 < 0 ) throw HSPERR_BUFFER_OVERFLOW;

		tptr += p2;
		sptr += p3;
		if ( (p1+p2)>bufsize_t ) throw HSPERR_BUFFER_OVERFLOW;
		if ( (p1+p3)>bufsize_s ) throw HSPERR_BUFFER_OVERFLOW;
		if ( p1>0 ) {
			memmove( tptr, sptr, p1 );
		}
		break;
		}
	case 0x21:								// memset
		{
		PVal *pval;
		char *ptr;
		int size;
		ptr = code_getvptr( &pval, &size );
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		p3 = code_getdi( 0 );
		if ( p3 < 0 ) throw HSPERR_BUFFER_OVERFLOW;
		ptr += p3;
		if ( (p3+p2)>size ) throw HSPERR_BUFFER_OVERFLOW;
		if ( p2>0 ) {
			memset( ptr, p1, p2 );
		}
		break;
		}

	case 0x22:								// notesel
		ctx->notep_aptr = ctx->note_aptr;
		ctx->notep_pval = ctx->note_pval;
		ctx->note_aptr = code_getva( &ctx->note_pval );
		if ( ctx->note_pval->flag != HSPVAR_FLAG_STR ) {
			code_setva( ctx->note_pval, ctx->note_aptr, TYPE_STRING, "" );
		}
		break;
	case 0x23:								// noteadd
		{
		char *np;
		char *ps;
		char *tmp;
		int size;
		np = note_update();
		ps = code_gets();
		size = (int)strlen( ps ) + 8;
		HspVarCoreAllocBlock( ctx->note_pval, (PDAT *)np, (int)strlen(np) + size );

		tmp = sbAlloc( size );
		strcpy( tmp, ps );

		p1 = code_getdi( -1 );
		p2 = code_getdi( 0 );
		np = note_update();
		note.PutLine( tmp, p1, p2 );
		sbFree( tmp );
		break;
		}
	case 0x24:								// notedel
		p1 = code_getdi( 0 );
		note_update();
		note.PutLine( NULL, p1, 1 );
		break;
	case 0x25:								// noteload
		{
		int size;
		char *ptr;
		char *pdat;

		code_event( HSPEVENT_FNAME, 0, 0, code_gets() );
		p1 = code_getdi( -1 );
		code_event( HSPEVENT_FEXIST, 0, 0, NULL );
		size = ctx->strsize;
		if ( size < 0 ) throw HSPERR_FILE_IO;
		if ( p1>=0 ) if ( size >= p1 ) { ctx->strsize = size = p1; }

		pdat = note_update();
		HspVarCoreAllocBlock( ctx->note_pval, (PDAT *)pdat, size+1 );
		ptr = (char *)note_update();
		code_event( HSPEVENT_FREAD, 0, size, ptr );
		ptr[size] = 0;
		break;
		}
	case 0x26:								// notesave
		{
		char *pdat;
		int size;
		code_event( HSPEVENT_FNAME, 0, 0, code_gets() );
		pdat = note_update();
		size = (int)strlen( pdat );
		code_event( HSPEVENT_FWRITE, -1, size, pdat );
		break;
		}
	case 0x27:								// randomize
#ifdef HSPWIN
		p2 = (int)GetTickCount();	// Windowsの場合はtickをシード値とする
#else
		p2 = (int)time(0);			// Windows以外のランダムシード値
#endif
		p1 = code_getdi( p2 );
		srand( p1 );
		break;
	case 0x28:								// noteunsel
		ctx->note_aptr = ctx->notep_aptr;
		ctx->note_pval = ctx->notep_pval;
		break;
	case 0x29:								// noteget
		{
		PVal *pval;
		APTR aptr;
		char *p;
		note_update();
		aptr = code_getva( &pval );
		p1 = code_getdi( 0 );
		p = note.GetLineDirect( p1 );
		code_setva( pval, aptr, TYPE_STRING, p );
		note.ResumeLineDirect();
		break;
		}
	case 0x2a:								// split
		{
		//	指定した文字列で分割された要素を代入する(fujidig)
		PVal *pval = NULL;
		int aptr = 0;
		char *sptr;
		char *sep;
		char *newsptr;
		int size;
		int sep_len;
		int n = 0;
		int is_last = 0;
		
		sptr = code_getvptr( &pval, &size );
		if ( pval->flag != HSPVAR_FLAG_STR ) throw HSPERR_TYPE_MISMATCH;
		sep = code_gets();
		sep_len = (int)strlen( sep );
		
		while (1) {
			newsptr = strstr2( sptr, sep );
			if ( !is_last && *exinfo->npexflg & EXFLG_1 ) {
				// 分割結果の数が格納する変数より多ければ最後の変数に配列で格納していく
				// ただし最後の要素が a.2 のように要素指定があればそれ以降は全く格納しない
				if ( aptr != 0 ) pval = NULL;
				is_last = 1;
				aptr = 0;
			}
			if ( is_last ) {
				aptr ++;
				if ( pval != NULL && aptr >= pval->len[1] ) {
					if ( pval->len[2] != 0 ) throw HSPVAR_ERROR_ARRAYOVER;
					HspVarCoreReDim( pval, 1, aptr+1 );
				}
			} else {
				aptr = code_getva( &pval );
			}
			if ( pval != NULL ) {
				if ( newsptr == NULL ) {
					code_setva( pval, aptr, HSPVAR_FLAG_STR, sptr );
				} else {
					var_set_str_len( pval, aptr, sptr, (int)(newsptr - sptr) );
				}
			}
			n ++;
			if ( newsptr == NULL ) {
				// 格納する変数の数が分割できた数より多ければ残った変数それぞれに空文字列を格納する
				while( ( *exinfo->npexflg & EXFLG_1 ) == 0 ) {
					aptr = code_getva( &pval );
					code_setva( pval, aptr, HSPVAR_FLAG_STR, "" );
				}
				break;
			}
			sptr = newsptr + sep_len;
		}
		ctx->stat = n;
		break;
		}


	default:
		throw HSPERR_UNSUPPORTED_FUNCTION;
	}
	return RUNMODE_RUN;
}

static int reffunc_intfunc_ivalue;
static double reffunc_intfunc_value;

static void *reffunc_intfunc( int *type_res, int arg )
{
	//		reffunc : TYPE_INTFUNC
	//		(内蔵関数)
	//
	void *ptr;
	int chk;
	double dval;
	double dval2;
	int ival;
	char *sval;
	int p1,p2,p3;

	//			'('で始まるかを調べる
	//
	if ( *type != TYPE_MARK ) throw HSPERR_INVALID_FUNCPARAM;
	if ( *val != '(' ) throw HSPERR_INVALID_FUNCPARAM;
	code_next();

	//		返値のタイプをargをもとに設定する
	//		0～255   : int
	//		256～383 : string
	//		384～511 : double
	//
	switch( arg>>7 ) {
		case 2:										// 返値がstr
			*type_res = HSPVAR_FLAG_STR;			// 返値のタイプを指定する
			ptr = NULL;								// 返値のポインタ
			break;
		case 3:										// 返値がdouble
			*type_res = HSPVAR_FLAG_DOUBLE;			// 返値のタイプを指定する
			ptr = &reffunc_intfunc_value;			// 返値のポインタ
			break;
		default:									// 返値がint
			*type_res = HSPVAR_FLAG_INT;			// 返値のタイプを指定する
			ptr = &reffunc_intfunc_ivalue;			// 返値のポインタ
			break;
	}

	switch( arg ) {

	//	int function
	case 0x000:								// int
		{
		int *ip;
		chk = code_get();
		if ( chk <= PARAM_END ) { throw HSPERR_INVALID_FUNCPARAM; }
		ip = (int *)HspVarCoreCnvPtr( mpval, HSPVAR_FLAG_INT );
		reffunc_intfunc_ivalue = *ip;
		break;
		}
	case 0x001:								// rnd
		ival = code_geti();
		if ( ival == 0 ) throw HSPERR_DIVIDED_BY_ZERO;
		reffunc_intfunc_ivalue = rand()%ival;
		break;
	case 0x002:								// strlen
		sval = code_gets();
		reffunc_intfunc_ivalue = (int) strlen( sval );
		break;

	case 0x003:								// length(3.0)
	case 0x004:								// length2(3.0)
	case 0x005:								// length3(3.0)
	case 0x006:								// length4(3.0)
		{
		PVal *pv;
		pv = code_getpval();
		reffunc_intfunc_ivalue = pv->len[ arg - 0x002 ];
		break;
		}

	case 0x007:								// vartype(3.0)
		{
		PVal *pv;
		HspVarProc *proc;
		if ( *type == TYPE_STRING ) {
			sval = code_gets();
			proc = HspVarCoreSeekProc( sval );
			if ( proc == NULL ) throw HSPERR_ILLEGAL_FUNCTION;
			reffunc_intfunc_ivalue = proc->flag;
		} else {
			code_getva( &pv );
			reffunc_intfunc_ivalue = pv->flag;
		}
		break;
		}

	case 0x008:								// gettime
		ival = code_geti();
		reffunc_intfunc_ivalue = gettime( ival );
		break;

	case 0x009:								// peek
	case 0x00a:								// wpeek
	case 0x00b:								// lpeek
		{
		PVal *pval;
		char *ptr;
		int size;
		ptr = code_getvptr( &pval, &size );
		p1 = code_getdi( 0 );
		if ( p1<0 ) throw HSPERR_ILLEGAL_FUNCTION;
		ptr += p1;
		if ( arg == 0x09 ) {
			if ( (p1+1)>size ) throw HSPERR_ILLEGAL_FUNCTION;
			reffunc_intfunc_ivalue = ((int)(*ptr)) & 0xff;
		} else if ( arg == 0x0a ) {
			if ( (p1+2)>size ) throw HSPERR_ILLEGAL_FUNCTION;
			reffunc_intfunc_ivalue = ((int)(*(short *)ptr)) & 0xffff;
		} else {
			if ( (p1+4)>size ) throw HSPERR_ILLEGAL_FUNCTION;
			reffunc_intfunc_ivalue = *(int *)ptr;
		}
		break;
		}
	case 0x00c:								// varptr
		{
		PVal *pval;
		APTR aptr;
		PDAT *pdat;
		STRUCTDAT *st;
		if ( *type == TYPE_DLLFUNC ) {
			st = &(ctx->mem_finfo[ *val ]);
			reffunc_intfunc_ivalue = (int)(st->proc);
			code_next();
			break;
		}
		aptr = code_getva( &pval );
		pdat = HspVarCorePtrAPTR( pval, aptr );
		reffunc_intfunc_ivalue = (int)(pdat);
		break;
		}
	case 0x00d:								// varuse
		{
		PVal *pval;
		APTR aptr;
		PDAT *pdat;
		aptr = code_getva( &pval );
		if ( pval->support & HSPVAR_SUPPORT_VARUSE ) {
			pdat = HspVarCorePtrAPTR( pval, aptr );
			reffunc_intfunc_ivalue = HspVarCoreGetUsing( pval, pdat );
		} else throw HSPERR_TYPE_MISMATCH;
		break;
		}
	case 0x00e:								// noteinfo
		ival = code_getdi(0);
		note_update();
		switch( ival ) {
		case 0:
			reffunc_intfunc_ivalue = note.GetMaxLine();
			break;
		case 1:
			reffunc_intfunc_ivalue = note.GetSize();
			break;
		default:
			throw HSPERR_ILLEGAL_FUNCTION;
		}
		break;

	case 0x00f:								// instr
		{
		PVal *pval;
		char *ptr;
		char *ps;
		char *ps2;
		int size;
		int p1;
		ptr = code_getvptr( &pval, &size );
		if ( pval->flag != HSPVAR_FLAG_STR ) throw HSPERR_TYPE_MISMATCH;
		p1 = code_getdi(0);
		if ( p1 >= size ) throw HSPERR_BUFFER_OVERFLOW;
		ps = code_gets();
		if ( p1 >= 0 ) {
			ptr += p1;
			ps2 = strstr2( ptr, ps );
		} else {
			ps2 = NULL;
		}
		if ( ps2 == NULL ) {
			reffunc_intfunc_ivalue = -1;
		} else {
			reffunc_intfunc_ivalue = (int)(ps2 - ptr);
		}
		break;
		}

	case 0x010:								// abs
		reffunc_intfunc_ivalue = code_geti();
		if ( reffunc_intfunc_ivalue < 0 ) reffunc_intfunc_ivalue = -reffunc_intfunc_ivalue;
		break;

	case 0x011:								// limit
		p1 = code_geti();
		p2 = code_geti();
		p3 = code_geti();
		reffunc_intfunc_ivalue = GetLimit( p1, p2, p3 );
		break;


	// str function
	case 0x100:								// str
		{
		char *sp;
		chk = code_get();
		if ( chk <= PARAM_END ) { throw HSPERR_INVALID_FUNCPARAM; }
		sp = (char *)HspVarCoreCnvPtr( mpval, HSPVAR_FLAG_STR );
		ptr = (void *)sp;
		break;
		}
	case 0x101:								// strmid
		{
		PVal *pval;
		char *sptr;
		char *p;
		char chrtmp;
		int size;
		int i;
		int slen;
		sptr = code_getvptr( &pval, &size );
		if ( pval->flag != HSPVAR_FLAG_STR ) throw HSPERR_TYPE_MISMATCH;
		p1 = code_geti();
		p2 = code_geti();

		slen=(int)strlen( sptr );
		if ( p1 < 0 ) {
			p1=slen - p2;
			if ( p1 < 0 ) p1 = 0;
		}
		if ( p1 >= slen )
			p2 = 0;
		if ( p2 > slen ) p2 = slen;
		sptr += p1;
		ptr = p = code_stmp( p2 + 1 );
		for(i=0;i<p2;i++) {
			chrtmp = *sptr++;
			*p++ = chrtmp;
			if (chrtmp==0) break;
		}
		*p = 0;
		break;
		}

	case 0x103:								// strf
		ptr = cnvformat();
		break;
	case 0x104:								// getpath
		{
		char *p;
		char pathname[HSP_MAX_PATH];
		p = ctx->stmp;
		strncpy( pathname, code_gets(), HSP_MAX_PATH-1 );
		p1=code_geti();
		getpath( pathname, p, p1 );
		ptr = p;
		break;
		}
	case 0x105:								// strtrim
		{
		PVal *pval;
		char *sptr;
		char *p;
		int size;
		sptr = code_getvptr( &pval, &size );
		if ( pval->flag != HSPVAR_FLAG_STR ) throw HSPERR_TYPE_MISMATCH;
		p1 = code_getdi(0);
		p2 = code_getdi(32);
		ptr = p = code_stmp( size + 1 );
		strcpy( p, sptr );
		switch( p1 ) {
		case 0:
			TrimCodeL( p, p2 );
			TrimCodeR( p, p2 );
			break;
		case 1:
			TrimCodeL( p, p2 );
			break;
		case 2:
			TrimCodeR( p, p2 );
			break;
		case 3:
			TrimCode( p, p2 );
			break;
		}
		break;
		}

	//	double function
	case 0x180:								// sin
		dval = code_getd();
		reffunc_intfunc_value = sin( dval );
		break;
	case 0x181:								// cos
		dval = code_getd();
		reffunc_intfunc_value = cos( dval );
		break;
	case 0x182:								// tan
		dval = code_getd();
		reffunc_intfunc_value = tan( dval );
		break;
	case 0x183:								// atan
		dval = code_getd();
		dval2 = code_getdd( 1.0 );
		reffunc_intfunc_value = atan2( dval, dval2 );
		break;
	case 0x184:								// sqrt
		dval = code_getd();
		reffunc_intfunc_value = sqrt( dval );
		break;
	case 0x185:								// double
		{
		double *dp;
		chk = code_get();
		if ( chk <= PARAM_END ) { throw HSPERR_INVALID_FUNCPARAM; }
		dp = (double *)HspVarCoreCnvPtr( mpval, HSPVAR_FLAG_DOUBLE );
		reffunc_intfunc_value = *dp;
		break;
		}
	case 0x186:								// absf
		reffunc_intfunc_value = code_getd();
		if ( reffunc_intfunc_value < 0 ) reffunc_intfunc_value = -reffunc_intfunc_value;
		break;
	case 0x187:								// expf
		dval = code_getd();
		reffunc_intfunc_value = exp( dval );
		break;
	case 0x188:								// logf
		dval = code_getd();
		reffunc_intfunc_value = log( dval );
		break;
	case 0x189:								// limitf
		{
		double d1,d2,d3;
		d1 = code_getd();
		d2 = code_getd();
		d3 = code_getd();
		if ( d1 < d2 ) d1 = d2;
		if ( d1 > d3 ) d1 = d3;
		reffunc_intfunc_value = d1;
		break;
		}
	case 0x18a:								// powf
		dval = code_getd();
		dval2 = code_getd();
		reffunc_intfunc_value = powf( dval, dval2 );
		break;

	default:
		throw HSPERR_UNSUPPORTED_FUNCTION;
	}

	//			')'で終わるかを調べる
	//
	if ( *type != TYPE_MARK ) throw HSPERR_INVALID_FUNCPARAM;
	if ( *val != ')' ) throw HSPERR_INVALID_FUNCPARAM;
	code_next();

	return ptr;
}




/*------------------------------------------------------------*/
/*
		controller
*/
/*------------------------------------------------------------*/

static int termfunc_intcmd( int option )
{
	//		termfunc : TYPE_INTCMD
	//		(内蔵)
	//
	return 0;
}

void hsp3typeinit_intcmd( HSP3TYPEINFO *info )
{
	ctx = info->hspctx;
	exinfo = info->hspexinfo;
	type = exinfo->nptype;
	val = exinfo->npval;

	info->cmdfunc = cmdfunc_intcmd;
	info->termfunc = termfunc_intcmd;
}

void hsp3typeinit_intfunc( HSP3TYPEINFO *info )
{
	info->reffunc = reffunc_intfunc;
}


