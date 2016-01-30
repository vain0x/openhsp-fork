//
//		Draw lib (gameplay)
//			onion software/onitama 2013/3
//
#include "gamehsp.h"

#include <stdio.h>
#include <math.h>

#define STRICT

#ifdef HSPWIN
#include <windows.h>
#include <mmsystem.h>
#include <string.h>
#include <objbase.h>
#include <commctrl.h>
#include <shellapi.h>
#endif

#ifdef HSPNDK
//#define USE_JAVA_FONT
#define FONT_TEX_SX 512
#define FONT_TEX_SY 128
#include "../../appengine.h"
#include "../../javafunc.h"
//#include "font_data.h"
#endif

#ifdef HSPEMSCRIPTEN
#define GL_GLEXT_PROTOTYPES
#include <GL/gl.h>
#include <GL/glext.h>
//#include <GL/glut.h>
#include "SDL/SDL.h"
#include "SDL/SDL_image.h"
#include "SDL/SDL_opengl.h"
#endif

#include "../../hsp3/hsp3config.h"
#include "../hgio.h"
#include "../supio.h"
#include "../sysreq.h"

#define RELEASE(x) 	if(x){x->Release();x=NULL;}

#ifdef HSPWIN
#pragma comment(lib, "d3d8.lib")
#pragma comment(lib, "dxguid.lib")

#ifdef GP_USE_ANGLE
#pragma comment(lib, "libEGL.lib")
#pragma comment(lib, "libGLESv2.lib")
#pragma comment(lib, "gameplay_angle.lib")
#else
#pragma comment(lib, "OpenGL32.lib")
#pragma comment(lib, "GLU32.lib")
#pragma comment(lib, "gameplay.lib")
#endif

//#pragma comment(lib, "glew32.lib")
//#pragma comment(lib, "libpng16.lib")
//#pragma comment(lib, "zlib.lib")
//#pragma comment(lib, "BulletDynamics.lib")
//#pragma comment(lib, "BulletCollision.lib")
//#pragma comment(lib, "LinearMath.lib")

#define M_PI	(3.14159265358979323846f)
#endif

extern gamehsp *game;
extern gameplay::Platform *platform;

static int		mouse_x;
static int		mouse_y;
static int		mouse_btn;
static int   _originX; 	//原点X
static int   _originY; 	//原点Y
static float _scaleX;	// スケールX
static float _scaleY;	// スケールY
static float _rateX;	// 1/スケールX
static float _rateY;	// 1/スケールY

#ifdef HSPNDK
static engine	*appengine;
#endif

#ifdef HSPEMSCRIPTEN
extern bool get_key_state(int sym);
#endif


/*------------------------------------------------------------*/
/*
		HSP File Service
*/
/*------------------------------------------------------------*/

#define MFPTR_MAX 8
static char *mfptr[MFPTR_MAX];
static int mfptr_depth;

void InitMemFile( void )
{
	mfptr_depth = 0;
	mfptr[0] = NULL;
}


int OpenMemFilePtr( char *fname )
{
	int fsize;
	fsize = dpm_exist( fname );		// ファイルのサイズを取得
	if ( fsize <= 0 ) return -1;
	mfptr_depth++;
	if ( mfptr_depth >= MFPTR_MAX ) return -1;
	mfptr[mfptr_depth] = (char *)malloc( fsize );
	dpm_read( fname, mfptr[mfptr_depth], fsize, 0 );	// ファイル読み込み
	return fsize;
}


char *GetMemFilePtr( void )
{
	return mfptr[mfptr_depth];
}


void CloseMemFilePtr( void )
{
	if ( mfptr_depth == 0 ) return;
	if ( mfptr[mfptr_depth] != NULL ) {
		free( mfptr[mfptr_depth] ); mfptr[mfptr_depth]=NULL;
		mfptr_depth--;
	}
}

/*------------------------------------------------------------*/
/*
		gameplay Service
*/
/*------------------------------------------------------------*/

//		Settings
//
static		int nDestWidth;		// 描画座標幅
static		int nDestHeight;	// 描画座標高さ

#ifdef HSPWIN
static		HWND master_wnd;	// 表示対象Window
#endif
static		int drawflag;		// レンダー開始フラグ
static		BMSCR mestexbm;		// テキスト表示用ダミーBMSCR

static		BMSCR *mainbm;		// メインスクリーンのBMSCR
static		HSPREAL infoval[HGIO_INFO_MAX];
static		BMSCR *backbm;		// 背景消去用のBMSCR(null=NC)

static		char m_tfont[256];	// テキスト使用フォント
static		int m_tsize;		// テキスト使用フォントのサイズ
static		int m_tstyle;		// テキスト使用フォントのスタイル指定

static		float center_x,center_y;
static		float linebasex,linebasey;

#define CIRCLE_DIV 16
#define DEFAULT_FONT_NAME ""
#define DEFAULT_FONT_SIZE 18
#define DEFAULT_FONT_STYLE 0


/*------------------------------------------------------------*/
/*
		interface
*/
/*------------------------------------------------------------*/

void hgio_init( int mode, int sx, int sy, void *hwnd )
{
	//		ファイルサービス設定
	//
	InitMemFile();

	//		設定の初期化
	//
	SetSysReq( SYSREQ_RESULT, 0 );
	SetSysReq( SYSREQ_RESVMODE, 0 );

#ifdef HSPWIN
	master_wnd = (HWND)hwnd;
#endif

#ifdef HSPNDK
	appengine = (engine *)hwnd;
#endif

	mainbm = NULL;
	backbm = NULL;
	drawflag = 0;
	nDestWidth = sx;
	nDestHeight = sy;

#if defined(HSPNDK) || defined(HSPEMSCRIPTEN)
	_originX = 0;
	_originY = 0;
	_scaleX = 1.0f;
	_scaleY = 1.0f;
	_rateX = 1.0f;
	_rateY = 1.0f;
#endif

	//		infovalをリセット
	//
	int i;
	for(i=0;i<HGIO_INFO_MAX;i++) {
		infoval[i] = 0.0;
	}
}


