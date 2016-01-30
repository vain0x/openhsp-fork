
//
//	HspWnd,Bmscr(BMSCR) struct define
//
#ifndef __hspwnd_h
#define __hspwnd_h


//
//	hspwnd.cpp header
//
#ifndef __hspwnd_win_h
#define __hspwnd_win_h

#define WIN32_LEAN_AND_MEAN		// Exclude rarely-used stuff from Windows headers
#include <windows.h>

//	Window Object Info
//
#define HSPOBJ_OPTION_SETFONT	0x100

#define MESSAGE_HSPOBJ	0x4000
#define HSPOBJ_LIMIT_DEFAULT	1024

#define HSPOBJ_INPUT_STR 2
#define HSPOBJ_INPUT_DOUBLE 3
#define HSPOBJ_INPUT_INT 4
#define HSPOBJ_INPUT_MULTILINE 0x100
#define HSPOBJ_INPUT_READONLY 0x200
#define HSPOBJ_INPUT_HSCROLL 0x400

#define HSPOBJ_NONE 0
#define HSPOBJ_TAB_ENABLE 1
#define HSPOBJ_TAB_DISABLE 2
#define HSPOBJ_TAB_SKIP 3
#define HSPOBJ_TAB_SELALLTEXT 4

typedef struct HSP3VARSET
{
	//	PVal entry structure
	//
	int type;
	PVal *pval;
	APTR aptr;
	void *ptr;
} HSP3VARSET;

typedef struct HSPOBJINFO
{
	//		Object Info (3.0)
	//
	short	owmode;		// objectのmode
	short	option;		// objectのoption(未使用・内部オブジェクトは0)
	void	*bm;		// objectが配置されているBMSCR構造体のポインタ
	HWND	hCld;		// objectのhandle
	int		owid;		// objectのValue(汎用)
	int		owsize;		// objectの使用サイズ(汎用)

	HSP3VARSET varset;	// objectから設定される変数の情報

	//		callback function
	void	(*func_notice)( struct HSPOBJINFO *, int );
	void	(*func_objprm)( struct HSPOBJINFO *, int, void * );
	void	(*func_delete)( struct HSPOBJINFO * );

} HSPOBJINFO;


#define BMSCR_FLAG_NOUSE	0
#define BMSCR_FLAG_INUSE	1
#define BMSCR_PALMODE_FULLCOLOR	0
#define BMSCR_PALMODE_PALETTECOLOR	1

#define HSPWND_TYPE_NONE 0
#define HSPWND_TYPE_BUFFER 1
#define HSPWND_TYPE_MAIN 2
#define HSPWND_TYPE_BGSCR 3
#define HSPWND_TYPE_SSPREVIEW 4

enum {
BMSCR_SAVEPOS_MOSUEX,
BMSCR_SAVEPOS_MOSUEY,
BMSCR_SAVEPOS_MOSUEZ,
BMSCR_SAVEPOS_MOSUEW,
BMSCR_SAVEPOS_MAX,
};

//	Bmscr class
//
class Bmscr {
public:
	//	Functions
	//
	Bmscr( void );
	~Bmscr( void );
	void *GetBMSCR( void ) { return (void *)(&this->flag); };
	void Init( HANDLE instance, HWND p_hwnd, int p_sx, int p_sy, int palsw );
	void Cls( int mode );
	void Bmspnt( HDC hdc );
	void Update( void );
	void Send( int x, int y, int p_sx, int p_sy );
	void Posinc( int pp );
	void Width( int x, int y, int wposx, int wposy, int mode );
	void Title( char *str );

	void Delfont( void );
	void Fontupdate( void );
	int Newfont( char *fonname, int fpts, int fopt, int angle );
	void Sysfont( int p1 );
	void Setcolor( int a1, int a2, int a3 );
	void Setcolor( COLORREF rgbcolor );
	void SetHSVColor( int hval, int sval, int vval );
	void SetSystemcolor( int id );
	void SetPalette( int palno, int rv, int gv, int bv );
	void SetPalcolor( int palno );
	void UpdatePalette( void );
	int BmpSave( char *fname );
	void GetClientSize( int *xsize, int *ysize );

