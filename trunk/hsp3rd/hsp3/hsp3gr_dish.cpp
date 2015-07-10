
//
//	HSP3 dish graphics command
//	(GUI関連コマンド・関数処理)
//	onion software/onitama 2011/3
//
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "../hsp3/hsp3config.h"

#ifdef HSPWIN
#include <windows.h>
#include <direct.h>
#include <shlobj.h>
#endif

#include "../hsp3/hsp3code.h"
#include "../hsp3/hsp3debug.h"
#include "../hsp3/strbuf.h"

#include "hsp3gr.h"
#include "hspwnd.h"
#include "hgio.h"
#include "supio.h"
#include "sysreq.h"

#ifdef HSPWIN
#include "win32/dxsnd.h"
#endif

#define USE_MMAN
//#define USE_DGOBJ

/*------------------------------------------------------------*/
/*
		system data
*/
/*------------------------------------------------------------*/

static HspWnd *wnd;
static Bmscr *bmscr;
static HSPCTX *ctx;
static int *type;
static int *val;
static int cur_window;
static int p1,p2,p3,p4,p5,p6,p7;
static int ckey,cklast,cktrg;
static int msact;
static int dispflg;

extern int resY0, resY1;

#ifdef USE_MMAN
#ifdef HSPWIN
#include "win32/mmman.h"
#endif
#ifdef HSPIOS
#include "ios/mmman.h"
#endif
#ifdef HSPNDK
#include "ndk/mmman.h"
#endif

static MMMan *mmman;
#endif

static int dxsnd_flag;


#ifdef USE_DGOBJ
#include "hgdx.h"
static hgdx *hg;
static VECTOR *sel_vector;
static double dp1,dp2,dp3;
static int movemode[MOC_MAX];
static double *p_vec;
static VECTOR p_vec1;
static VECTOR p_vec2;

#define CnvIntRot(val) ((float)val)*(PI2/256.0f)
#define CnvRotInt(val) ((int)(val*(256.0f/PI2)))

#define MOVEMODE_LINEAR 0
#define MOVEMODE_SPLINE 1
#define MOVEMODE_LINEAR_REL 2
#define MOVEMODE_SPLINE_REL 3

#endif


/*----------------------------------------------------------*/
//					HSP system support
/*----------------------------------------------------------*/

static void ExecFile( char *stmp, char *ps, int mode )
{
	//	外部ファイル実行
	hgio_exec( stmp, ps, mode );
}
		
static char *getdir( int id )
{
	//		dirinfo命令の内容をstmpに設定する
	//
	char *p;
#ifdef HSPWIN
	char *ss;
	char fname[HSP_MAX_PATH+1];
#endif
	p = ctx->stmp;

	*p = 0;

	switch( id ) {
	case 0:				//    カレント(現在の)ディレクトリ
#ifdef HSPWIN
		_getcwd( p, _MAX_PATH );
#endif
		break;
	case 1:				//    HSPの実行ファイルがあるディレクトリ
#ifdef HSPWIN
		GetModuleFileName( NULL,fname,_MAX_PATH );
		getpath( fname, p, 32 );
#endif
		break;
	case 2:				//    Windowsディレクトリ
#ifdef HSPWIN
		GetWindowsDirectory( p, _MAX_PATH );
#endif
		break;
	case 3:				//    Windowsのシステムディレクトリ
#ifdef HSPWIN
		GetSystemDirectory( p, _MAX_PATH );
#endif
		break;
	case 4:				//    コマンドライン文字列
#ifdef HSPWIN
		ss = ctx->cmdline;
		sbStrCopy( &(ctx->stmp), ss );
		p = ctx->stmp;
		return p;
#endif
		break;
	case 5:				//    HSPTV素材があるディレクトリ
#ifdef HSPWIN
#if defined(HSPDEBUG)||defined(HSP3IMP)
		GetModuleFileName( NULL,fname,_MAX_PATH );
		getpath( fname, p, 32 );
		CutLastChr( p, '\\' );
		strcat( p, "\\hsptv\\" );
		return p;
#else
		*p = 0;
		return p;
#endif
#endif
		break;
	default:
#ifdef HSPWIN
		if ( id & 0x10000 ) {
			SHGetSpecialFolderPath( NULL, p, id & 0xffff, FALSE );
			break;
		}
#endif
		throw HSPERR_ILLEGAL_FUNCTION;
	}

#ifdef HSPWIN
	//		最後の'\\'を取り除く
	//
	CutLastChr( p, '\\' );
#endif
	return p;
}


static int sysinfo( int p2 )
{
	//		System strings get
	//
	int fl;
	char *p1;

	p1 = hgio_sysinfo( p2, &fl, ctx->stmp );
	if ( p1 == NULL ) {
		p1 = ctx->stmp;
		*p1 = 0;
		return HSPVAR_FLAG_INT;
	}
	return fl;
}


void *ex_getbmscr( int wid )
{
	Bmscr *bm;
	bm = wnd->GetBmscr( wid );
	return bm;
}

void ex_mref( PVal *pval, int prm )
{
	int t,size;
	void *ptr;
	const int GETBM=0x60;
	t = HSPVAR_FLAG_INT;
	size = 4;
	if ( prm >= GETBM ) {
		throw HSPERR_UNSUPPORTED_FUNCTION;
	} else {
		switch( prm ) {
		case 0x40:
			ptr = &ctx->stat;
			break;
		case 0x41:
			ptr = ctx->refstr;
			t = HSPVAR_FLAG_STR;
			size = 1024;
			break;
		case 0x44:
			ptr = ctx; size = sizeof(HSPCTX);
			break;
		default:
			throw HSPERR_UNSUPPORTED_FUNCTION;
		}
	}
	HspVarCoreDupPtr( pval, t, ptr, size );
}


/*------------------------------------------------------------*/
/*
		HSP Array support
*/
/*------------------------------------------------------------*/

#ifdef USE_DGOBJ
static void code_getvec( VECTOR *vec )
{
	vec->x = (float)code_getdd( 0.0 );
	vec->y = (float)code_getdd( 0.0 );
	vec->z = (float)code_getdd( 0.0 );
	vec->w = 1.0f;
}

static void code_setvec( double *ptr, VECTOR *vec )
{
	ptr[0] = (double)vec->x;
	ptr[1] = (double)vec->y;
	ptr[2] = (double)vec->z;
	ptr[3] = (double)vec->w;
}

static void code_setivec( int *ptr, VECTOR *vec )
{
	ptr[0] = (int)vec->x;
	ptr[1] = (int)vec->y;
	ptr[2] = (int)vec->z;
	ptr[3] = (int)vec->w;
}

static double *code_getvvec( void )
{
	PVal *pval;
	int size;
	double dummy;
	double *v;

	v = (double *)code_getvptr( &pval, &size );
	if ( pval->flag != HSPVAR_FLAG_DOUBLE ) {
		dummy = 0.0f;
		code_setva( pval, 0, HSPVAR_FLAG_DOUBLE, &dummy );
		pval->len[1] = 4;						// ちょっと強引に配列を拡張
		pval->size = 4 * sizeof(double);
		code_setva( pval, 1, HSPVAR_FLAG_DOUBLE, &dummy );
		code_setva( pval, 2, HSPVAR_FLAG_DOUBLE, &dummy );
		v = (double *)HspVarCorePtrAPTR( pval, 0 );
	}
	return v;
}

static int *code_getivec( void )
{
	PVal *pval;
	int dummy;
	int size;
	int *v;

	v = (int *)code_getvptr( &pval, &size );
	if ( pval->flag != HSPVAR_FLAG_INT ) {
		dummy = 0;
		code_setva( pval, 0, HSPVAR_FLAG_INT, &dummy );
		pval->len[1] = 4;						// ちょっと強引に配列を拡張
		pval->size = 4 * sizeof(int);
		v = (int *)HspVarCorePtrAPTR( pval, 0 );
	}
	return v;
}
#endif


static int *code_getiv( void )
{
	//		変数パラメーターを取得(PDATポインタ)
	//
	PVal *pval;
	pval = code_getpval();
	if ( pval->flag != HSPVAR_FLAG_INT ) throw HSPERR_TYPE_MISMATCH;
	return (int *)HspVarCorePtrAPTR( pval, 0 );
}

static int *code_getiv2( PVal **out_pval )
{
	//		変数パラメーターを取得(PDATポインタ)(初期化あり)
	//
	PVal *pval;
	int *v;
	int size;
	int dummy;

	v = (int *)code_getvptr( &pval, &size );
	if ( pval->flag != HSPVAR_FLAG_INT ) {
		dummy = 0;
		code_setva( pval, 0, HSPVAR_FLAG_INT, &dummy );
		v = (int *)HspVarCorePtrAPTR( pval, 0 );
	}
	*out_pval = pval;
	return v;
}

static void code_setivlen( PVal *pval, int len )
{
	//		配列変数を拡張(intのみ)
	//
	int ilen;
	ilen = len;
	if ( ilen < 1 ) ilen = 1;
	pval->len[1] = ilen;						// ちょっと強引に配列を拡張
	pval->size = ilen * sizeof(int);
}


/*------------------------------------------------------------*/
/*
		interface
*/
/*------------------------------------------------------------*/

static void cmdfunc_dialog( void )
{
	// dialog
	//int i;
	char *ptr;
	char *ps;
	char stmp[0x4000];
	ptr = code_getdsi( "" );
	strncpy( stmp, ptr, 0x4000-1 );
	p1 = code_getdi( 0 );
	ps = code_getds("");
	ctx->stat = hgio_dialog( p1, stmp, ps );
}