void hgio_clsmode( int mode, int color, int tex )
{
	SetSysReq( SYSREQ_CLSMODE, mode );
	SetSysReq( SYSREQ_CLSCOLOR, color );
	SetSysReq( SYSREQ_CLSTEX, tex );
}


int hgio_device_restore( void )
{
	//	デバイスの修復
	//		(0=OK/1=NG)
	//
	return 0;
}


void hgio_resume( void )
{
	hgio_device_restore();
}


int hgio_render_end( void )
{
	//printf("hgio_render_end\n");
	int res;

	if ( drawflag == 0 ) return 0;

	res = 0;

	if ( platform ) platform->swapBuffers();

	drawflag = 0;
	return res;
}


int hgio_render_start( void )
{
	//printf("hgio_render_start\n");
	if ( drawflag ) {
		hgio_render_end();
	}

	//	画面クリア
	//ClearDest( GetSysReq( SYSREQ_CLSMODE ), GetSysReq( SYSREQ_CLSCOLOR ), GetSysReq( SYSREQ_CLSTEX ) );

	//シーンレンダー開始
	if ( game ) game->frame();

	drawflag = 1;
	return 0;
}


void hgio_screen( BMSCR *bm )
{
	//		スクリーン再設定
	//		(cls相当)
	//
	mainbm = bm;
	hgio_font( DEFAULT_FONT_NAME, DEFAULT_FONT_SIZE, DEFAULT_FONT_STYLE );
}


void hgio_setback(BMSCR *bm)
{
	//		背景画像の設定
	//		(NULL=なし)
	//
	backbm = bm;
}


void hgio_delscreen(BMSCR *bm)
{
	//		スクリーンを破棄
	//		(Bmscrクラスのdelete時)
	//
	if ( bm->flag == BMSCR_FLAG_NOUSE ) return;
	if ( bm->texid != -1 ) {
		game->deleteMat( bm->texid );
		bm->texid = -1;
	}
}


int hgio_getWidth( void )
{
	return nDestWidth;
}


int hgio_getHeight( void )
{
	return nDestHeight;
}


void hgio_term( void )
{
	hgio_render_end();
}


int hgio_stick( int actsw )
{
	//		stick用の入力を返す
	//
	int ckey = 0;

#ifdef HSPNDK
	if ( mouse_btn ) ckey|=256;	// mouse_l
#endif

#ifdef HSPWIN
	HWND hwnd;
	if ( actsw ) {
		hwnd = GetActiveWindow();
		if ( hwnd != master_wnd ) return 0;
	}

	if ( GetAsyncKeyState(37)&0x8000 ) ckey|=1;		// [left]
	if ( GetAsyncKeyState(38)&0x8000 ) ckey|=2;		// [up]
	if ( GetAsyncKeyState(39)&0x8000 ) ckey|=4;		// [right]
	if ( GetAsyncKeyState(40)&0x8000 ) ckey|=8;		// [down]
	if ( GetAsyncKeyState(32)&0x8000 ) ckey|=16;	// [spc]
	if ( GetAsyncKeyState(13)&0x8000 ) ckey|=32;	// [ent]
	if ( GetAsyncKeyState(17)&0x8000 ) ckey|=64;	// [ctrl]
	if ( GetAsyncKeyState(27)&0x8000 ) ckey|=128;	// [esc]
	if ( GetAsyncKeyState(1)&0x8000 )  ckey|=256;	// mouse_l
	if ( GetAsyncKeyState(2)&0x8000 )  ckey|=512;	// mouse_r
	if ( GetAsyncKeyState(9)&0x8000 )  ckey|=1024;	// [tab]
#endif

#ifdef HSPEMSCRIPTEN
	if ( mouse_btn ) ckey|=256;	// mouse_l
	if ( get_key_state(SDLK_LEFT) )  ckey|=1;		// [left]
	if ( get_key_state(SDLK_UP) )    ckey|=2;		// [up]
	if ( get_key_state(SDLK_RIGHT) ) ckey|=4;		// [right]
	if ( get_key_state(SDLK_DOWN) )  ckey|=8;		// [down]
	if ( get_key_state(SDLK_SPACE) ) ckey|=16;		// [spc]
	if ( get_key_state(SDLK_RETURN) )ckey|=32;		// [ent]
	if ( get_key_state(SDLK_LCTRL) ) ckey|=64;		// [ctrl]
	if ( get_key_state(SDLK_ESCAPE) )ckey|=128;	// [esc]
	if ( get_key_state(SDLK_TAB) )   ckey|=1024;	// [tab]
#endif

	return ckey;
}


int hgio_redraw( BMSCR *bm, int flag )
{
	//		redrawモード設定
	//		(必ずredraw 0～redraw 1をペアにすること)
	//
	if ( bm == NULL ) return -1;
	if ( bm->type != HSPWND_TYPE_MAIN ) throw HSPERR_UNSUPPORTED_FUNCTION;

	if ( flag & 1 ) {
		hgio_render_end();
	} else {
		hgio_render_start();
	}
	return 0;
}


int hgio_dialog( int mode, char *str1, char *str2 )
{
	//		dialog表示
	//
#ifdef HSPWIN
	int i,res;
	i = 0;
	if (mode&1) i|=MB_ICONEXCLAMATION; else i|=MB_ICONINFORMATION;
	if (mode&2) i|=MB_YESNO; else i|=MB_OK;
	res = MessageBox( master_wnd, str1, str2, i );
	return res;
#endif
#ifdef HSPEMSCRIPTEN
	return 0;
#endif
	return 0;
}


int hgio_title( char *str1 )
{
	//		title変更
	//
#ifdef HSPWIN
	SetWindowText( master_wnd, str1 );
#endif
	return 0;
}


int hgio_texload( BMSCR *bm, char *fname )
{
	//		テクスチャ読み込み
	//
	gpmat *mat;

	bm->texid = game->makeNewMat2D( fname, 0 );
	if ( bm->texid < 0 ) return bm->texid;

	mat = game->getMat( bm->texid );

	bm->sx = mat->_sx;
	bm->sy = mat->_sy;

	return 0;
}


