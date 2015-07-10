/*--------------------------------------------------------
	HSP3 main (Embed)
									  2011/3  onitama
  --------------------------------------------------------*/

#include <stdio.h>
#include <ctype.h>

#include "../hsp3/hsp3config.h"

#include "../hsp3/strbuf.h"
//#include "../hsp3/hsp3.h"
//#include "../hsp3/hsp3ext.h"
#include "../hsp3/hsp3gr.h"
#include "../hsp3/supio.h"

#include "hsp3r.h"
#include "hsp3embed.h"

extern void __HspInit( Hsp3r *hsp3 );
//typedef BOOL (*HSP3DBGFUNC)(HSP3DEBUG *,int,int,int);

/*----------------------------------------------------------*/

static Hsp3r *hsp = NULL;
static HSPCTX *ctx;

static char fpas[]={ 'H'-48,'S'-48,'P'-48,'H'-48,
					 'E'-48,'D'-48,'~'-48,'~'-48 };
static char optmes[] = "HSPHED~~\0_1_________2_________3______";

static int hsp_wx, hsp_wy, hsp_wd, hsp_ss;

#ifndef HSPDEBUG
static int hsp_sscnt, hsp_ssx, hsp_ssy;
#endif

#ifdef HSPDEBUG
static HSP3DBGFUNC dbgwin;
static HSP3DBGFUNC dbgnotice;
static HINSTANCE h_dbgwin;
static HWND dbgwnd;
static HSP3DEBUG *dbginfo;
#endif

/*----------------------------------------------------------*/

void hsp3eb_dialog( char *mes )
{
	Alertf( (const char *)mes );
}

int hsp3eb_wait( int tick )
{
	//		時間待ち(wait)
	//		(awaitに変換します)
	//
	if ( ctx->waitcount <= 0 ) {
		ctx->runmode = RUNMODE_RUN;
		return RUNMODE_RUN;
	}
	ctx->waittick = tick + ( ctx->waitcount * 10 );
	return RUNMODE_AWAIT;
}


int hsp3eb_await( int tick )
{
	//		時間待ち(await)
	//
	if ( ctx->waittick < 0 ) {
		if ( ctx->lasttick == 0 ) ctx->lasttick = tick;
		ctx->waittick = ctx->lasttick + ctx->waitcount;
	}
	if ( tick >= ctx->waittick ) {
		ctx->lasttick = tick;
		ctx->runmode = RUNMODE_RUN;
		return RUNMODE_RUN;
	}
	return RUNMODE_AWAIT;
}

/*----------------------------------------------------------*/

int hsp3eb_init( void )
{
	//		システム関連の初期化
	//
//	int a,orgexe, mode;
//	int hsp_sum, hsp_dec;
//	char a1;
#ifdef HSPDEBUG
	int i;
#endif

	//		HSP関連の初期化
	//
	Alertf( "---Init HSP3\n" );
	hsp = new Hsp3r();
	__HspInit( hsp );

	//		実行ファイルかデバッグ中かを調べる
	//
//	mode = 0;
//	orgexe=0;
	hsp_wx = 640;
	hsp_wy = 480;
	hsp_wd = 0;
	hsp_ss = 0;

	ctx = &hsp->hspctx;

	//		Register Type
	//
//	ctx->msgfunc = hsp3win_msgfunc;

//	hsp3typeinit_dllcmd( code_gettypeinfo( TYPE_DLLFUNC ) );
//	hsp3typeinit_dllctrl( code_gettypeinfo( TYPE_DLLCTRL ) );
	hsp3typeinit_extcmd( code_gettypeinfo( TYPE_EXTCMD )  );
	hsp3typeinit_extfunc( code_gettypeinfo( TYPE_EXTSYSVAR ) );

	//		Utility setup
	VarUtilInit();

#ifdef HSPDEBUG
	dbginfo = code_getdbg();
#endif

	ctx->endcode = 0;
	ctx->looplev = 0;
	ctx->sublev = 0;
	
	StackReset();
	
	return 0;
}