static int cmdfunc_extcmd( int cmd )
{
	//		cmdfunc : TYPE_EXTCMD
	//		(内蔵GUIコマンド)
	//
	code_next();							// 次のコードを取得(最初に必ず必要です)
	switch( cmd ) {							// サブコマンドごとの分岐

	case 0x00:								// button
		{
		int i;
		char btnname[256];
		unsigned short *sbr;
		Bmscr *bmsrc;

#ifndef HSPEMBED
		i = 0;
		if ( *type == TYPE_PROGCMD ) {
			i = *val;
			if ( i >= 2 ) throw HSPERR_SYNTAX;
			code_next();
		}
#else
		i = code_geti();
#endif
		strncpy( btnname, code_gets(), 255 );
		sbr = code_getlb();
		code_next();
		ctx->stat = bmscr->AddHSPObjectButton( btnname, i, (void *)sbr );
		p1 = bmscr->imgbtn;
		if ( p1 >= 0 ) {
			bmsrc = wnd->GetBmscrSafe( p1 );
			bmscr->SetButtonImage( ctx->stat, p1, bmscr->btn_x1, bmscr->btn_y1, bmscr->btn_x2, bmscr->btn_y2, bmscr->btn_x3, bmscr->btn_y3 );
		}
		break;
		}

	case 0x02:								// exec
		{
		char *ps;
		char *fname;
		fname = code_stmpstr( code_gets() );
		p1 = code_getdi( 0 );
		ps = code_getds( "" );
		ExecFile( fname, ps, p1 );

        ctx->waitcount = 0;
        ctx->runmode = RUNMODE_WAIT;
        return RUNMODE_WAIT;
		}

	case 0x03:								// dialog
		cmdfunc_dialog();
        ctx->waitcount = 0;
        ctx->runmode = RUNMODE_WAIT;
        return RUNMODE_WAIT;

#ifdef USE_MMAN
	case 0x08:								// mmload
		{
		int i;
		char fname[HSP_MAX_PATH];
		strncpy( fname, code_gets(), HSP_MAX_PATH-1 );
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		i = mmman->Load( fname, p1, p2 );
		if (i) throw HSPERR_FILE_IO;
		break;
		}
	case 0x09:								// mmplay
		p1 = code_getdi( 0 );
		//mmman->SetWindow( bmscr->hwnd, bmscr->cx, bmscr->cy, bmscr->sx, bmscr->sy );
		mmman->Play( p1 );
		break;

	case 0x0a:								// mmstop
		p1 = code_getdi( -1 );
		mmman->StopBank( p1 );
		break;
#endif


#if 0
	case 0x0d:								// pget
		p1 = code_getdi( bmscr->cx );
		p2 = code_getdi( bmscr->cy );
		bmscr->Pget( p1, p2 );
		break;
#endif

	case 0x0c:								// pset
		p1 = code_getdi( bmscr->cx );
		p2 = code_getdi( bmscr->cy );
		bmscr->Pset( p1, p2 );
		break;

	case 0x0f:								// mes,print
		{
		//char stmp[1024];
		char *ptr;
		int chk;
		chk = code_get();
		if ( chk<=PARAM_END ) {
			//printf( "\n" );
			break;
		}
		ptr = (char *)(HspVarCorePtr(mpval));
		if ( mpval->flag != HSPVAR_FLAG_STR ) {
			ptr = (char *)HspVarCoreCnv( mpval->flag, HSPVAR_FLAG_STR, ptr );	// 型が一致しない場合は変換
		}
		bmscr->Print( ptr );
		//Alertf( "%s\n",ptr );
		//strsp_ini();
		//while(1) {
		//	chk = strsp_get( ptr, stmp, 0, 1022 );
		//	bmscr->Print( stmp );
		//	  printf( "%s\n",stmp );
		//	if ( chk == 0 ) break;
		//}
		break;
		}
	case 0x10:								// title
		{
		char *p;
		p = code_gets();
		bmscr->Title( p );
		break;
		}
	case 0x11:								// pos
		bmscr->cx = code_getdi( bmscr->cx );
		bmscr->cy = code_getdi( bmscr->cy );
		break;

	case 0x12:								// circle
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		p3 = code_getdi( bmscr->sx );
		p4 = code_getdi( bmscr->sy );
		p5 = code_getdi( 1 );
		bmscr->Circle( p1,p2,p3,p4,p5 );
		break;
	case 0x13:								// cls
		p1 = code_getdi( 0 );
		bmscr->Cls( p1 );
		break;
	case 0x14:								// font
		{
		char fontname[256];
		strncpy( fontname, code_gets(), 255 );
		p1 = code_getdi( 12 );
		p2 = code_getdi( 0 );
		bmscr->SetFont( fontname, p1, p2 );
		break;
		}
	case 0x16:								// objsize
		p1 = code_getdi( 64 );
		p2 = code_getdi( 24 );
		p3 = code_getdi( 0 );
		bmscr->ox=p1;bmscr->oy=p2;bmscr->py=p3;
		break;

	case 0x17:								// picload
		{
		int wid;
		char fname[64];
		strncpy( fname, code_gets(), 63 );
		p1 = code_getdi( 0 );
		wid = bmscr->wid;
		wnd->Picload( wid, fname, p1 );
		//if ( i ) throw HSPERR_PICTURE_MISSING;
		//bmscr = wnd->GetBmscr( wid );
		//cur_window = wid;
		break;
		}
	case 0x18:								// color
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		p3 = code_getdi( 0 );
		bmscr->Setcolor(p1,p2,p3);
		break;
	case 0x1b:								// redraw
		p1 = code_getdi( 1 );
		p2 = code_getdi( 0 );
		p3 = code_getdi( 0 );
		p4 = code_getdi( 0 );
		p5 = code_getdi( 0 );
		if ( p1&1 ) bmscr->DrawAllObjects();
		ctx->stat = hgio_redraw( (BMSCR *)bmscr, p1 );
		break;

	case 0x1c:								// width
		p1 = code_getdi( -1 );
		p2 = code_getdi( -1 );
		p3 = code_getdi( -1 );
		p4 = code_getdi( -1 );
		bmscr->Width( p1, p2, p3, p4, 1 );
		break;

	case 0x1d:								// gsel
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );

		bmscr = wnd->GetBmscrSafe( p1 );
		cur_window = p1;
		break;

	case 0x1e:								// gcopy
		{
		Bmscr *src;
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		p3 = code_getdi( 0 );
		p4 = code_getdi( bmscr->gx );
		p5 = code_getdi( bmscr->gy );
		src = wnd->GetBmscrSafe( p1 );
		if ( bmscr->Copy( src, p2, p3, p4, p5 ) ) throw HSPERR_UNSUPPORTED_FUNCTION;
		break;
		}

	case 0x1f:								// gzoom
		{
		int p7,p8;
		Bmscr *src;
		p1 = code_getdi( bmscr->sx );
		p2 = code_getdi( bmscr->sy );
		p3 = code_getdi( 0 );
		p4 = code_getdi( 0 );
		p5 = code_getdi( 0 );
		p6 = code_getdi( bmscr->gx );
		p7 = code_getdi( bmscr->gy );
		p8 = code_getdi( 0 );
		src = wnd->GetBmscrSafe( p3 );
		if ( bmscr->Zoom( p1, p2, src, p4, p5, p6, p7, p8 ) ) throw HSPERR_UNSUPPORTED_FUNCTION;
		break;
		}

	case 0x20:								// gmode
		p1 = code_getdi( 0 );
		p2 = code_getdi( 32 );
		p3 = code_getdi( 32 );
		p4 = code_getdi( 0 );
		//Alertf( "gmode %d,%d,%d,%d(%x)\n", p1, p2, p3, p4, bmscr );
		bmscr->gmode = p1;
		bmscr->gx = p2;
		bmscr->gy = p3;
		bmscr->gfrate = p4;
		//Alertf("OK");
		break;


	case 0x21:								// bmpsave
		if ( bmscr->BmpSave( code_gets() ) ) throw HSPERR_FILE_IO;
		break;

	case 0x22:								// hsvcolor
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		p3 = code_getdi( 0 );
		bmscr->SetHSVColor( p1, p2, p3 );
		break;

	case 0x23:								// getkey
		{
		PVal *pval;
		APTR aptr;
		aptr = code_getva( &pval );
		p1=code_getdi(1);
		p2 = 0;
#ifdef HSPWIN
		if ( code_event( HSPEVENT_GETKEY, p1, 0, &p2 ) == 0 ) {
			if ( GetAsyncKeyState(p1)&0x8000 ) p2=1;
		}
#endif
#ifdef HSPIOS
		if ( p1 == 1 ) {
			p2 = ( hgio_stick(0)&256 )>>8;
		}
#endif
#ifdef HSPNDK
		if ( p1 == 1 ) {
			p2 = ( hgio_stick(0)&256 )>>8;
		}
#endif
		code_setva( pval, aptr, TYPE_INUM, &p2 );
		break;
		}

	case 0x27:								// input (console)
		{
		PVal *pval;
		APTR aptr;
		char *pp2;
		char *vptr;
		int strsize;
		int a;
		strsize = 0;
		aptr = code_getva( &pval );
		//pp2 = code_getvptr( &pval, &size );
		p2 = code_getdi( 0x4000 );
		p3 = code_getdi( 0 );

		if ( p2 < 64 ) p2 = 64;
		pp2 = code_stmp( p2+1 );

		switch( p3 & 15 ) {
		case 0:
			while(1) {
				if ( p2<=0 ) break;
				a = getchar();
				if ( a==EOF ) break;
				*pp2++ = a;
				p2--;
				strsize++;
			}
			break;
		case 1:
			while(1) {
				if ( p2<=0 ) break;
				a = getchar();
				if (( a==EOF )||( a=='\n' )) break;
				*pp2++ = a;
				p2--;
				strsize++;
			}
			break;
		case 2:
			while(1) {
				if ( p2<=0 ) break;
				a = getchar();
				if ( a == '\r' ) {
					int c = getchar();
					if( c != '\n' ) {
						ungetc(c, stdin);
					}
					break;
				}
				if (( a==EOF )||( a=='\n' )) break;
				*pp2++ = a;
				p2--;
				strsize++;
			}
			break;
		}

		*pp2 = 0;
		ctx->strsize = strsize + 1;

		if ( p3 & 16 ) {
			if (( pval->support & HSPVAR_SUPPORT_FLEXSTORAGE ) == 0 ) throw HSPERR_TYPE_MISMATCH;
			//HspVarCoreAllocBlock( pval, (PDAT *)vptr, strsize );
			vptr = (char *)HspVarCorePtrAPTR( pval, aptr );
			memcpy( vptr, ctx->stmp, strsize );
		} else {
			code_setva( pval, aptr, TYPE_STRING, ctx->stmp );
		}
		break;
		}

	case 0x29:								// buffer
	case 0x2a:								// screen
	case 0x2b:								// bgscr
		{
		int p7,p8;
		p1 = code_getdi( 0 );
		p2 = code_getdi( 640 );
		p3 = code_getdi( 480 );
		p4 = code_getdi( 0 );
		p5 = code_getdi( -1 );
		p6 = code_getdi( -1 );
		p7 = code_getdi( p2 );
		p8 = code_getdi( p3 );

		if ( cmd == 0x29 ) {
			if ( p1 == 0 ) throw HSPERR_ILLEGAL_FUNCTION;
			wnd->MakeBmscr( p1, HSPWND_TYPE_BUFFER, p5, p6, p2, p3 );
		}
		bmscr = wnd->GetBmscr( p1 );
		cur_window = p1;
		//
		//Alertf("screen---(%x)\n",bmscr);
		break;
		}

	case 0x2f:								// line
		p1=code_getdi(0);
		p2=code_getdi(0);
		bmscr->cx=code_getdi(bmscr->cx);
		bmscr->cy=code_getdi(bmscr->cy);
		bmscr->Line( p1, p2 );
		break;

	case 0x31:								// boxf
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		p3 = code_getdi( bmscr->sx );
		p4 = code_getdi( bmscr->sy );
		bmscr->Boxfill( p1, p2, p3, p4 );
		break;

	case 0x34:								// stick
		{
		PVal *pval;
		APTR aptr;
		int res;
		aptr = code_getva( &pval );
		p1 = code_getdi(0);
		p2 = code_getdi(1);

		res = 0;

		ckey = hgio_stick( p2 );
		cktrg = (ckey^cklast)&ckey;
		cklast = ckey;
		res = cktrg|(ckey&p1);
		code_setva( pval, aptr, TYPE_INUM, &res );
		break;
		}

	case 0x35:								// grect
		{
		double rot;
		p1 = code_getdi(0);				// パラメータ1:数値
		p2 = code_getdi(0);				// パラメータ2:数値
		rot = code_getdd(0.0);			// パラメータ5:数値
		p3 = code_getdi(bmscr->gx);		// パラメータ3:数値
		p4 = code_getdi(bmscr->gy);		// パラメータ4:数値
		bmscr->FillRot( p1, p2, p3, p4, (float)rot );
		break;
		}
	case 0x36:								// grotate
		{
		Bmscr *bm2;
		double rot;

		p1 = code_getdi(0);			// パラメータ1:数値
		p2 = code_getdi(0);			// パラメータ2:数値
		p3 = code_getdi(0);			// パラメータ3:数値
		rot = code_getdd(0.0);		// パラメータ4:数値
		p4 = code_getdi(bmscr->gx);	// パラメータ5:数値
		p5 = code_getdi(bmscr->gy);	// パラメータ6:数値

		bm2 = wnd->GetBmscrSafe( p1 );	// 転送元のBMSCRを取得
		bmscr->FillRotTex( p4, p5, (float)rot, bm2, p2, p3, bmscr->gx, bmscr->gy );
		break;
		}

	case 0x37:								// gsquare
		{
		Bmscr *bm2;
		int ep1;
		int *px;
		int *py;
		int *ptx;
		int *pty;

		ep1 = code_getdi(0);				// パラメータ1:数値
		px = code_getiv();
		py = code_getiv();

		if ( ep1 >= 0 ) {
			bm2 = wnd->GetBmscrSafe( ep1 );	// 転送元のBMSCRを取得
			ptx = code_getiv();
			pty = code_getiv();
		} else {
			bm2 = NULL;
			ptx = NULL;
			pty = NULL;
			if ( ep1 == -257 ) {
				ptx = code_getiv();
			}
		}
		bmscr->SquareTex( px, py, bm2, ptx, pty, ep1 );
		break;
		}

	case 0x38:								// gradf
		{
		int gradmode;
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		p3 = code_getdi( bmscr->sx );
		p4 = code_getdi( bmscr->sy );
		gradmode = code_getdi( 0 );
		p5 = code_getdi( 0 );
		p6 = code_getdi( 0 );
		bmscr->GradFill( p1, p2, p3, p4, gradmode, p5, p6 );
		break;
		}
	case 0x39:								// objimage
		p1 = code_getdi( -1 );
		bmscr->imgbtn = p1;
		bmscr->btn_x1 = (short)code_getdi( 0 );
		bmscr->btn_y1 = (short)code_getdi( 0 );
		bmscr->btn_x2 = (short)code_getdi( 0 );
		bmscr->btn_y2 = (short)code_getdi( 0 );
		bmscr->btn_x3 = (short)code_getdi( bmscr->btn_x1 );
		bmscr->btn_y3 = (short)code_getdi( bmscr->btn_y1 );
		break;

	case 0x3a:								// objskip
		{
		p1=code_getdi(0);
		p2=code_getdi(2);
		bmscr->SetObjectMode( p1, p2 );
		break;
		}

	case 0x3b:								// objenable
		{
		p1=code_getdi(0);
		p2=code_getdi(1);
		bmscr->EnableObject( p1, p2 );
		break;
		}

	case 0x3c:								// celload
		{
		//int i;
		char fname[64];
		strncpy( fname, code_gets(), 63 );
		p1 = code_getdi( -1 );
		p2 = code_getdi( 0 );
		if ( p1 < 0 ) p1 = wnd->GetEmptyBufferId();
		//Alertf( "celload[%s],%d,%d\n", fname, p1, p2 );

		wnd->MakeBmscrFromResource( p1, fname );
		//i = wnd->Picload( p1, fname, 0 );
		//if ( i ) throw HSPERR_PICTURE_MISSING;

		ctx->stat = p1;
		break;
		}
	case 0x3d:								// celdiv
		{
		Bmscr *bm2;
		p1=code_getdi(1);
		p2=code_getdi(0);
		p3=code_getdi(0);
		p4=code_getdi(0);
		p5=code_getdi(0);
		//Alertf("celdiv %d,%d,%d,%d,%d\n",p1,p2,p3,p4,p5);

		bm2 = wnd->GetBmscrSafe( p1 );
		bm2->SetCelDivideSize( p2, p3, p4, p5 );
		break;
		}
	case 0x3e:								// celput
		{
		Bmscr *bm2;
		double zx,zy,rot;

		p1=code_getdi(1);
		p2=code_getdi(0);
		zx = code_getdd(1.0);
		zy = code_getdd(1.0);
		rot = code_getdd(0.0);
		bm2 = wnd->GetBmscrSafe( p1 );	// 転送元のBMSCRを取得

		if (( rot == 0.0 )&&( zx == 1.0 )&&( zy == 1.0 )) {
			//		変形なし
			bmscr->CelPut( bm2, p2 );
			break;
		}

		//	変形あり
		bmscr->CelPut( bm2, p2, (float)zx, (float)zy, (float)rot );
		break;
		}

	case 0x3f:								// gfilter
		p1=code_getdi(0);
		//	変形あり
		bmscr->SetFilter( p1 );
		break;
	case 0x40:								// setreq
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		SetSysReq( p1, p2 );
		break;
	case 0x41:								// getreq
		{
		PVal *p_pval;
		APTR p_aptr;
		p_aptr = code_getva( &p_pval );
		p1 = code_getdi( 0 );
//		if ( p1 & 0x10000 ) {
//			code_setva( p_pval, p_aptr, HSPVAR_FLAG_STR, GetDebug() );
//			break;
//		}
		p2 = GetSysReq( p1 );
		code_setva( p_pval, p_aptr, HSPVAR_FLAG_INT, &p2 );
		break;
		}

	case 0x42:								// mmvol
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		mmman->SetVol( p1, p2 );
		break;
	case 0x43:								// mmpan
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		mmman->SetPan( p1, p2 );
		break;
	case 0x44:								// mmstat
		{
		PVal *p_pval;
		APTR p_aptr;
		p_aptr = code_getva( &p_pval );
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		p3 = mmman->GetStatus( p1, p2 );
		code_setva( p_pval, p_aptr, HSPVAR_FLAG_INT, &p3 );
		break;
		}
	case 0x45:								// mtlist
		{
		int *p_ptr;
		int p_size;
		PVal *p_pval;
		p_ptr = code_getiv2( &p_pval );				// 変数ポインタ取得
		p_size = bmscr->listMTouch( p_ptr );		// マルチタッチリスト取得
		code_setivlen( p_pval, p_size );			// 要素数を設定
		ctx->stat = p_size;							// statに要素数を代入
		break;
		}
	case 0x46:								// mtinfo
		{
		int *p_ptr;
		HSP3MTOUCH *mt;
		PVal *p_pval;
		p_ptr = code_getiv2( &p_pval );				// 変数ポインタ取得
		p1 = code_getdi( 0 );
		mt = bmscr->getMTouch( p1 );
		code_setivlen( p_pval, 4 );					// 要素数を設定
		if ( mt ) {
			p_ptr[0] = mt->flag;
			p_ptr[1] = mt->x;
			p_ptr[2] = mt->y;
			p_ptr[3] = mt->pointid;
			ctx->stat = mt->flag;
		} else {
			p_ptr[0] = -1;
			p_ptr[1] = 0;
			p_ptr[2] = 0;
			p_ptr[3] = 0;
			ctx->stat = -1;
		}
		break;
		}
	case 0x47:								// devinfo
		{
		PVal *p_pval;
		APTR p_aptr;
		char *ps;
		char *s_res;
		int p_res;
		p_aptr = code_getva( &p_pval );
		ps = code_gets();
		p_res = 0;
		s_res = wnd->getDevInfo()->devinfo( ps );
		if ( s_res == NULL ) {
			p_res = -1;
		} else {
			code_setva( p_pval, p_aptr, TYPE_STRING, s_res );
		}
		ctx->stat = p_res;
		break;
		}
	case 0x48:								// devinfoi
		{
		PVal *p_pval;
		int *p_ptr;
		char *ps;
		int p_size;
		int *i_res;
		p_ptr = code_getiv2( &p_pval );				// 変数ポインタ取得
		ps = code_gets();
		i_res = wnd->getDevInfo()->devinfoi( ps, &p_size );
		if ( i_res == NULL ) {
			p_size = -1;
		} else {
			code_setivlen( p_pval, p_size );			// 要素数を設定
			memcpy( p_ptr, i_res, sizeof(int)*p_size );
		}
		ctx->stat = p_size;
		break;
		}
	case 0x49:								// devprm
		{
		char *ps;
		char prmname[256];
		int p_res;
		strncpy( prmname, code_gets(), 255 );
		ps = code_gets();
		p_res = wnd->getDevInfo()->devprm( prmname, ps );
		ctx->stat = p_res;
		break;
		}
	case 0x4a:								// devcontrol
		{
		char *cname;
		int p_res;
		cname = code_stmpstr( code_gets() );
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		p3 = code_getdi( 0 );
		p_res = wnd->getDevInfo()->devcontrol( cname, p1, p2, p3 );
		ctx->stat = p_res;
		break;
		}


#ifdef USE_DGOBJ
	/* DG Graphics Support */
	case 0x50:								// dgreset
		{
		int i;
		if ( hg == NULL ) {
			hg = new hgdx;
		}
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		hg->SetDest( NULL, 0,0, bmscr->sx, bmscr->sy, p1, p2 );
		hg->Reset();
		sel_vector = NULL;
		for(i=0;i<MOC_MAX;i++) { movemode[i] = MOVEMODE_LINEAR; }
		movemode[MOC_POS] = MOVEMODE_SPLINE;
		break;
		}
	case 0x51:								// dgdraw
		p1 = code_getdi( 0 );
		if ( hg == NULL ) throw HSPERR_UNSUPPORTED_FUNCTION;
		ctx->stat = hg->DrawObjAll();
#ifdef HSPWIN
		SetSysReq( SYSREQ_RESULT, GetTickCount()  );
#endif
		break;

	case 0x52:								// dgspruv
		{
		int tex;
		PVal *p_pval;
		APTR p_aptr;
		Bmscr *bm2;
		p_aptr = code_getva( &p_pval );
		tex = code_getdi( 0 );
		bm2 = wnd->GetBmscrSafe( tex );
		if ( bm2->flag != HSPWND_TYPE_BUFFER ) throw HSPERR_ILLEGAL_FUNCTION;

		p2 = code_getdi( 0 );
		p3 = code_getdi( 0 );
		p4 = code_getdi( bm2->sx - 1 );
		p5 = code_getdi( bm2->sy - 1 );
		if ( hg == NULL ) throw HSPERR_UNSUPPORTED_FUNCTION;
		p6 = hg->AddSpriteModel( bm2->texid, 0, p2, p3, p4+1, p5+1 );
		code_setva( p_pval, p_aptr, HSPVAR_FLAG_INT, &p6 );
		break;
		}
	case 0x53:								// regobj
		{
		PVal *p_pval;
		APTR p_aptr;
		p_aptr = code_getva( &p_pval );
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		p3 = code_getdi( -1 );
		if ( hg == NULL ) throw HSPERR_UNSUPPORTED_FUNCTION;
		p6 = hg->AddObjWithModel( p1 );
		hg->ObjModeOn( p6, p2 );
		if ( p3 >= 0 ) { hg->AttachEvent( p6, p3, -1 ); }
		code_setva( p_pval, p_aptr, HSPVAR_FLAG_INT, &p6 );
		break;
		}
	case 0x54:								// delobj
		p1 = code_getdi( 0 );
		if ( hg == NULL ) throw HSPERR_UNSUPPORTED_FUNCTION;
		hg->DeleteObj( p1 );
		break;
	case 0x55:								// dgspr
		{
		//			dgspr var,id,subid
		int tex;
		int xx,yy,psx,psy;
		PVal *p_pval;
		APTR p_aptr;
		Bmscr *bm2;
		p_aptr = code_getva( &p_pval );
		tex = code_getdi( 0 );
		p1 = code_getdi( 0 );
		bm2 = wnd->GetBmscrSafe( tex );
		if ( bm2->flag != HSPWND_TYPE_BUFFER ) throw HSPERR_ILLEGAL_FUNCTION;
		if ( hg == NULL ) throw HSPERR_UNSUPPORTED_FUNCTION;
		psx = bm2->divsx;
		psy = bm2->divsy;
		xx = ( p1 % bm2->divx ) * psx;
		yy = ( p1 / bm2->divx ) * psy;
		p6 = hg->AddSpriteModel( bm2->texid, 0, xx, yy, xx+psx, yy+psy );
		code_setva( p_pval, p_aptr, HSPVAR_FLAG_INT, &p6 );
		break;
		}
	case 0x60:								// setpos
	case 0x61:								// setang
	case 0x62:								// setscale
	case 0x63:								// setdir
	case 0x64:								// setefx
	case 0x65:								// setwork
		{
		VECTOR *v;
		p1 = code_getdi( 0 );
		dp1 = code_getdd( 0.0 );
		dp2 = code_getdd( 0.0 );
		dp3 = code_getdd( 0.0 );
		v = hg->GetObjVectorPrm( p1, cmd - 0x60 );
		if ( v == NULL ) code_puterror( HSPERR_ILLEGAL_FUNCTION );
		SetVector3( v, (float)dp1, (float)dp2, (float)dp3 );
		break;
		}
	case 0x68:								// addpos
	case 0x69:								// addang
	case 0x6a:								// addscale
	case 0x6b:								// adddir
	case 0x6c:								// addefx
	case 0x6d:								// addwork
		{
		VECTOR *v;
		p1 = code_getdi( 0 );
		dp1 = code_getdd( 0.0 );
		dp2 = code_getdd( 0.0 );
		dp3 = code_getdd( 0.0 );
		v = hg->GetObjVectorPrm( p1, cmd - 0x68 );
		if ( v == NULL ) code_puterror( HSPERR_ILLEGAL_FUNCTION );
		v->x += (float)dp1;
		v->y += (float)dp2;
		v->z += (float)dp3;
		break;
		}
	case 0x70:								// getpos
	case 0x71:								// getang
	case 0x72:								// getscale
	case 0x73:								// getdir
	case 0x74:								// getefx
	case 0x75:								// getwork
		{
		PVal *pv1;
		PVal *pv2;
		PVal *pv3;
		APTR aptr1;
		APTR aptr2;
		APTR aptr3;
		VECTOR *v;
		p1 = code_getdi( 0 );
		aptr1 = code_getva( &pv1 );
		aptr2 = code_getva( &pv2 );
		aptr3 = code_getva( &pv3 );
		v = hg->GetObjVectorPrm( p1, cmd - 0x70 );
		if ( v == NULL ) code_puterror( HSPERR_ILLEGAL_FUNCTION );
		dp1 = (double)v->x;
		dp2 = (double)v->y;
		dp3 = (double)v->z;
		code_setva( pv1, aptr1, HSPVAR_FLAG_DOUBLE, &dp1 );
		code_setva( pv2, aptr2, HSPVAR_FLAG_DOUBLE, &dp2 );
		code_setva( pv3, aptr3, HSPVAR_FLAG_DOUBLE, &dp3 );
		break;
		}
	case 0x78:								// getposi
	case 0x79:								// getangi
	case 0x7a:								// getscalei
	case 0x7b:								// getdiri
	case 0x7c:								// getefxi
	case 0x7d:								// getworki
		{
		PVal *pv1;
		PVal *pv2;
		PVal *pv3;
		APTR aptr1;
		APTR aptr2;
		APTR aptr3;
		VECTOR *v;
		p1 = code_getdi( 0 );
		aptr1 = code_getva( &pv1 );
		aptr2 = code_getva( &pv2 );
		aptr3 = code_getva( &pv3 );
		v = hg->GetObjVectorPrm( p1, cmd - 0x78 );
		if ( v == NULL ) code_puterror( HSPERR_ILLEGAL_FUNCTION );
		p1 = (int)v->x;
		p2 = (int)v->y;
		p3 = (int)v->z;
		code_setva( pv1, aptr1, HSPVAR_FLAG_INT, &p1 );
		code_setva( pv2, aptr2, HSPVAR_FLAG_INT, &p2 );
		code_setva( pv3, aptr3, HSPVAR_FLAG_INT, &p3 );
		break;
		}

	case 0x80:								// selpos
	case 0x81:								// selang
	case 0x82:								// selscale
	case 0x83:								// seldir
	case 0x84:								// selefx
	case 0x85:								// selwork
		p1 = code_getdi( 0 );
		sel_vector = hg->GetObjVectorPrm( p1, cmd - 0x80 );
		if ( sel_vector == NULL ) code_puterror( HSPERR_ILLEGAL_FUNCTION );
		break;

	case 0x88:								// objset1
		{
		float *vp = (float *)sel_vector;
		p1 = code_getdi( 0 );
		dp1 = code_getdd( 0.0 );
		if (( p1 < 0 )||( p1 >= 4 )) code_puterror( HSPERR_ILLEGAL_FUNCTION );
		vp[p1] = (float)dp1;
		break;
		}
	case 0x89:								// objset1r
		{
		float *vp = (float *)sel_vector;
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		if (( p1 < 0 )||( p1 >= 4 )) code_puterror( HSPERR_ILLEGAL_FUNCTION );
		vp[p1] = CnvIntRot(p2);
		break;
		}
	case 0x8a:								// objset2
		{
		float *vp = (float *)sel_vector;
		p1 = code_getdi( 0 );
		dp1 = code_getdd( 0.0 );
		dp2 = code_getdd( 0.0 );
		if (( p1 < 0 )||( p1 >= 3 )) code_puterror( HSPERR_ILLEGAL_FUNCTION );
		vp[p1] = (float)dp1;
		vp[p1+1] = (float)dp2;
		break;
		}
	case 0x8b:								// objset2r
		{
		float *vp = (float *)sel_vector;
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		p3 = code_getdi( 0 );
		if (( p1 < 0 )||( p1 >= 3 )) code_puterror( HSPERR_ILLEGAL_FUNCTION );
		vp[p1] = CnvIntRot(p2);
		vp[p1+1] = CnvIntRot(p3);
		break;
		}
	case 0x8c:								// objset3
		dp1 = code_getdd( 0.0 );
		dp2 = code_getdd( 0.0 );
		dp3 = code_getdd( 0.0 );
		SetVector3( sel_vector, (float)dp1, (float)dp2, (float)dp3 );
		break;
	case 0x8d:								// objset3r
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		p3 = code_getdi( 0 );
		SetVector3( sel_vector, CnvIntRot(p1), CnvIntRot(p2), CnvIntRot(p3) );
		break;

		
	case 0x8e:								// objadd1
		{
		float *vp = (float *)sel_vector;
		p1 = code_getdi( 0 );
		dp1 = code_getdd( 0.0 );
		if (( p1 < 0 )||( p1 >= 4 )) code_puterror( HSPERR_ILLEGAL_FUNCTION );
		vp[p1] += (float)dp1;
		break;
		}
	case 0x8f:								// objadd1r
		{
		float *vp = (float *)sel_vector;
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		if (( p1 < 0 )||( p1 >= 4 )) code_puterror( HSPERR_ILLEGAL_FUNCTION );
		vp[p1] += CnvIntRot(p2);
		break;
		}
	case 0x90:								// objadd2
		{
		float *vp = (float *)sel_vector;
		p1 = code_getdi( 0 );
		dp1 = code_getdd( 0.0 );
		dp2 = code_getdd( 0.0 );
		if (( p1 < 0 )||( p1 >= 3 )) code_puterror( HSPERR_ILLEGAL_FUNCTION );
		vp[p1] += (float)dp1;
		vp[p1+1] += (float)dp2;
		break;
		}
	case 0x91:								// objadd2r
		{
		float *vp = (float *)sel_vector;
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		p3 = code_getdi( 0 );
		if (( p1 < 0 )||( p1 >= 3 )) code_puterror( HSPERR_ILLEGAL_FUNCTION );
		vp[p1] += CnvIntRot(p2);
		vp[p1+1] += CnvIntRot(p3);
		break;
		}
	case 0x92:								// objadd3
		dp1 = code_getdd( 0.0 );
		dp2 = code_getdd( 0.0 );
		dp3 = code_getdd( 0.0 );
		sel_vector->x += (float)dp1;
		sel_vector->y += (float)dp2;
		sel_vector->z += (float)dp3;
		break;
	case 0x93:								// objadd3r
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		p3 = code_getdi( 0 );
		sel_vector->x += CnvIntRot(p1);
		sel_vector->y += CnvIntRot(p2);
		sel_vector->z += CnvIntRot(p3);
		break;

	case 0x94:								// event_jump
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		p3 = code_getdi( 0 );
		ctx->stat = hg->AddJumpEvent( p1, p2, p3 );
		break;
	case 0x95:								// event_prmset
	case 0x96:								// event_prmon
	case 0x97:								// event_prmoff
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		p3 = code_getdi( 0 );
		ctx->stat = hg->AddParamEvent( p1, cmd-0x95, p2, p3 );
		break;
	case 0x98:								// event_pos
	case 0x99:								// event_ang
	case 0x9a:								// event_scale
	case 0x9b:								// event_dir
	case 0x9c:								// event_efx
	case 0x9d:								// event_work
		p1 = code_getdi( 0 );
		p2 = code_getdi( 10 );
		dp1 = code_getdd( 0.0 );
		dp2 = code_getdd( 0.0 );
		dp3 = code_getdd( 0.0 );
		p6 = cmd-0x98;
		p3 = code_getdi( movemode[p6] );
		if ( p3 & 16 ) p6|=HGEVENT_MOCOPT_SRCWORK;
		switch( p3 & 15 ) {
		case MOVEMODE_LINEAR:
			ctx->stat = hg->AddMoveEvent( p1, p6, (float)dp1, (float)dp2, (float)dp3, p2, 0 );
			break;
		case MOVEMODE_SPLINE:
			ctx->stat = hg->AddSplineMoveEvent( p1, p6, (float)dp1, (float)dp2, (float)dp3, p2, 0 );
			break;
		case MOVEMODE_LINEAR_REL:
			ctx->stat = hg->AddMoveEvent( p1, p6, (float)dp1, (float)dp2, (float)dp3, p2, 1 );
			break;
		case MOVEMODE_SPLINE_REL:
			ctx->stat = hg->AddSplineMoveEvent( p1, p6, (float)dp1, (float)dp2, (float)dp3, p2, 1 );
			break;
		}
		break;

	case 0x9f:								// event_angr
		p1 = code_getdi( 0 );
		p2 = code_getdi( 10 );
		dp1 = CnvIntRot( code_getdi( 0 ) );
		dp2 = CnvIntRot( code_getdi( 0 ) );
		dp3 = CnvIntRot( code_getdi( 0 ) );
		ctx->stat = hg->AddMoveEvent( p1, MOC_ANG, (float)dp1, (float)dp2, (float)dp3, p2, 0 );
		break;

	case 0xa0:								// event_addpos
	case 0xa1:								// event_addang
	case 0xa2:								// event_addscale
	case 0xa3:								// event_adddir
	case 0xa4:								// event_addefx
	case 0xa5:								// event_addwork
		p1 = code_getdi( 0 );
		dp1 = code_getdd( 0.0 );
		dp2 = code_getdd( 0.0 );
		dp3 = code_getdd( 0.0 );
		ctx->stat = hg->AddPlusEvent( p1, cmd-0xa0, (float)dp1, (float)dp2, (float)dp3 );
		break;
	case 0xa6:								// event_addtarget
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		ctx->stat = hg->AddPlusEvent( p1, p2|HGEVENT_MOCOPT_SRCWORK, 0.0f, 0.0f, 0.0f );
		break;
	case 0xa7:								// event_addangr
		p1 = code_getdi( 0 );
		dp1 = CnvIntRot( code_getdi( 0 ) );
		dp2 = CnvIntRot( code_getdi( 0 ) );
		dp3 = CnvIntRot( code_getdi( 0 ) );
		ctx->stat = hg->AddPlusEvent( p1, MOC_ANG, (float)dp1, (float)dp2, (float)dp3 );
		break;

	case 0xa8:								// event_setpos
	case 0xa9:								// event_setang
	case 0xaa:								// event_setscale
	case 0xab:								// event_setdir
	case 0xac:								// event_setefx
	case 0xad:								// event_setwork
		{
		double dp4,dp5,dp6;
		p1 = code_getdi( 0 );
		dp1 = code_getdd( 0.0 );
		dp2 = code_getdd( 0.0 );
		dp3 = code_getdd( 0.0 );
		dp4 = code_getdd( dp1 );
		dp5 = code_getdd( dp2 );
		dp6 = code_getdd( dp3 );
		ctx->stat = hg->AddChangeEvent( p1, cmd-0xa8, (float)dp1, (float)dp2, (float)dp3, (float)dp4, (float)dp5, (float)dp6 );
		break;
		}
	case 0xaf:								// event_setangr
		{
		double dp4,dp5,dp6;
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		p3 = code_getdi( 0 );
		p4 = code_getdi( 0 );
		dp1 = CnvIntRot( p2 );
		dp2 = CnvIntRot( p3 );
		dp3 = CnvIntRot( p4 );
		dp4 = CnvIntRot( code_getdi( p2 ) );
		dp5 = CnvIntRot( code_getdi( p3 ) );
		dp6 = CnvIntRot( code_getdi( p4 ) );
		ctx->stat = hg->AddChangeEvent( p1, MOC_ANG, (float)dp1, (float)dp2, (float)dp3, (float)dp4, (float)dp5, (float)dp6 );
		break;
		}
	case 0xb0:								// setevent
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		p3 = code_getdi( -1 );
		ctx->stat = hg->AttachEvent( p1, p2, p3 );
		break;
	case 0xb1:								// delevent
		p1 = code_getdi( 0 );
		hg->DeleteEvent( p1 );
		break;
	case 0xb2:								// event_wait
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		ctx->stat = hg->AddWaitEvent( p1, p2 );
		break;

	case 0xb3:								// event_uv
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		p3 = code_getdi( 0 );
		ctx->stat = hg->AddUVEvent( p1, p2, p3 );
		break;

	case 0xb4:								// newevent
		{
		PVal *p_pval;
		APTR p_aptr;
		p_aptr = code_getva( &p_pval );
		p1 = hg->GetEmptyEventId();
		code_setva( p_pval, p_aptr, HSPVAR_FLAG_INT, &p1 );
		break;
		}
	case 0xb5:								// setangr
	case 0xb6:								// addangr
		{
		VECTOR *v;
		p1 = code_getdi( 0 );
		dp1 = CnvIntRot( code_getdi( 0 ) );
		dp2 = CnvIntRot( code_getdi( 0 ) );
		dp3 = CnvIntRot( code_getdi( 0 ) );
		v = hg->GetObjVectorPrm( p1, MOC_ANG );
		if ( v == NULL ) code_puterror( HSPERR_ILLEGAL_FUNCTION );
		if ( cmd == 0xb5 ) {
			SetVector3( v, (float)dp1, (float)dp2, (float)dp3 );
		} else {
			v->x += (float)dp1;
			v->y += (float)dp2;
			v->z += (float)dp3;
		}
		break;
		}
	case 0xb7:								// getangr
		{
		PVal *pv1;
		PVal *pv2;
		PVal *pv3;
		APTR aptr1;
		APTR aptr2;
		APTR aptr3;
		VECTOR *v;
		p1 = code_getdi( 0 );
		aptr1 = code_getva( &pv1 );
		aptr2 = code_getva( &pv2 );
		aptr3 = code_getva( &pv3 );
		v = hg->GetObjVectorPrm( p1, MOC_ANG );
		if ( v == NULL ) code_puterror( HSPERR_ILLEGAL_FUNCTION );
		p2 = CnvRotInt(v->x);
		p3 = CnvRotInt(v->y);
		p4 = CnvRotInt(v->z);
		code_setva( pv1, aptr1, HSPVAR_FLAG_INT, &p2 );
		code_setva( pv2, aptr2, HSPVAR_FLAG_INT, &p3 );
		code_setva( pv3, aptr3, HSPVAR_FLAG_INT, &p4 );
		break;
		}

	case 0xb8:								// setobjmode
		{
		hgobj *o;
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		p3 = code_getdi( 0 );
		o = hg->GetObj( p1 );
		if ( o == NULL ) code_puterror( HSPERR_ILLEGAL_FUNCTION );
		ctx->stat = o->mode;
		switch(p3) {
		case 0:
			o->mode |= p2;
			break;
		case 1:
			o->mode &= ~p2;
			break;
		default:
			o->mode = p2;
			break;
		}
		break;
		}
	case 0xb9:								// setobjmodel
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		ctx->stat = hg->AttachObjWithModel( p1, p2 );
		break;
	case 0xba:								// setcoli
		{
		hgobj *o;
		p1 = code_getdi( 0 );
		o = hg->GetObj( p1 );
		if ( o == NULL ) code_puterror( HSPERR_ILLEGAL_FUNCTION );
		p2 = code_getdi( 0 );
		p3 = code_getdi( 0 );
		o->SetColiGroup( p2, p3 );
		break;
		}
	case 0xbb:								// enumobj
		p1 = code_getdi( 0 );
		hg->EnumObj( p1 );
		break;
	case 0xbc:								// getenum
		{
		PVal *p_pval;
		APTR p_aptr;
		p_aptr = code_getva( &p_pval );
		p1 = hg->GetEnumObj();
		code_setva( p_pval, p_aptr, HSPVAR_FLAG_INT, &p1 );
		break;
		}

	case 0xbd:								// event_wpos
	case 0xbe:								// event_wang
	case 0xbf:								// event_wscale
	case 0xc0:								// event_wdir
	case 0xc1:								// event_wefx
		p1 = code_getdi( 0 );
		p2 = code_getdi( 10 );
		p6 = cmd-0xbd;
		p3 = code_getdi( movemode[p6] );
		switch( p3 ) {
		case MOVEMODE_LINEAR:
			ctx->stat = hg->AddMoveEvent( p1, p6|HGEVENT_MOCOPT_SRCWORK, 0.0f, 0.0f, 0.0f, p2, 0 );
			break;
		case MOVEMODE_SPLINE:
			ctx->stat = hg->AddSplineMoveEvent( p1, p6|HGEVENT_MOCOPT_SRCWORK, 0.0f, 0.0f, 0.0f, p2, 0 );
			break;
		case MOVEMODE_LINEAR_REL:
			ctx->stat = hg->AddMoveEvent( p1, p6|HGEVENT_MOCOPT_SRCWORK, 0.0f, 0.0f, 0.0f, p2, 1 );
			break;
		case MOVEMODE_SPLINE_REL:
			ctx->stat = hg->AddSplineMoveEvent( p1, p6|HGEVENT_MOCOPT_SRCWORK, 0.0f, 0.0f, 0.0f, p2, 1 );
			break;
		}
		break;
	case 0xc2:								// event_wwait
		p1 = code_getdi( 0 );
		ctx->stat = hg->AddWaitEvent( p1, -1 );
		break;

	case 0xc3:								// fvset
		p_vec = code_getvvec();
		code_getvec( &p_vec1 );
		code_setvec( p_vec, &p_vec1 );
		break;
	case 0xc4:								// fvadd
		p_vec = code_getvvec();
		code_getvec( &p_vec1 );
		p_vec2.x = (float)p_vec[0] + p_vec1.x;
		p_vec2.y = (float)p_vec[1] + p_vec1.y;
		p_vec2.z = (float)p_vec[2] + p_vec1.z;
		code_setvec( p_vec, &p_vec2 );
		break;
	case 0xc5:								// fvsub
		p_vec = code_getvvec();
		code_getvec( &p_vec1 );
		p_vec2.x = (float)p_vec[0] - p_vec1.x;
		p_vec2.y = (float)p_vec[1] - p_vec1.y;
		p_vec2.z = (float)p_vec[2] - p_vec1.z;
		code_setvec( p_vec, &p_vec2 );
		break;
	case 0xc6:								// fvmul
		p_vec = code_getvvec();
		code_getvec( &p_vec1 );
		p_vec2.x = (float)p_vec[0] * p_vec1.x;
		p_vec2.y = (float)p_vec[1] * p_vec1.y;
		p_vec2.z = (float)p_vec[2] * p_vec1.z;
		code_setvec( p_vec, &p_vec2 );
		break;
	case 0xc7:								// fvdiv
		p_vec = code_getvvec();
		code_getvec( &p_vec1 );
		p_vec2.x = (float)p_vec[0] / p_vec1.x;
		p_vec2.y = (float)p_vec[1] / p_vec1.y;
		p_vec2.z = (float)p_vec[2] / p_vec1.z;
		code_setvec( p_vec, &p_vec2 );
		break;
	case 0xc8:								// fvdir
		{
		VECTOR v;
		VECTOR ang;
		p_vec = code_getvvec();
		code_getvec( &v );
		p1 = code_getdi( 0 );
		SetVector( &ang, (float)p_vec[0], (float)p_vec[1], (float)p_vec[2], 1.0f );
		InitMatrix();
		switch( p1 ) {
		case HGMODEL_ROTORDER_ZYX:
			RotZ( ang.z );
			RotY( ang.y );
			RotX( ang.x );
			break;
		case HGMODEL_ROTORDER_XYZ:
			RotX( ang.x );
			RotY( ang.y );
			RotZ( ang.z );
			break;
		case HGMODEL_ROTORDER_YXZ:
			RotY( ang.y );
			RotX( ang.x );
			RotZ( ang.z );
			break;
		}
		ApplyMatrix( &ang, &v );
		code_setvec( p_vec, &ang );
		break;
		}
	case 0xc9:								// fvmin
		p_vec = code_getvvec();
		dp1 = code_getdd( 0.0 );
		dp2 = code_getdd( 0.0 );
		dp3 = code_getdd( 0.0 );
		if ( p_vec[0] < dp1 ) p_vec[0] = dp1;
		if ( p_vec[1] < dp2 ) p_vec[1] = dp2;
		if ( p_vec[2] < dp3 ) p_vec[2] = dp3;
		break;
	case 0xca:								// fvmax
		p_vec = code_getvvec();
		dp1 = code_getdd( 0.0 );
		dp2 = code_getdd( 0.0 );
		dp3 = code_getdd( 0.0 );
		if ( p_vec[0] > dp1 ) p_vec[0] = dp1;
		if ( p_vec[1] > dp2 ) p_vec[1] = dp2;
		if ( p_vec[2] > dp3 ) p_vec[2] = dp3;
		break;
	case 0xcb:								// fvunit
		{
		VECTOR v;
		p_vec = code_getvvec();
		SetVector( &v, (float)p_vec[0], (float)p_vec[1], (float)p_vec[2], 1.0f );
		UnitVector( &v );
		code_setvec( p_vec, &v );
		break;
		}
	case 0xcc:								// fvouter
		{
		VECTOR v;
		VECTOR v1;
		VECTOR v2;
		p_vec = code_getvvec();
		code_getvec( &v2 );
		SetVector( &v1, (float)p_vec[0], (float)p_vec[1], (float)p_vec[2], 1.0f );
		OuterProduct( &v, &v1, &v2 );
		code_setvec( p_vec, &v );
		break;
		}
	case 0xcd:								// fvinner
		{
		VECTOR v;
		VECTOR v2;
		p_vec = code_getvvec();
		code_getvec( &v2 );
		SetVector( &v, (float)p_vec[0], (float)p_vec[1], (float)p_vec[2], 1.0f );
		p_vec[0] = (double)InnerProduct( &v, &v2 );
		break;
		}
	case 0xce:								// fvface
		{
		VECTOR v;
		VECTOR v2;
		p_vec = code_getvvec();
		code_getvec( &v2 );
		SetVector( &v, (float)p_vec[0], (float)p_vec[1], (float)p_vec[2], 1.0f );
		GetTargetAngle( &v, &v, &v2 );
		code_setvec( p_vec, &v );
		break;
		}
	case 0xcf:								// fv2str
		p_vec = code_getvvec();
		sprintf( ctx->refstr, "%f,%f,%f",p_vec[0],p_vec[1],p_vec[2] );
		break;
	case 0xd0:								// f2str
		{
		PVal *p_pval;
		APTR p_aptr;
		char str[64];
		p_aptr = code_getva( &p_pval );
		dp1 = code_getdd( 0.0 );
		sprintf( str, "%f", dp1 );
		code_setva( p_pval, p_aptr, HSPVAR_FLAG_STR, &str );
		break;
		}
	case 0xd1:								// str2fv
		{
		VECTOR v;
		char *ps;
		p_vec = code_getvvec();
		ps = code_gets();
		sscanf( ps,"%f,%f,%f",&v.x,&v.y,&v.z );
		code_setvec( p_vec, &v );
		break;
		}
	case 0xd2:								// str2f
		{
		float fp;
		char *ps;
		PVal *p_pval;
		APTR p_aptr;
		p_aptr = code_getva( &p_pval );
		ps = code_gets();
		sscanf( ps, "%f", &fp );
		dp1 = (double)fp;
		code_setva( p_pval, p_aptr, HSPVAR_FLAG_DOUBLE, &dp1 );
		break;
		}

	case 0xd3:								// objgetstr
		{
		VECTOR *v;
		PVal *p_pval;
		APTR p_aptr;
		char str[64];
		p_aptr = code_getva( &p_pval );
		v = (VECTOR *)sel_vector;
		sprintf( str,"%f,%f,%f",v->x,v->y,v->z );
		code_setva( p_pval, p_aptr, HSPVAR_FLAG_STR, &str );
		break;
		}
	case 0xd4:								// objgetfv
		{
		VECTOR *v;
		v = (VECTOR *)sel_vector;
		p_vec = code_getvvec();
		code_setvec( p_vec, v );
		break;
		}
	case 0xd5:								// objgetv
		{
		VECTOR *v;
		int *i_vec;
		v = (VECTOR *)sel_vector;
		i_vec = code_getivec();
		code_setivec( i_vec, v );
		break;
		}
	case 0xd6:								// objsetfv
		{
		VECTOR *v;
		v = (VECTOR *)sel_vector;
		p_vec = code_getvvec();
		v->x = (float)p_vec[0];
		v->y = (float)p_vec[1];
		v->z = (float)p_vec[2];
		break;
		}
	case 0xd7:								// objsetv
		{
		VECTOR *v;
		int *i_vec;
		v = (VECTOR *)sel_vector;
		i_vec = code_getivec();
		v->x = (float)i_vec[0];
		v->y = (float)i_vec[1];
		v->z = (float)i_vec[2];
		break;
		}
	case 0xd8:								// objaddfv
		{
		VECTOR *v;
		v = (VECTOR *)sel_vector;
		p_vec = code_getvvec();
		v->x += (float)p_vec[0];
		v->y += (float)p_vec[1];
		v->z += (float)p_vec[2];
		break;
		}

	case 0xd9:								// selmoc
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		sel_vector = hg->GetObjVectorPrm( p1, p2 );
		if ( sel_vector == NULL ) code_puterror( HSPERR_ILLEGAL_FUNCTION );
		break;
	case 0xda:								// setborder
		{
		float x,y,z;
		VECTOR v1;
		VECTOR v2;
		code_getvec( &p_vec1 );
		p1 = code_getdi( 0 );
		switch( p1 ) {
		case 0:
			x = p_vec1.x * 0.5f;
			y = p_vec1.y * 0.5f;
			z = p_vec1.z * 0.5f;
			hg->SetBorder( -x, x, -y, y, -z, z );
			break;
		case 1:
			hg->GetBorder( &v1, &v2 );
			hg->SetBorder( p_vec1.x, v2.x, p_vec1.y, v2.y, p_vec1.z, v2.z );
			break;
		case 2:
			hg->GetBorder( &v1, &v2 );
			hg->SetBorder( v1.x, p_vec1.x, v1.y, p_vec1.y, v1.z, p_vec1.z );
			break;
		}
		break;
		}
	case 0xdb:								// findobj
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		hg->StartObjFind( p1, p2 );
		break;
	case 0xdc:								// nextobj
		{
		PVal *p_pval;
		APTR p_aptr;
		p_aptr = code_getva( &p_pval );
		p1 = hg->FindObj();
		code_setva( p_pval, p_aptr, HSPVAR_FLAG_INT, &p1 );
		break;
		}
	case 0xdd:								// getcoli
		{
		PVal *p_pval;
		APTR p_aptr;
		p_aptr = code_getva( &p_pval );
		p2 = code_getdi( 0 );
		dp1 = code_getdd( 1.0 );
		p3 = code_getdi( 0 );
		p1 = hg->UpdateObjColi( p2, (float)dp1, p3 );
		code_setva( p_pval, p_aptr, HSPVAR_FLAG_INT, &p1 );
		break;
		}
	case 0xde:								// getobjcoli
		{
		hgobj *o;
		PVal *p_pval;
		APTR p_aptr;
		p_aptr = code_getva( &p_pval );
		p1 = code_getdi( 0 );
		o = hg->GetObj( p1 );
		if ( o == NULL ) code_puterror( HSPERR_ILLEGAL_FUNCTION );
		p1 = o->GetColiGroup();
		code_setva( p_pval, p_aptr, HSPVAR_FLAG_INT, &p1 );
		break;
		}
	case 0xdf:								// getobjmodel
		{
		PVal *p_pval;
		APTR p_aptr;
		p_aptr = code_getva( &p_pval );
		p1 = code_getdi( 0 );
		p2 = hg->GetObjModelId( p1 );
		if ( p2 < 0 ) code_puterror( HSPERR_ILLEGAL_FUNCTION );
		code_setva( p_pval, p_aptr, HSPVAR_FLAG_INT, &p2 );
		break;
		}
	case 0xe0:								// objexist
		{
		hgobj *o;
		p1 = code_getdi( 0 );
		p2 = 0;
		o = hg->GetObj( p1 );
		if ( o == NULL ) p2 = -1;
		ctx->stat = p2;
		break;
		}
	case 0xe1:								// event_regobj
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		p3 = code_getdi( 0 );
		ctx->stat = hg->AddRegobjEvent( p1, p2, p3 );
		break;
	case 0xe2:								// objchild
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		if ( p2 >= 0 ) {
			hg->SetObjChild( p1, p2 );
		} else {
			hg->CutObjChild( p1 );
		}
		break;
	case 0xe3:								// event_aim
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		p3 = code_getdi( 0 );
		dp1 = code_getdd( 1.0 );
		dp2 = code_getdd( 1.0 );
		dp3 = code_getdd( 1.0 );
		ctx->stat = hg->AddAimEvent( p1, p2, p3, (float)dp1, (float)dp2, (float)dp3 );
		break;
	case 0xe4:								// objaim
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		p3 = code_getdi( 0 );
		dp1 = code_getdd( 1.0 );
		dp2 = code_getdd( 1.0 );
		dp3 = code_getdd( 1.0 );
		ctx->refdval = (double)hg->ObjAim( p1, p2, p3, (float)dp1, (float)dp2, (float)dp3 );
		break;
	case 0xe5:								// getnearobj
		{
		PVal *p_pval;
		APTR p_aptr;
		p_aptr = code_getva( &p_pval );
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		dp1 = code_getdd( 10.0 );
		p3 = hg->GetNearestObj( p1, (float)dp1, p2 );
		code_setva( p_pval, p_aptr, HSPVAR_FLAG_INT, &p3 );
		break;
		}
	case 0xe6:								// delmodel
		p1 = code_getdi( 0 );
		hg->DeleteModel( p1 );
		break;

	case 0xe7:								// newemit
		{		// var, mode, num, id
		int id;
		PVal *p_pval;
		APTR p_aptr;
		p_aptr = code_getva( &p_pval );
		p2 = code_getdi( 0 );
		p3 = code_getdi( 8 );
		p1 = code_getdi( -1 );
		id = hg->AddEmitter( p1, p2, p3 );
		code_setva( p_pval, p_aptr, HSPVAR_FLAG_INT, &id );
		break;
		}
	case 0xe8:								// delemit
		p1 = code_getdi( 0 );
		hg->DeleteEmitter( p1 );
		break;
	case 0xe9:								// emit_size
		{
		hgemitter *emi;
		p1 = code_getdi( 0 );
		dp1 = code_getdd( 0.0 );
		dp2 = code_getdd( 0.0 );
		dp3 = code_getdd( 0.0 );
		emi = hg->GetEmitter( p1 );
		if ( emi == NULL ) throw HSPERR_ILLEGAL_FUNCTION;
		emi->SetSize( (float)dp1, (float)dp2, (float)dp3 );
		break;
		}
	case 0xea:								// emit_speed
		{
		hgemitter *emi;
		p1 = code_getdi( 0 );
		dp1 = code_getdd( 1.0 );
		dp2 = code_getdd( 0.0 );
		emi = hg->GetEmitter( p1 );
		if ( emi == NULL ) throw HSPERR_ILLEGAL_FUNCTION;
		emi->SetSpeed( (float)dp1, (float)dp2 );
		break;
		}
	case 0xeb:								// emit_angmul
		{
		hgemitter *emi;
		p1 = code_getdi( 0 );
		dp1 = code_getdd( 0.0 );
		dp2 = code_getdd( 0.0 );
		dp3 = code_getdd( 0.0 );
		emi = hg->GetEmitter( p1 );
		if ( emi == NULL ) throw HSPERR_ILLEGAL_FUNCTION;
		emi->SetAngleMul( (float)dp1, (float)dp2, (float)dp3 );
		break;
		}
	case 0xec:								// emit_angopt
		{
		hgemitter *emi;
		p1 = code_getdi( 0 );
		dp1 = code_getdd( 0.0 );
		dp2 = code_getdd( 0.0 );
		dp3 = code_getdd( 0.0 );
		emi = hg->GetEmitter( p1 );
		if ( emi == NULL ) throw HSPERR_ILLEGAL_FUNCTION;
		emi->SetAngleOpt( (float)dp1, (float)dp2, (float)dp3 );
		break;
		}
	case 0xed:								// emit_model
		{
		hgemitter *emi;
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		p3 = code_getdi( 0 );
		p4 = code_getdi( 0 );
		p5 = code_getdi( 0x100 );
		emi = hg->GetEmitter( p1 );
		if ( emi == NULL ) throw HSPERR_ILLEGAL_FUNCTION;
		emi->SetModel( p2, p3, p4, p5 );
		break;
		}
	case 0xee:								// emit_event
		{
		hgemitter *emi;
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		p3 = code_getdi( 0 );
		emi = hg->GetEmitter( p1 );
		if ( emi == NULL ) throw HSPERR_ILLEGAL_FUNCTION;
		emi->SetEvent( p2, p3 );
		break;
		}
	case 0xef:								// emit_num
		{
		hgemitter *emi;
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		p3 = code_getdi( 0 );
		emi = hg->GetEmitter( p1 );
		if ( emi == NULL ) throw HSPERR_ILLEGAL_FUNCTION;
		emi->SetNum( p2, p3 );
		break;
		}
	case 0xf0:								// emit_group
		{
		hgemitter *emi;
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		p3 = code_getdi( 0 );
		emi = hg->GetEmitter( p1 );
		if ( emi == NULL ) throw HSPERR_ILLEGAL_FUNCTION;
		emi->SetGroup( p2, p3 );
		break;
		}
	case 0xf1:								// dgemit
		{
		hgemitter *emi;
		VECTOR pos;
		p1 = code_getdi( 0 );
		dp1 = code_getdd( 0.0 );
		dp2 = code_getdd( 0.0 );
		dp3 = code_getdd( 0.0 );
		emi = hg->GetEmitter( p1 );
		if ( emi == NULL ) throw HSPERR_ILLEGAL_FUNCTION;
		SetVector( &pos, (float)dp1, (float)dp2, (float)dp3, 0.0f );
		ctx->stat = emi->Emit( hg, &pos );
		break;
		}
	case 0xf2:								// setobjemit
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		hg->SetObjEmitter( p1, p2 );
		break;
	case 0xf3:								// groupmod
		{
		VECTOR pos;
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		dp1 = code_getdd( 0.0 );
		dp2 = code_getdd( 0.0 );
		dp3 = code_getdd( 0.0 );
		p3 = code_getdi( 0 );
		SetVector( &pos, (float)dp1, (float)dp2, (float)dp3, 0.0f );
		hg->GroupModify( p1, p2, p3, &pos );
		break;
		}
	case 0xf4:								// setcolscale
		{
		hgobj *o;
		p1 = code_getdi( 0 );
		o = hg->GetObj( p1 );
		if ( o == NULL ) code_puterror( HSPERR_ILLEGAL_FUNCTION );
		dp1 = code_getdd( 1.0 );
		dp2 = code_getdd( dp1 );
		dp3 = code_getdd( dp1 );
		p2 = code_getdi( 0 );
		switch( p2 ) {
		case 0:
			o->SetColScale( (float)dp1, (float)dp2, (float)dp3 );
			break;
		case 1:
			o->SetColParam( (float)dp1, (float)dp2, (float)dp3 );
			break;
		case 2:
			o->SetOptInfo( (int)dp1, (int)dp2, (int)dp3 );
			break;
		default:
			break;
		}
		break;
		}
	case 0xf5:								// modelcols
		p1 = code_getdi( 0 );
		dp1 = code_getdd( 1.0 );
		dp2 = code_getdd( dp1 );
		dp3 = code_getdd( dp1 );
		p2 = code_getdi( 0 );
		switch( p2 ) {
		case 0:
			hg->SetModelColScale( p1, (float)dp1, (float)dp2, (float)dp3 );
			break;
		case 1:
			hg->SetModelColParam( p1, (float)dp1, (float)dp2, (float)dp3 );
			break;
		default:
			break;
		}
		break;

	//	sound part
	//
	case 0x100:								// dmmini
		{
        if ( dxsnd_flag == 0 ) {
#ifdef HSPWIN
            SndInit( (HWND)ctx->wnd_parent );
#else
            SndInit( NULL );
#endif
        }
		dxsnd_flag = 1;
		break;
		}
	case 0x101:								// dmmbye
		SndTerm();
		dxsnd_flag = 0;
		break;
	case 0x102:								// dmmreset
		SndReset();
		break;
	case 0x103:								// dmmdel
		p1 = code_getdi( 0 );
		SndDelete( p1 );
		break;
	case 0x104:								// dmmvol
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		SndSetVolume( p1, p2 );
		break;
	case 0x105:								// dmmpan
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		SndSetPan( p1, p2 );
		break;
	case 0x106:								// dmmloop
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		SndSetLoop( p1, p2 );
		break;
	case 0x107:								// dmmload
		{
		char *ps;
		char fname[HSP_MAX_PATH];
		char fext[8];
		char *mp;
		ps = code_gets();
		strcpy( fname, ps );
		p1 = code_getdi( -1 );
		p2 = code_getdi( 0 );

		getpath(fname,fext,16+2);				// 拡張子を小文字で取り出す
		if (!strcmp(fext,".wav")) {				// when "wav"
			mp = dpm_readalloc( fname );		// HSPリソースを含めて検索する
			if ( mp == NULL ) { ctx->stat = -1; break; }
			ctx->stat = SndRegistWav( p1, mp, 0);
			if ( p2 & 1 ) { SndSetLoop( ctx->stat, 0 ); }
			mem_bye( mp );
		}
/*
		if (!strcmp(fext,".ogg")) {				// when "ogg"
			hspctx->stat = SndRegistOgg( p1, fname, p2 );
		}
		if (!strcmp(fext,".s")) {				// when "s" (oggと同様)
			hspctx->stat = SndRegistOgg( p1, fname, p2 );
		}
*/
		break;
		}
	case 0x108:								// dmmplay
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		if ( p2 == 0 ) {
			SndPlay( p1 );
		} else {
			SndPlayPos( p1, p2 );
		}
		break;
	case 0x109:								// dmmstop
		p1 = code_getdi( 0 );
		if ( p1 < 0 ) {
			SndStopAll();
		} else {
			SndStop( p1 );
		}
		break;
	case 0x10a:								// dmmstat
		{
		PVal *p_pval;
		APTR p_aptr;
		p_aptr = code_getva( &p_pval );
		p1 = code_getdi( 0 );
		p2 = code_getdi( 0 );
		if ( p2 & 0x100 ) {
			dp1 = SndGetTime( p1, p2&0xff );
			code_setva( p_pval, p_aptr, HSPVAR_FLAG_DOUBLE, &dp1 );
			break;
		}
		p3 = SndGetStatus( p1, p2 );
		code_setva( p_pval, p_aptr, HSPVAR_FLAG_INT, &p3 );
		break;
		}




#endif

	default:
		throw HSPERR_UNSUPPORTED_FUNCTION;
	}
	return RUNMODE_RUN;
}