int hgio_mes( BMSCR *bm, char *str1 )
{
	//		mes,print 文字表示
	//
	if ( bm->type != HSPWND_TYPE_MAIN ) throw HSPERR_UNSUPPORTED_FUNCTION;

	if ( game ) {
		bm->printsizex = game->drawFont( bm->cx, bm->cy, str1, (gameplay::Vector4 *)bm->colorvalue, m_tsize );
	}
	bm->printsizey = m_tsize;

	//DrawTexString( bm->cx, bm->cy, str1 );

	//bm->printsizex = TexGetDrawSizeX();
	//bm->printsizey = TexGetDrawSizeY();
	//if ( bm->printsizey <= 0 ) {
	//	bm->printsizey = m_tsize;
	//}
	//Alertf( "%s[%d,%d]",str1,bm->printsizex,bm->printsizey );

	return 0;
}


int hgio_font( char *fontname, int size, int style )
{
	//		文字フォント指定
	//
	strncpy( m_tfont, fontname, 254 );
	m_tsize = size;
	m_tstyle = style;
	return 0;
}


/*------------------------------------------------------------*/
/*
		Universal Draw Service
*/
/*------------------------------------------------------------*/

void hgio_line( BMSCR *bm, float x, float y )
{
	//		ライン描画
	//		(bm!=NULL の場合、ライン描画開始)
	//		(bm==NULL の場合、ライン描画完了)
	//		(ラインの座標は必要な数だけhgio_line2を呼び出す)
	//
	if ( bm == NULL ) {
		return;
	}
	if ( bm->type != HSPWND_TYPE_MAIN ) throw HSPERR_UNSUPPORTED_FUNCTION;

	float r_val = bm->colorvalue[0];
	float g_val = bm->colorvalue[1];
	float b_val = bm->colorvalue[2];
	game->setPolyDiffuse2D( r_val, g_val, b_val, 1.0f );

	linebasex = x;
	linebasey = y;
}


void hgio_line2( float x, float y )
{
	//		ライン描画
	//		(hgio_lineで開始後に必要な回数呼ぶ、hgio_line(NULL)で終了すること)
	//

	float *v = game->startLineColor2D();

	*v++ = linebasex; *v++ = linebasey; v++;
	v+=4;
	linebasex = x;
	linebasey = y;
	*v++ = linebasex; *v++ = linebasey; v++;

	game->drawLineColor2D();

}


void hgio_boxf( BMSCR *bm, float x1, float y1, float x2, float y2 )
{
	//		矩形描画
	//
	if ( bm == NULL ) return;
	if ( bm->type != HSPWND_TYPE_MAIN ) throw HSPERR_UNSUPPORTED_FUNCTION;

	float *v = game->startPolyColor2D();
	float r_val = bm->colorvalue[0];
	float g_val = bm->colorvalue[1];
	float b_val = bm->colorvalue[2];
	//float a_val = bm->colorvalue[3];

	float a_val = game->setPolyColorBlend( 0, 0 );
	game->setPolyDiffuse2D( r_val, g_val, b_val, a_val );

	*v++ = x1; *v++ = y2; v++;
	v+=4;
	//*v++ = r_val; *v++ = g_val; *v++ = b_val; *v++ = a_val;
	*v++ = x1; *v++ = y1; v++;
	v+=4;
	//*v++ = r_val; *v++ = g_val; *v++ = b_val; *v++ = a_val;
	*v++ = x2; *v++ = y2; v++;
	v+=4;
	//*v++ = r_val; *v++ = g_val; *v++ = b_val; *v++ = a_val;
	*v++ = x2; *v++ = y1; v++;
	//*v++ = r_val; *v++ = g_val; *v++ = b_val; *v++ = a_val;

	game->drawPolyColor2D();
}


void hgio_circle( BMSCR *bm, float x1, float y1, float x2, float y2, int mode )
{
	//		円描画
	//
	float x,y,rx,ry,sx,sy,rate;
	if ( bm == NULL ) return;
	if ( bm->type != HSPWND_TYPE_MAIN ) throw HSPERR_UNSUPPORTED_FUNCTION;

	float *v;
	float *v_master = game->startPolyColor2D();
	float r_val = bm->colorvalue[0];
	float g_val = bm->colorvalue[1];
	float b_val = bm->colorvalue[2];
	float a_val = game->setPolyColorBlend( 0, 0 );
	game->setPolyDiffuse2D( r_val, g_val, b_val, a_val );

	rate = M_PI * 2.0f / (float)CIRCLE_DIV;
	sx = abs(x2-x1); sy = abs(y2-y1);
	rx = sx * 0.5f;
	ry = sy * 0.5f;
	x = x1 + rx;
	y = y1 + ry;

	for(int i = 1; i<=CIRCLE_DIV; i ++) {

		v = v_master;

		*v++ = x;
		*v++ = y;
		v++;
		v+=4;

		*v++ = x + cos((float)i * rate)*rx;
		*v++ = y + sin((float)i * rate)*ry;
		v++;
		v+=4;

		*v++ = x + cos((float)(i+1) * rate)*rx;
		*v++ = y + sin((float)(i+1) * rate)*ry;
		v++;
		v+=4;

		game->addPolyColor2D( 3 );
	}

	game->finishPolyColor2D();


	/*
	D3DTLVERTEXC *v;
	D3DTLVERTEXC arScreen[CIRCLE_DIV + 2];
	int col;
	float x,y,rx,ry,sx,sy,rate;

	if ( bm == NULL ) return;
	if ( bm->type != HSPWND_TYPE_MAIN ) throw HSPERR_UNSUPPORTED_FUNCTION;

	rate = D3DX_PI * 2.0f / (float)CIRCLE_DIV;
	sx = abs(x2-x1); sy = abs(y2-y1);
	rx = sx * 0.5f;
	ry = sy * 0.5f;
	x = x1 + rx;
	y = y1 + ry;

	ChangeTex( -1 );
	SetAlphaMode( 0 );
	col = bm->color;

	v = arScreen;
	for(int i = 1; i<=CIRCLE_DIV + 1; i ++) {
		v->x = x + cos((float)i * rate)*rx;
		v->y = y + sin((float)i * rate)*ry;
		v->z = 0.0f;
		v->rhw = 1.0f;
		v->color = col;
		v++;
	}

	//デバイスに使用する頂点フォーマットをセットする
	d3ddev->SetVertexShader(D3DFVF_TLVERTEXC);
	// とりあえず直接描画(四角形)
	d3ddev->SetRenderState( D3DRS_CULLMODE, D3DCULL_CCW );
	d3ddev->DrawPrimitiveUP(D3DPT_TRIANGLEFAN,CIRCLE_DIV,arScreen,sizeof(D3DTLVERTEXC));
	d3ddev->SetRenderState( D3DRS_CULLMODE, D3DCULL_CW );
	*/
}