void hsp3eb_bye( void )
{
	//		HSP関連の解放
	//
	if ( hsp != NULL ) { delete hsp; hsp = NULL; }

#ifdef HSPDEBUG
	//		デバッグウインドゥの解放
	//
	if ( h_dbgwin != NULL ) { FreeLibrary( h_dbgwin ); h_dbgwin = NULL; }
#endif


	//		システム関連の解放
	//
//	DllManager().free_all_library();
	Alertf( "---Term HSP3\n" );

}


void hsp3eb_error( void )
{
	char errmsg[1024];
	char *msg;
	char *fname;
	HSPERROR err;
	int ln;
	err = code_geterror();
	ln = code_getdebug_line();
	msg = hspd_geterror(err);
	fname = code_getdebug_name();

	if ( ln < 0 ) {
		sprintf( errmsg, "#Error %d\n-->%s\n",(int)err,msg );
		fname = NULL;
	} else {
		sprintf( errmsg, "#Error %d in line %d (%s)\n-->%s\n",(int)err, ln, fname, msg );
	}
//	hsp3win_debugopen();
	hsp3eb_dialog( errmsg );
}


int hsp3eb_exec( void )
{
	//		実行メインを呼び出す
	//
	int i;
	if ( ctx->runmode == RUNMODE_ERROR ) {
		return ctx->runmode;
	}
	ctx->runmode = RUNMODE_RUN;

	try {
		while(1) {
			TaskExec();
			if ( ctx->runmode != 0 ) {
                if ( ctx->runmode != RUNMODE_RETURN ) break;  
            }
		}
	}

		catch( HSPERROR code ) {						// HSPエラー例外処理
		if ( code == HSPERR_NONE ) {
			ctx->runmode = RUNMODE_END;
		} else {
			i = RUNMODE_ERROR;
			ctx->err = code;
			ctx->runmode = i;
			hsp3eb_error();
		}
	}
	//Alertf( "RUN=%d",ctx->runmode );
	return ctx->runmode;
}


int hsp3eb_exectime( int tick )
{
	//		実行メインを呼び出す
	//		(time=経過時間)
	//
	switch( ctx->runmode ) {
	case RUNMODE_STOP:
			break;
		case RUNMODE_WAIT:
			//	高精度タイマー
			ctx->runmode = hsp3eb_wait( tick );
            if ( ctx->runmode == RUNMODE_RUN ) break;
			return ctx->runmode;
		case RUNMODE_AWAIT:
			//	高精度タイマー
			ctx->runmode = hsp3eb_await( tick );
            if ( ctx->runmode == RUNMODE_RUN ) break;
			return ctx->runmode;
		case RUNMODE_END:
			return ctx->runmode;
		case RUNMODE_INTJUMP:
		case RUNMODE_ASSERT:
			ctx->runmode = RUNMODE_STOP;
			return ctx->runmode;
		default:
			break;
		}
	return hsp3eb_exec();
}


void hsp3eb_setstat( int stat )
{
	//		stat値を設定
	//
    ctx->stat = stat;
}


HSPCTX *hsp3eb_getctx( void )
{
	//		HSPCTXを返す
	//
	return ctx;
}


void *hsp3eb_getDevInfo( void )
{
	//		DEVINFOを返す
	//
	return hsp3extcmd_getdevinfo();
}


char *hsp3eb_stmp( char *str )
{
	//		HSPCTXのstmpに文字列を格納する
	//
	code_stmpstr( str );
	return ctx->stmp;
}


void hsp3eb_pause( void )
{
	//		アプリケーションの一時停止
	//
	hsp3extcmd_pause();
}


void hsp3eb_resume( void )
{
	//		アプリケーションの再開
	//
	hsp3extcmd_resume();
}