static int get_ginfo( int arg )
{
	//HDC hdc;
	//RECT rect;
	//POINT pt;
	//int i,j;

	//if (( arg>=4 )&&( arg<=11 )) GetWindowRect( bmscr->hwnd, &rect);

	switch( arg ) {
	case 0:
		//GetCursorPos(&pt);
		//return pt.x;
		return 0;
	case 1:
		//GetCursorPos(&pt);
		//return pt.y;
		return 0;
	case 2:
		return wnd->GetActive();
	case 3:
		return cur_window;
	case 4:
		//return rect.left;
	case 5:
		//return rect.top;
	case 6:
		//return rect.right;
	case 7:
		//return rect.bottom;
		return 0;
	case 8:
	case 9:
		//return bmscr->viewx;
		//return bmscr->viewy;
		return 0;
	case 10:
		//return rect.right - rect.left;
	case 11:
		//return rect.bottom - rect.top;
		return 0;
	case 12:
		//if ( bmscr->type != HSPWND_TYPE_BUFFER ) {
		//	bmscr->GetClientSize( &i, &j );
		//	return i;
		//}
	case 26:
		return hgio_getWidth();
		//return bmscr->sx;
	case 13:
		//if ( bmscr->type != HSPWND_TYPE_BUFFER ) {
		//	bmscr->GetClientSize( &i, &j );
		//	return j;
		//}
	case 27:
		return hgio_getHeight();
		//return bmscr->sy;
	case 14:
		return bmscr->printsizex;
	case 15:
		return bmscr->printsizey;
	case 16:
		//return GetRValue( bmscr->color );
		return ( (bmscr->color>>16)&0xff );
	case 17:
		//return GetGValue( bmscr->color );
		return ( (bmscr->color>>8)&0xff );
	case 18:
		//return GetBValue( bmscr->color );
		return ( (bmscr->color)&0xff );
	case 19:
//		hdc=GetDC(NULL);
//		i = 0;
//		if ( GetDeviceCaps( hdc,RASTERCAPS ) & RC_PALETTE ) i = 1;
//		ReleaseDC( NULL, hdc );
//		return i;
		return 0;
	case 20:
		//return GetSystemMetrics( SM_CXSCREEN );
		return bmscr->sx;
	case 21:
		//return GetSystemMetrics( SM_CYSCREEN );
		return bmscr->sy;
	case 22:
		return bmscr->cx;
	case 23:
		return bmscr->cy;
	case 24:
		//return ctx->intwnd_id;
		return 0;
	case 25:
		return wnd->GetEmptyBufferId();
	case 28:
	case 29:
	case 30:
	case 31:
		return 0;

	default:
		throw HSPERR_UNSUPPORTED_FUNCTION;
	}
	return 0;
}