void hgio_fillrot( BMSCR *bm, float x, float y, float sx, float sy, float ang )
{
	//		矩形(回転)描画
	//
	if ( bm == NULL ) return;
	if ( bm->type != HSPWND_TYPE_MAIN ) throw HSPERR_UNSUPPORTED_FUNCTION;

	float x0,y0,x1,y1,ofsx,ofsy;
	float *v = game->startPolyColor2D();
	float r_val = bm->colorvalue[0];
	float g_val = bm->colorvalue[1];
	float b_val = bm->colorvalue[2];
	//float a_val = bm->colorvalue[3];

	float a_val = game->setPolyColorBlend( bm->gmode, bm->gfrate );

	ofsx = sx;
	ofsy = sy;
	x0 = -(float)sin( ang );
	y0 = (float)cos( ang );
	x1 = -y0;
	y1 = x0;

	ofsx *= -0.5f;
	ofsy *= -0.5f;
	x0 *= ofsy;
	y0 *= ofsy;
	x1 *= ofsx;
	y1 *= ofsx;

	*v++ = (-x0+x1) + x;
	*v++ = (-y0+y1) + y;
	v++;
	*v++ = r_val; *v++ = g_val; *v++ = b_val; *v++ = a_val;

	*v++ = (-x0-x1) + x;
	*v++ = (-y0-y1) + y;
	v++;
	*v++ = r_val; *v++ = g_val; *v++ = b_val; *v++ = a_val;

	*v++ = (x0+x1) + x;
	*v++ = (y0+y1) + y;
	v++;
	*v++ = r_val; *v++ = g_val; *v++ = b_val; *v++ = a_val;

	*v++ = (x0-x1) + x;
	*v++ = (y0-y1) + y;
	v++;
	*v++ = r_val; *v++ = g_val; *v++ = b_val; *v++ = a_val;

	game->drawPolyColor2D();
}


void hgio_copy( BMSCR *bm, short xx, short yy, short srcsx, short srcsy, BMSCR *bmsrc, float s_psx, float s_psy )
{
	//		画像コピー
	//		texid内の(xx,yy)-(xx+srcsx,yy+srcsy)を現在の画面に(psx,psy)サイズでコピー
	//		カレントポジション、描画モードはBMSCRから取得
	//
	float psx,psy;
	float x1,y1,x2,y2,sx,sy;
	float tx0,ty0,tx1,ty1;

	if ( bm == NULL ) return;
	if ( bm->type != HSPWND_TYPE_MAIN ) throw HSPERR_UNSUPPORTED_FUNCTION;

	gpmat *mat = game->getMat( bmsrc->texid );
	if ( mat == NULL ) throw HSPERR_ILLEGAL_FUNCTION;

	float *v = game->startPolyTex2D( mat );
	if ( v == NULL ) throw HSPERR_ILLEGAL_FUNCTION;

	float a_val = game->setMaterialBlend( mat->_material, bm->gmode, bm->gfrate );

	game->setPolyDiffuseTex2D(bm->mulcolorvalue[0], bm->mulcolorvalue[1], bm->mulcolorvalue[2], a_val);

	if ( s_psx < 0.0 ) {
		psx = -s_psx;
		tx1 = ((float)xx);
		tx0 = ((float)(xx + srcsx));
	} else {
		psx = s_psx;
		tx0 = ((float)xx);
		tx1 = ((float)(xx + srcsx));
	}
	if ( s_psy < 0.0 ) {
		psy = -s_psy;
		ty1 = ((float)yy);
		ty0 = ((float)(yy + srcsy));
	} else {
		psy = s_psy;
		ty0 = ((float)yy);
		ty1 = ((float)(yy + srcsy));
	}

	x1 = ((float)bm->cx);
	y1 = ((float)bm->cy);
	x2 = x1 + psx;
	y2 = y1 + psy;

	sx = mat->_texratex;
	sy = mat->_texratey;

	tx0 *= sx;
	tx1 *= sx;
	ty0 = 1.0f - ty0 * sy;
	ty1 = 1.0f - ty1 * sy;

	*v++ = x1; *v++ = y2; v++;
	*v++ = tx0; *v++ = ty1;
	v+=4;
	//*v++ = c_val; *v++ = c_val; *v++ = c_val; *v++ = a_val;
	*v++ = x1; *v++ = y1; v++;
	*v++ = tx0; *v++ = ty0;
	v+=4;
	//*v++ = c_val; *v++ = c_val; *v++ = c_val; *v++ = a_val;
	*v++ = x2; *v++ = y2; v++;
	*v++ = tx1; *v++ = ty1;
	v+=4;
	//*v++ = c_val; *v++ = c_val; *v++ = c_val; *v++ = a_val;
	*v++ = x2; *v++ = y1; v++;
	*v++ = tx1; *v++ = ty0;
	//v+=4;
	//*v++ = c_val; *v++ = c_val; *v++ = c_val; *v++ = a_val;

	game->drawPolyTex2D( mat );
}