	void Print( char *mes );
	void Boxfill( int x1,int y1,int x2,int y2 );
	void Circle( int x1,int y1,int x2,int y2, int mode );
	COLORREF Pget( int xx, int yy );
	void Pset( int xx,int yy );
	void Line( int xx,int yy );
	int Copy( Bmscr *src, int xx, int yy, int psx, int psy );
	int Zoom( int dx, int dy, Bmscr *src, int xx, int yy, int psx, int psy, int mode );
	void SetScroll( int xbase, int ybase );

	int NewHSPObject( void );
	void ResetHSPObject( void );
	int ActivateHSPObject( int id );
	void NextObject( int plus );

	HSPOBJINFO *AddHSPObject( int id, HWND handle, int mode );
	HSPOBJINFO *AddHSPJumpEventObject( int id, HWND handle, int mode, int val, void *ptr );
	HSPOBJINFO *AddHSPVarEventObject( int id, HWND handle, int mode, PVal *pval, APTR aptr, int type, void *ptr );
	HSPOBJINFO *GetHSPObject( int id );

	void DeleteHSPObject( int id );
	void SetHSPObjectFont( int id );
	void SendHSPObjectNotice( int wparam );
	void UpdateHSPObject( int id, int type, void *ptr );
	int AddHSPObjectButton( char *name, int eventid, void *callptr );
	int AddHSPObjectCheckBox( char *name, PVal *pval, APTR aptr );
	int AddHSPObjectInput( PVal *pval, APTR aptr, int sizex, int sizey, char *defval, int limit, int mode );
	int AddHSPObjectMultiBox( PVal *pval, APTR aptr, int psize, char *defval, int mode );

	//
	//		Window data structure
	//
	int		flag;				// used flag
	int		sx;					// X-size
	int		sy;					// Y-size
	int		palmode;			// palmode
	HDC		hdc;				// buffer HDC
	BYTE	*pBit;				// bitmap pointer
	BITMAPINFOHEADER *pbi;		// infoheader
	HBITMAP	dib;				// bitmap handle(DIB)
	HBITMAP	old;				// bitmap handle(OLD)
	RGBQUAD *pal;				// palette table
	HPALETTE hpal;				// palette handle
	HPALETTE holdpal;			// palette handle (old)
	int		pals;				// palette entries
	HWND	hwnd;				// window handle
	HINSTANCE hInst;			// Instance of program
	int		infsize;			// *pbi alloc memory size
	int		bmpsize;			// *pBit alloc memory size

	//		Window object setting
	//
	int		type;				// setting type
	int		wid;				// window ID
	short	fl_dispw;			// display window flag
	short	fl_udraw;			// update draw window
	int		wx,wy,wchg;			// actual window size x,y
	int		viewx,viewy;		// buffer view point x,y
	int		lx,ly;				// buffer view size x,y
	int		cx,cy;				// object cursor x,y
	int		ox,oy,py;			// object size x,y,py
	int		texty;				// text Y-axis size
	int		gx,gy,gmode;		// gcopy size
	HBRUSH	hbr;				// BRUSH handle
	HPEN	hpn;				// PEN handle
	HFONT	hfont;				// FONT handle
	HFONT	holdfon;			// FONT handle (old)
	COLORREF color;				// text color code
	int		textspeed;			// slow text speed
	int		cx2,cy2;			// slow text cursor x,y
	int		tex,tey;			// slow text limit x,y
	char	*prtmes;			// slow message ptr
	int		focflg;				// focus set flag
	int		objmode;			// object set mode
	LOGFONT	logfont;			// logical font
	int		style;				// extra window style
	int		gfrate;				// halftone copy rate
	int		tabmove;			// object TAB move mode
	int		sx2;				// actual bitmap X size
	SIZE	printsize;			// print,mes extent size

	//		Class depend data
	//
	int		objstyle;					// objects style
	HSPOBJINFO *mem_obj;				// Window objects
	int objmax;							// Max number of obj
	int objlimit;						// Limit number of obj
	short savepos[BMSCR_SAVEPOS_MAX];	// saved position
	void *master_hspwnd;				// Parent hspwnd class
	short	palcolor;					// Palette color code
	short	textstyle;					// Extra text style
	short	framesx, framesy;			// Window frame xy-size

private:
	void Blt( int mode, Bmscr *src, int xx, int yy, int asx, int asy );

};