static int reffunc_intfunc_ivalue;
static HSPREAL reffunc_intfunc_dvalue;

static void *reffunc_function( int *type_res, int arg )
{
	int i;
	void *ptr;

	//		返値のタイプを設定する
	//
	*type_res = HSPVAR_FLAG_INT;			// 返値のタイプを指定する
	ptr = &reffunc_intfunc_ivalue;			// 返値のポインタ

	//			'('で始まるかを調べる
	//
	if ( *type != TYPE_MARK ) throw HSPERR_INVALID_FUNCPARAM;
	if ( *val != '(' ) throw HSPERR_INVALID_FUNCPARAM;
	code_next();

	switch( arg & 0xff ) {

	//	int function
	case 0x000:								// ginfo
		i = code_geti();
		if ( i < 0x100 ) {
			reffunc_intfunc_ivalue = get_ginfo( i );
		} else {
			reffunc_intfunc_dvalue = hgio_getinfo( i );
			ptr = &reffunc_intfunc_dvalue;
			*type_res = HSPVAR_FLAG_DOUBLE;
		}
		break;


	case 0x002:								// dirinfo
		p1 = code_geti();
		ptr = getdir( p1 );
		*type_res = HSPVAR_FLAG_STR;
		break;

	case 0x003:								// sysinfo
		p1 = code_geti();
		*type_res = sysinfo( p1 );
		ptr = ctx->stmp;
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


static void *reffunc_sysvar( int *type_res, int arg )
{
	//		reffunc : TYPE_EXTSYSVAR
	//		(拡張システム変数)
	//
	void *ptr;
	if ( arg & 0x100 ) return reffunc_function( type_res, arg );

	//		返値のタイプを設定する
	//
	*type_res = HSPVAR_FLAG_INT;			// 返値のタイプを指定する
	ptr = &reffunc_intfunc_ivalue;			// 返値のポインタ

	switch( arg ) {

	//	int function
	case 0x000:								// mousex
		reffunc_intfunc_ivalue = bmscr->savepos[ BMSCR_SAVEPOS_MOSUEX ];
		//reffunc_intfunc_ivalue = gb_getmousex();
		break;
	case 0x001:								// mousey
		//reffunc_intfunc_ivalue = gb_getmousey();
		reffunc_intfunc_ivalue = bmscr->savepos[ BMSCR_SAVEPOS_MOSUEY ];
		break;
	case 0x002:								// mousew
		reffunc_intfunc_ivalue = bmscr->savepos[ BMSCR_SAVEPOS_MOSUEW ];
		bmscr->savepos[ BMSCR_SAVEPOS_MOSUEW ] = 0;
		break;
	case 0x003:								// hwnd
		//ptr = (void *)(&(bmscr->hwnd));
		reffunc_intfunc_ivalue = 0;
		break;
	case 0x004:								// hinstance
		//ptr = (void *)(&(bmscr->hInst));
		reffunc_intfunc_ivalue = 0;
		break;
	case 0x005:								// hdc
		//ptr = (void *)(&(bmscr->hdc));
		reffunc_intfunc_ivalue = 0;
		break;

	default:
		throw HSPERR_UNSUPPORTED_FUNCTION;
	}
	return ptr;
}


static int termfunc_extcmd( int option )
{
	//		termfunc : TYPE_EXTCMD
	//		(内蔵GUI)
	//
#ifdef USE_MMAN
	delete mmman;
#endif
#ifdef USE_DGOBJ
	if ( hg != NULL ) delete hg;
#endif
	delete wnd;
	return 0;
}

void hsp3typeinit_extcmd( HSP3TYPEINFO *info )
{
	HSPEXINFO *exinfo;								// Info for Plugins

	ctx = info->hspctx;
	exinfo = info->hspexinfo;
	type = exinfo->nptype;
	val = exinfo->npval;
	wnd = new HspWnd();
	bmscr = wnd->GetBmscr( 0 );
	SetObjectEventNoticePtr( &ctx->stat );

#ifdef USE_MMAN
	mmman = new MMMan;
	mmman->Reset( ctx->wnd_parent );
#endif

#ifdef USE_DGOBJ
	hg = NULL;
#endif

	//		function register
	//
	info->cmdfunc = cmdfunc_extcmd;
	info->termfunc = termfunc_extcmd;

	//		HSPEXINFOに関数を登録する
	//
	exinfo->actscr = &cur_window;					// Active Window ID
	exinfo->HspFunc_getbmscr = ex_getbmscr;
	exinfo->HspFunc_mref = ex_mref;

	//		バイナリモードを設定
	//
	//_setmode( _fileno(stdin),  _O_BINARY );
}

void hsp3typeinit_extfunc( HSP3TYPEINFO *info )
{
	info->reffunc = reffunc_sysvar;
}

HSP3DEVINFO *hsp3extcmd_getdevinfo( void )
{
	return wnd->getDevInfo();
}

void hsp3notify_extcmd( void )
{
#ifdef USE_MMAN
	mmman->Notify();
#endif
}


void hsp3extcmd_pause( void )
{
#ifdef HSPNDK
#ifdef USE_MMAN
	mmman->Pause();
#endif
#endif
}


void hsp3extcmd_resume( void )
{
#ifdef HSPNDK
#ifdef USE_MMAN
	mmman->Resume();
	wnd->Resume();
	bmscr = wnd->GetBmscr( 0 );
#endif
#endif
}