int hgio_celputmulti( BMSCR *bm, int *xpos, int *ypos, int *cel, int count, BMSCR *bmsrc )
{
	//		マルチ画像コピー
	//		int配列内のX,Y,CelIDを元に等倍コピーを行なう(count=個数)
	//		カレントポジション、描画モードはBMSCRから取得
	//
	int psx,psy;
	float f_psx,f_psy;
	float x1,y1,x2,y2,sx,sy;
	float tx0,ty0,tx1,ty1;
	float *master_v;
	float *v;
	int i;
	int id;
	int *p_xpos;
	int *p_ypos;
	int *p_cel;
	int xx,yy;
	int total;

	if ( bm == NULL ) return 0;
	if ( bm->type != HSPWND_TYPE_MAIN ) throw HSPERR_UNSUPPORTED_FUNCTION;

	gpmat *mat = game->getMat( bmsrc->texid );
	if ( mat == NULL ) throw HSPERR_ILLEGAL_FUNCTION;

	master_v = game->startPolyTex2D( mat );
	if ( master_v == NULL ) throw HSPERR_ILLEGAL_FUNCTION;

	float a_val = game->setMaterialBlend( mat->_material, bm->gmode, bm->gfrate );
	game->setPolyDiffuseTex2D(bm->mulcolorvalue[0], bm->mulcolorvalue[1], bm->mulcolorvalue[2], a_val);

	total =0;

	p_xpos = xpos;
	p_ypos = ypos;
	p_cel = cel;

	sx = mat->_texratex;
	sy = mat->_texratey;
	psx = bmsrc->divsx;
	psy = bmsrc->divsy;
	f_psx = (float)psx;
	f_psy = (float)psy;

	for(i=0;i<count;i++) {

		id = *p_cel;

		if ( id >= 0 ) {

			xx = ( id % bmsrc->divx ) * psx;
			yy = ( id / bmsrc->divx ) * psy;

			tx0 = ((float)xx);
			tx1 = tx0 + f_psx;

			ty0 = ((float)yy);
			ty1 = ty0 + f_psy;

			x1 = (float)(*p_xpos - bmsrc->celofsx);
			y1 = (float)(*p_ypos - bmsrc->celofsy);
			x2 = x1 + f_psx;
			y2 = y1 + f_psy;

			tx0 *= sx;
			tx1 *= sx;
			ty0 = 1.0f - ty0 * sy;
			ty1 = 1.0f - ty1 * sy;

			v = master_v;

			*v++ = x1; *v++ = y2; v++;
			*v++ = tx0; *v++ = ty1;
			v+=4;
			*v++ = x1; *v++ = y1; v++;
			*v++ = tx0; *v++ = ty0;
			v+=4;
			*v++ = x2; *v++ = y2; v++;
			*v++ = tx1; *v++ = ty1;
			v+=4;
			*v++ = x2; *v++ = y1; v++;
			*v++ = tx1; *v++ = ty0;

			game->addPolyTex2D( mat );
			total++;
		}

		p_xpos++;
		p_ypos++;
		p_cel++;

	}

	game->finishPolyTex2D( mat );
	return total;
}


void hgio_copyrot( BMSCR *bm, short xx, short yy, short srcsx, short srcsy, float s_ofsx, float s_ofsy, BMSCR *bmsrc, float psx, float psy, float ang )
{
	//		画像コピー
	//		texid内の(xx,yy)-(xx+srcsx,yy+srcsy)を現在の画面に(psx,psy)サイズでコピー
	//		カレントポジション、描画モードはBMSCRから取得
	//
	float x,y,x0,y0,x1,y1,ofsx,ofsy,mx0,mx1,my0,my1;
	float tx0,ty0,tx1,ty1,sx,sy;

	if ( bm == NULL ) return;
	if ( bm->type != HSPWND_TYPE_MAIN ) throw HSPERR_UNSUPPORTED_FUNCTION;

	gpmat *mat = game->getMat( bmsrc->texid );
	if ( mat == NULL ) throw HSPERR_ILLEGAL_FUNCTION;

	float *v = game->startPolyTex2D( mat );
	if ( v == NULL ) throw HSPERR_ILLEGAL_FUNCTION;

	float a_val = game->setMaterialBlend( mat->_material, bm->gmode, bm->gfrate );

	game->setPolyDiffuseTex2D(bm->mulcolorvalue[0], bm->mulcolorvalue[1], bm->mulcolorvalue[2], a_val);

	mx0=-(float)sin( ang );
	my0=(float)cos( ang );
	mx1 = -my0;
	my1 = mx0;

	ofsx = -s_ofsx;
	ofsy = -s_ofsy;
	x0 = mx0 * ofsy;
	y0 = my0 * ofsy;
	x1 = mx1 * ofsx;
	y1 = my1 * ofsx;

	//		基点の算出
	x = ( (float)bm->cx - (-x0+x1) );
	y = ( (float)bm->cy - (-y0+y1) );

	//		回転座標の算出
	ofsx = -psx;
	ofsy = -psy;
	x0 = mx0 * ofsy;
	y0 = my0 * ofsy;
	x1 = mx1 * ofsx;
	y1 = my1 * ofsx;

	sx = mat->_texratex;
	sy = mat->_texratey;

	tx0 = (float)xx;
	ty0 = (float)yy;
	tx1 = (float)(xx+srcsx);
	ty1 = (float)(yy+srcsy);

	tx0 *= sx;
	tx1 *= sx;
	ty0 = 1.0f - ty0 * sy;
	ty1 = 1.0f - ty1 * sy;

	*v++ = ((-x0) + x);
	*v++ = ((-y0) + y);
	v++;
	*v++ = tx0;
	*v++ = ty1;
	v+=4;

	*v++ = ((-x0+x1) + x);
	*v++ = ((-y0+y1) + y);
	v++;
	*v++ = tx1;
	*v++ = ty1;
	v+=4;

	*v++ = (x);
	*v++ = (y);
	v++;
	*v++ = tx0;
	*v++ = ty0;
	v+=4;

	*v++ = ((x1) + x);
	*v++ = ((y1) + y);
	v++;
	*v++ = tx1;
	*v++ = ty0;

	game->drawPolyTex2D( mat );
}


void hgio_setfilter( int type, int opt )
{
	/*
	int ft;
	switch( type ) {
	case HGIO_FILTER_TYPE_LINEAR:
		ft = D3DTEXF_LINEAR;
		break;
	case HGIO_FILTER_TYPE_LINEAR2:
		ft = D3DTEXF_FLATCUBIC;
		break;
	default:
		ft = D3DTEXF_POINT;
		break;
	}
	d3ddev->SetTextureStageState( 0, D3DTSS_MAGFILTER, ft  );
	d3ddev->SetTextureStageState( 0, D3DTSS_MINFILTER, ft  );
	*/
}


#if 1