//	HspWnd Base class
//
typedef void (* MM_NOTIFY_FUNC) (void *);

class HspWnd {
public:
	//	Functions
	//
	HspWnd( void );
	HspWnd( HANDLE instance, char *wndcls );
	~HspWnd( void );
	void MakeBmscr( int id, int type, int xx, int yy, int wx, int wy, int sx, int sy, int palsw );
	void MakeBmscrOff( int id, int sx, int sy, int palsw );
	inline Bmscr *GetBmscr( int id ) { return mem_bm[id]; };
	int Picload( int id, char *fname, int mode );
	int GetActive( void );
	void SetNotifyFunc( void *func );
	int GetBmscrMax( void ) { return bmscr_max; };
	void SetEventNoticePtr( int *ptr );
	void SetParentWindow( void *hwnd ) { wnd_parent = hwnd; };

	//	Data
	//
	BYTE pstpt[256*3];			// Palette backup
	int mwfx,mwfy;
	int mouse_x, mouse_y;
	int sys_iprm, sys_wprm, sys_lprm;

private:
	void Reset( HANDLE instance, char *wndcls );
	void Dispose( void );
	void ExpandScreen( int idmax );

	//	Data
	//
	HINSTANCE hInst;
	Bmscr **mem_bm;
	int bmscr_max;
	int bmscr_res;
	int wfx,wfy,wbx,wby;
	int *resptr;
	char defcls[32];			// Default Window Class
	void *wnd_parent;			// Parent Window Handle
};




//	Bmscr structure (same as Bmscr)
//
typedef struct BMSCR
{
	//
	//		Window data structure
	//
	int		flag;				// used flag
	int		sx;					// X-size
	int		sy;					// Y-size
	int		palmode;			// palmode
	HDC		hdc;				// buffer HDC
	BYTE	*pBit;				// bitmap pointer
	BITMAPINFOHEADER *pbi;		// infoheader
	HBITMAP	dib;				// bitmap handle(DIB)
	HBITMAP	old;				// bitmap handle(OLD)
	RGBQUAD *pal;				// palette table
	HPALETTE hpal;				// palette handle
	HPALETTE holdpal;			// palette handle (old)
	int		pals;				// palette entries
	HWND	hwnd;				// window handle
	HINSTANCE hInst;			// Instance of program
	int		infsize;			// *pbi alloc memory size
	int		bmpsize;			// *pBit alloc memory size

	//		Window object setting
	//
	int		type;				// setting type
	int		wid;				// window ID
	short	fl_dispw;			// display window flag
	short	fl_udraw;			// update draw window
	int		wx,wy,wchg;			// actual window size x,y
	int		viewx,viewy;		// buffer view point x,y
	int		lx,ly;				// buffer view size x,y
	int		cx,cy;				// object cursor x,y
	int		ox,oy,py;			// object size x,y,py
	int		texty;				// text Y-axis size
	int		gx,gy,gmode;		// gcopy size
	HBRUSH	hbr;				// BRUSH handle
	HPEN	hpn;				// PEN handle
	HFONT	hfont;				// FONT handle
	HFONT	holdfon;			// FONT handle (old)
	COLORREF color;				// text color code
	int		textspeed;			// slow text speed
	int		cx2,cy2;			// slow text cursor x,y
	int		tex,tey;			// slow text limit x,y
	char	*prtmes;			// slow message ptr
	int		focflg;				// focus set flag
	int		objmode;			// object set mode
	LOGFONT	logfont;			// logical font
	int		style;				// extra window style
	int		gfrate;				// halftone copy rate
	int		tabmove;			// object TAB move mode
	int		sx2;				// actual bitmap X size
	SIZE	printsize;			// print,mes extent size

	//		Class depend data
	//
	int		objstyle;			// objects style
	HSPOBJINFO *mem_obj;		// Window objects
	int objmax;					// Max number of obj
	int objlimit;				// Limit number of obj
	void *master_hspwnd;		// Parent hspwnd class
} BMSCR;

void SetObjectEventNoticePtr( int *ptr );


#endif

#endif