void hgio_setcenter( float x, float y )
{
	center_x = x;
	center_y = y;
}

void hgio_drawsprite( hgmodel *mdl, HGMODEL_DRAWPRM *prm )
{
	//		画像コピー(DG用)
	//		texid内の(xx,yy)-(xx+srcsx,yy+srcsy)を現在の画面に(psx,psy)サイズでコピー
	//		カレントポジション、描画モードはBMSCRから取得
	//
	/*
	D3DTLVERTEX *v;
	TEXINF *tex;
	int texid;
	short ua_ofsx, ua_ofsy;
	float ang,x,y,x0,y0,x1,y1,ofsx,ofsy,mx0,mx1,my0,my1;
	float tx0,ty0,tx1,ty1,sx,sy;

	ang = prm->rot.z;
	mx0=-(float)sin( ang );
	my0=(float)cos( ang );
	mx1 = -my0;
	my1 = mx0;

	ofsx = mdl->center_x * (prm->scale.x);
	ofsy = mdl->center_y * (prm->scale.y);
	x0 = mx0 * ofsy;
	y0 = my0 * ofsy;
	x1 = mx1 * ofsx;
	y1 = my1 * ofsx;

	//		基点の算出
	x = ( prm->pos.x - (-x0+x1) ) + center_x;
	y = ( prm->pos.y - (-y0+y1) ) + center_y;

	//		回転座標の算出
	ofsx = -( mdl->sizex * (prm->scale.x) );
	ofsy = -( mdl->sizey * (prm->scale.y) );
	x0 = mx0 * ofsy;
	y0 = my0 * ofsy;
	x1 = mx1 * ofsx;
	y1 = my1 * ofsx;

	texid = prm->tex;
	ChangeTex( texid );
	tex = GetTex( texid );
	sx = tex->ratex;
	sy = tex->ratey;

	//Alertf( "%d (%f,%f)",texid, x,y );

	ua_ofsx = prm->ua_ofsx;
	ua_ofsy = prm->ua_ofsy;
	tx0 = ((float)(mdl->uv[0]+ua_ofsx) ) * sx;
	ty0 = ((float)(mdl->uv[1]+ua_ofsy) ) * sy;
	tx1 = ((float)(mdl->uv[2]+ua_ofsx) ) * sx;
	ty1 = ((float)(mdl->uv[3]+ua_ofsy) ) * sy;

	v = vertex2D;
	v[0].color = v[1].color = v[2].color = v[3].color = SetAlphaModeDG( (int)prm->efx.x ) | 0xffffff;

	v->x = ((-x0+x1) + x);
	v->y = ((-y0+y1) + y);
	v->tu0 = tx1;
	v->tv0 = ty1;
	v++;

	v->x = ((x1) + x);
	v->y = ((y1) + y);
	v->tu0 = tx1;
	v->tv0 = ty0;
	v++;

	v->x = (x);
	v->y = (y);
	v->tu0 = tx0;
	v->tv0 = ty0;
	v++;

	v->x = ((-x0) + x);
	v->y = ((-y0) + y);
	v->tu0 = tx0;
	v->tv0 = ty1;
	v++;

	//デバイスに使用する頂点フォーマットをセットする
	d3ddev->SetVertexShader(D3DFVF_TLVERTEX);
	// とりあえず直接描画(四角形)
	d3ddev->DrawPrimitiveUP(D3DPT_TRIANGLEFAN,2,vertex2D,sizeof(D3DTLVERTEX));
	*/
}


void hgio_square_tex( BMSCR *bm, int *posx, int *posy, BMSCR *bmsrc, int *uvx, int *uvy )
{
	//		四角形(square)テクスチャ描画
	//
	float sx,sy;
	if ( bm == NULL ) return;
	if ( bm->type != HSPWND_TYPE_MAIN ) throw HSPERR_UNSUPPORTED_FUNCTION;

	gpmat *mat = game->getMat( bmsrc->texid );
	if ( mat == NULL ) throw HSPERR_ILLEGAL_FUNCTION;

	float *v = game->startPolyTex2D( mat );
	if ( v == NULL ) throw HSPERR_ILLEGAL_FUNCTION;

	float a_val = game->setMaterialBlend( mat->_material, bm->gmode, bm->gfrate );

	game->setPolyDiffuseTex2D( 1.0f, 1.0f, 1.0f, a_val );

	sx = mat->_texratex;
	sy = mat->_texratey;

	*v++ = (float)posx[3];
	*v++ = (float)posy[3];
	v++;
	*v++ = ((float)uvx[3]) * sx;
	*v++ = ((float)uvy[3]) * sy;
	v+=4;

	*v++ = (float)posx[0];
	*v++ = (float)posy[0];
	v++;
	*v++ = ((float)uvx[0]) * sx;
	*v++ = ((float)uvy[0]) * sy;
	v+=4;

	*v++ = (float)posx[2];
	*v++ = (float)posy[2];
	v++;
	*v++ = ((float)uvx[2]) * sx;
	*v++ = ((float)uvy[2]) * sy;
	v+=4;

	*v++ = (float)posx[1];
	*v++ = (float)posy[1];
	v++;
	*v++ = ((float)uvx[1]) * sx;
	*v++ = ((float)uvy[1]) * sy;

	game->drawPolyTex2D( mat );
}


void hgio_square( BMSCR *bm, int *posx, int *posy, int *color )
{
	//		四角形(square)単色描画
	//
	if ( bm == NULL ) return;
	if ( bm->type != HSPWND_TYPE_MAIN ) throw HSPERR_UNSUPPORTED_FUNCTION;

	gameplay::Vector4 colvec;
	float *v = game->startPolyColor2D();
	float valw = game->setPolyColorBlend( bm->gmode, bm->gfrate );

	game->colorVector3( color[3], colvec );
	*v++ = (float)posx[3];
	*v++ = (float)posy[3];
	v++;
	*v++ = colvec.x; *v++ = colvec.y; *v++ = colvec.z; *v++ = valw;

	game->colorVector3( color[0], colvec );
	*v++ = (float)posx[0];
	*v++ = (float)posy[0];
	v++;
	*v++ = colvec.x; *v++ = colvec.y; *v++ = colvec.z; *v++ = valw;

	game->colorVector3( color[2], colvec );
	*v++ = (float)posx[2];
	*v++ = (float)posy[2];
	v++;
	*v++ = colvec.x; *v++ = colvec.y; *v++ = colvec.z; *v++ = valw;

	game->colorVector3( color[1], colvec );
	*v++ = (float)posx[1];
	*v++ = (float)posy[1];
	v++;
	*v++ = colvec.x; *v++ = colvec.y; *v++ = colvec.z; *v++ = valw;

	game->drawPolyColor2D();
}


int hgio_gettick( void )
{
#ifdef HSPWIN
	return timeGetTime();
#endif

#ifdef HSPEMSCRIPTEN
	int i;
	timespec ts;
	double nsec;
	static bool init = false;
	static int initTime = 0;
	clock_gettime(CLOCK_REALTIME,&ts);
	nsec = (double)(ts.tv_nsec) * 0.001 * 0.001;
	i = (int)ts.tv_sec * 1000 + (int)nsec;
	if (!init) {
		init = true;
		initTime = i;
	}

	return i - initTime;
#endif

#ifdef HSPNDK
	int i;
	timespec ts;
	double nsec;
    clock_gettime(CLOCK_REALTIME,&ts);
    nsec = (double)(ts.tv_nsec) * 0.001 * 0.001;
    i = (int)ts.tv_sec * 1000 + (int)nsec;
    //return ((double)(ts.tv_sec) + (double)(ts.tv_nsec) * 0.001 * 0.001 * 0.001);
	return i;
#endif
}


int hgio_exec( char *stmp, char *option, int mode )
{
#ifdef HSPWIN
	int i,j;
	j=SW_SHOWDEFAULT;if (mode&2) j=SW_SHOWMINIMIZED;

	if ( *option != 0 ) {
		SHELLEXECUTEINFO exinfo;
		memset( &exinfo, 0, sizeof(SHELLEXECUTEINFO) );
		exinfo.cbSize = sizeof(SHELLEXECUTEINFO);
		exinfo.fMask = SEE_MASK_INVOKEIDLIST;
		exinfo.hwnd = master_wnd;
		exinfo.lpVerb = option;
		exinfo.lpFile = stmp;
		exinfo.nShow = SW_SHOWNORMAL;
		if ( ShellExecuteEx( &exinfo ) == false ) throw HSPERR_EXTERNAL_EXECUTE;
		return 0;
	}
		
	if ( mode&16 ) {
		i = (int)ShellExecute( NULL,NULL,stmp,"","",j );
	}
	else if ( mode&32 ) {
		i = (int)ShellExecute( NULL,"print",stmp,"","",j );
	}
	else {
		i=WinExec( stmp,j );
	}
	if (i<32) throw HSPERR_EXTERNAL_EXECUTE;
#endif
	return 0;
}


HSPREAL hgio_getinfo( int type )
{
	int i;
	i = type - HGIO_INFO_BASE;
	if (( i >= 0 )&&( i < HGIO_INFO_MAX)) {
		return infoval[i];
	}
	return 0.0;
}

void hgio_setinfo( int type, HSPREAL val )
{
	int i;
	i = type - HGIO_INFO_BASE;
	if (( i >= 0 )&&( i < HGIO_INFO_MAX)) {
		infoval[i] = val;
	}
}

char *hgio_sysinfo( int p2, int *res, char *outbuf )
{
	//		System strings get
	//
#if HSPWIN
	int fl;
	char pp[128];
	char *p1;
	BOOL success;
	DWORD version;
	DWORD size;
	DWORD *mss;
	SYSTEM_INFO si;
	MEMORYSTATUS ms;

	fl = HSPVAR_FLAG_INT;
	p1 = outbuf;
	size = HSP_MAX_PATH;

	if (p2&16) {
		GetSystemInfo(&si);
	}
	if (p2&32) {
		GlobalMemoryStatus(&ms);
		mss=(DWORD *)&ms;
		*(int *)p1 = (int)mss[p2&15];
		*res = fl;
		return p1;
	}

	switch(p2) {
	case 0:
		strcpy(p1,"Windows");
		version = GetVersion();
		if ((version & 0x80000000) == 0) strcat(p1,"NT");
									else strcat(p1,"9X");
		sprintf( pp," ver%d.%d", static_cast< int >( version&0xff ), static_cast< int >( (version&0xff00)>>8 ) );
		strcat( p1, pp );
		fl=HSPVAR_FLAG_STR;
		break;
	case 1:
		success = GetUserName( p1,&size );
		fl = HSPVAR_FLAG_STR;
		break;
	case 2:
		success = GetComputerName(p1, &size );
		fl = HSPVAR_FLAG_STR;
		break;
	case 16:
		*(int *)p1 = (int)si.dwProcessorType;
		break;
	case 17:
		*(int *)p1 = (int)si.dwNumberOfProcessors;
		break;
	default:
		return NULL;
	}
	*res = fl;
	return p1;
#else
	int fl;
	char *p1;
	fl = HSPVAR_FLAG_STR;
	p1 = outbuf;
	*p1=0;

	switch(p2) {
	case 0:
		break;
	case 1:
		break;
	case 2:
		break;
	default:
		return NULL;
	}
	*res = fl;
	return p1;
#endif
}

#ifdef HSPWIN
HWND hgio_gethwnd( void )
{
	return master_wnd;
}
#endif




void hgio_size( int sx, int sy )
{
}


void hgio_view( int sx, int sy )
{
}


void hgio_scale( float xx, float yy )
{
}


void hgio_autoscale( int mode )
{
}


void hgio_uvfix( int mode )
{
}


/*------------------------------------------------------------*/
/*
		HGIMG4 Sprite service
*/
/*------------------------------------------------------------*/

void hgio_draw_gpsprite( Bmscr *bmscr, bool lateflag )
{
	float zx,zy,rot;
	gpobj *obj;
	gpspr *spr;
	game->findSpriteObj( lateflag );
	while(1) {
		obj = game->getNextSpriteObj();
		if ( obj == NULL ) break;
		spr = obj->_spr;
		if ( spr ) {

			zx = spr->_scale.x;
			zy = spr->_scale.y;
			rot = spr->_ang.z;

			bmscr->cx = (int)spr->_pos.x;
			bmscr->cy = (int)spr->_pos.y;
			bmscr->gmode = spr->_gmode;
			bmscr->gfrate = obj->_transparent;

			if (( rot == 0.0f )&&( zx == 1.0f )&&( zy == 1.0f )) {
				//	変形なし
				bmscr->CelPut( (Bmscr *)spr->_bmscr, spr->_celid );
			} else {
				//	変形あり
				bmscr->CelPut( (Bmscr *)spr->_bmscr, spr->_celid, zx, zy, rot );
			}
		}
	}

}



void hgio_text_render( void )
{
}

#endif



#ifdef HSPNDK
//
//		FILE I/O Service
//
static char storage_path[256];
static char my_storage_path[256+64];

int hgio_file_exist( char *fname )
{
	int size;
	AAssetManager* mgr = appengine->app->activity->assetManager;
	if (mgr == NULL) return -1;
	AAsset* asset = AAssetManager_open(mgr, (const char *)fname, AASSET_MODE_UNKNOWN);
	if (asset == NULL) return -1;
    size = (int)AAsset_getLength(asset);
    AAsset_close(asset);
	//Alertf( "[EXIST]%s:%d",fname,size );
    return size;
}


int hgio_file_read( char *fname, void *ptr, int size, int offset )
{
	int readsize;
	AAssetManager* mgr = appengine->app->activity->assetManager;
	if (mgr == NULL) return -1;
	AAsset* asset = AAssetManager_open(mgr, (const char *)fname, AASSET_MODE_UNKNOWN);
	if (asset == NULL) return -1;
    readsize = (int)AAsset_getLength(asset);
	if ( readsize > size ) readsize = size;
	if ( offset>0 ) AAsset_seek( asset, offset, SEEK_SET );
	AAsset_read( asset, ptr, readsize );
    AAsset_close(asset);
    return readsize;
}


void hgio_setstorage( char *path )
{
	int i;
	*storage_path = 0;
	i = strlen(path);if (( i<=0 )||( i>=255 )) return;
	strcpy( storage_path, path );
	if ( storage_path[i-1]!='/' ) {
		storage_path[i] = '/';
		storage_path[i+1] = 0;
	}
}


char *hgio_getstorage( char *fname )
{
	strcpy( my_storage_path, storage_path );
	strcat( my_storage_path, fname );
	return my_storage_path;
}


/*-------------------------------------------------------------------------------*/

void hgio_touch( int xx, int yy, int button )
{
    Bmscr *bm;
	mouse_x = ( xx - _originX ) * _rateX;
	mouse_y = ( yy - _originY ) * _rateY;
	mouse_btn = button;
    if ( mainbm != NULL ) {
        mainbm->savepos[BMSCR_SAVEPOS_MOSUEX] = mouse_x;
        mainbm->savepos[BMSCR_SAVEPOS_MOSUEY] = mouse_y;
        mainbm->tapstat = button;
        bm = (Bmscr *)mainbm;
        bm->UpdateAllObjects();
        bm->setMTouchByPointId( 0, mouse_x, mouse_y, button!=0 );
    }
}

void hgio_mtouch( int old_x, int old_y, int xx, int yy, int button, int opt )
{
    Bmscr *bm;
    int x,y,old_x2,old_y2;
    if ( mainbm == NULL ) return;
    bm = (Bmscr *)mainbm;
	x = ( xx - _originX ) * _rateX;
	y = ( yy - _originY ) * _rateY;
    if ( opt == 0) {
        mouse_x = x;
        mouse_y = y;
        mouse_btn = button;
        mainbm->savepos[BMSCR_SAVEPOS_MOSUEX] = mouse_x;
        mainbm->savepos[BMSCR_SAVEPOS_MOSUEY] = mouse_y;
        mainbm->tapstat = button;
        bm->UpdateAllObjects();
    }
    if ( old_x >= 0 ) {
        old_x2 = ( old_x - _originX ) * _rateX;
    } else {
        old_x2 = old_x;
    }
    if ( old_y >= 0 ) {
        old_y2 = ( old_y - _originY ) * _rateY;
    } else {
        old_y2 = old_y;
    }
    bm->setMTouchByPoint( old_x2, old_y2, x, y, button!=0 );
}

void hgio_mtouchid( int pointid, int xx, int yy, int button, int opt )
{
    Bmscr *bm;
    int x,y;

    if ( mainbm == NULL ) return;
    bm = (Bmscr *)mainbm;
	x = ( xx - _originX ) * _rateX;
	y = ( yy - _originY ) * _rateY;
    if ( opt == 0 ) {
        mouse_x = x;
        mouse_y = y;
        mouse_btn = button;
        mainbm->savepos[BMSCR_SAVEPOS_MOSUEX] = mouse_x;
        mainbm->savepos[BMSCR_SAVEPOS_MOSUEY] = mouse_y;
        mainbm->tapstat = button;
        bm->UpdateAllObjects();
    }
    bm->setMTouchByPointId( pointid, x, y, button!=0 );
}

int hgio_getmousex( void )
{
	return mouse_x;
}


int hgio_getmousey( void )
{
	return mouse_y;
}


int hgio_getmousebtn( void )
{
	return mouse_btn;
}

/*-------------------------------------------------------------------------------*/

#endif




#ifdef HSPEMSCRIPTEN

char *hgio_getstorage( char *fname )
{
	return fname;
}

void hgio_touch( int xx, int yy, int button )
{
    Bmscr *bm;
	mouse_x = ( xx - _originX ) * _rateX;
	mouse_y = ( yy - _originY ) * _rateY;
	mouse_btn = button;
    if ( mainbm != NULL ) {
        mainbm->savepos[BMSCR_SAVEPOS_MOSUEX] = mouse_x;
        mainbm->savepos[BMSCR_SAVEPOS_MOSUEY] = mouse_y;
        mainbm->tapstat = button;
        bm = (Bmscr *)mainbm;
        bm->UpdateAllObjects();
        bm->setMTouchByPointId( 0, mouse_x, mouse_y, button!=0 );
    }
}


#endif
