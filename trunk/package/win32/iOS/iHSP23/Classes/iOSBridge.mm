//
//		Draw lib (ios)
//			onion software/onitama 2001/6
//			               onitama 2011/5
//

//#include <stdio.h>
//#include <math.h>

#import "HspView.h"
#import "misc.h"
#import "Graphics.h"
#import "iOSBridge.h"

#include "../hsp3/supio.h"
#include "../hsp3/sysreq.h"

#include "../hsp3/hsp3config.h"
#include "../hsp3/hgio.h"

#define CIRCLE_DIV 16
#define DEFAULT_FONT_NAME ""
#define DEFAULT_FONT_SIZE 14
#define DEFAULT_FONT_STYLE 0

static int		nDestWidth,nDestHeight;
static int		drawflag;
static BMSCR    *mainbm = NULL;
static HspView  *hspview = NULL;

/*------------------------------------------------------------*/
/*
		iOS Base System
*/
/*------------------------------------------------------------*/

#define IMGARRAY_MAX 64

static Graphics* _g;     
static Image*    _image[IMGARRAY_MAX];
static int mouse_x, mouse_y, mouse_btn;

static EAGLContext* _context;        //コンテキスト
static GLuint       _viewRenderBuff; //レンダーバッファ
static GLuint       _viewFrameBuff;  //フレームバッファ

void gb_init( void )
{
	//グラフィックスの生成
	_g=[[Graphics alloc] init];
	
	//イメージの初期化
	for(int i=0;i<IMGARRAY_MAX;i++) {
		_image[i]=nil;
	}
}

void gb_setogl( EAGLContext *context, GLuint viewRenderBuff, GLuint viewFrameBuff )
{
    _context = context;
    _viewRenderBuff = viewRenderBuff;
    _viewFrameBuff = viewFrameBuff;
}

void gb_sethspview( void *view )
{
    hspview = (HspView *)view;
}

void gb_delimage( int i )
{
	if ( _image[i]!=nil ) {
		[_image[i] release];
		_image[i]=nil;
	}
}


void gb_bye( void )
{
	for(int i=0;i<IMGARRAY_MAX;i++) {
		gb_delimage( i );
	}
	[_g release];
}


void gb_reset( int sx, int sy )
{
    [_g initSize:CGSizeMake(sx,sy)];
    [_g setLineWidth:1];
    [_g setFontSize:14];
    [_g setColor:rgb(0,0,0)];
}


void gb_gcls( int r, int g, int b )
{
    //バッファのクリア
	[_g clear_r:r g:g b:b ];
    [_g clear];
}


void gb_dbgtest( void )
{
    gb_gcls( 0, 0, 0 );

    [_g setColor:rgb(255,255,255)];
    [_g setLineWidth:1];
    [_g drawRect_x:10 y:100 w:60 h:60];
    
    //テキストの描画
    [_g setFontSize:12];
    [_g drawString:@"HSP3Dish Ready" x:10 y:10];
}


void gb_color( int r, int g, int b )
{
    [_g setColor:rgb(r,g,b)];
}


void gb_colorset( BMSCR *bm )
{
    int r,g,b;
    r = ( bm->color >>16 ) & 0xff;
    g = ( bm->color >>8  ) & 0xff;
    b = ( bm->color ) & 0xff;
    [_g setColor:rgb(r,g,b)];
}


void gb_font( int size, int style, char *msg )
{
	//	とりあえずサイズのみ反映
	[_g setFontSize:size];
}


void gb_boxf( int x1, int y1, int x2, int y2 )
{
    [_g fillRect_x:x1 y:y1 w:x2-x1 h:y2-y1];
}


void gb_celput( int xx, int yy, int bufid, int srcx, int srcy, int sx, int sy )
{
    [_g drawScaledImage:_image[bufid]
					  x:xx y:yy w:sx h:sy
					 sx:srcx sy:srcy sw:sx sh:sy];
}


void gb_celput2( int xx, int yy, int dx, int dy, int bufid, int srcx, int srcy, int sx, int sy )
{
    [_g drawScaledImage:_image[bufid]
					  x:xx y:yy w:dx h:dy
					 sx:srcx sy:srcy sw:sx sh:sy];
}


void gb_zoom( int xx, int yy, int dx, int dy, int bufid, int srcx, int srcy, int sx, int sy )
{
    [_g drawScaledFlipImage:_image[bufid]
					  x:xx y:yy w:dx h:dy
					 sx:srcx sy:srcy sw:sx sh:sy];
}


void gb_circle( float x1, float y1, float x2, float y2, int mode )
{
	float xx,yy,rx,ry;

	rx = ((float)abs(x2-x1))*0.5f;
	ry = ((float)abs(y2-y1))*0.5f;
	xx = ((float)x1) + rx;
	yy = ((float)y1) + ry;

	if ( mode ) {
		[_g fillCircle_x:xx y:yy rx:rx ry:ry ];
	} else {
		[_g drawCircle_x:xx y:yy rx:rx ry:ry ];
	}
}


void gb_line( float x1, float y1, float x2, float y2 )
{
    [_g drawLine_x0:x1 y0:y1 x1:x2 y1:y2];
}


int gb_celload( int bufid, char *fname, int *sx, int *sy )
{
	gb_delimage( bufid );

	NSString *nsstr = [[NSString alloc] initWithUTF8String:fname];

	_image[bufid] = [[Image makeImage:[UIImage imageNamed:nsstr]] retain];
	//_image[bufid] = [[Image makeImageFromFile:nsstr] retain];

	[nsstr release];
  
    if ( _image[bufid] == nil ) return -1;

	*sx = [_image[bufid] width];
	*sy = [_image[bufid] height];
	return 0;
}


void gb_mouse( int xx, int yy, int button )
{
	mouse_x = xx;
	mouse_y = yy;
	mouse_btn = button;
    if ( mainbm != NULL ) {
        mainbm->savepos[BMSCR_SAVEPOS_MOSUEX] = xx;
        mainbm->savepos[BMSCR_SAVEPOS_MOSUEY] = yy;
    }
}

int gb_getmousex( void )
{
	return mouse_x;
}


int gb_getmousey( void )
{
	return mouse_y;
}


int gb_getmousebtn( void )
{
	return mouse_btn;
}


int gb_render_start( void )
{
	if ( GetSysReq( SYSREQ_CLSMODE ) == CLSMODE_SOLID ) {
		int ccol = GetSysReq( SYSREQ_CLSCOLOR );
		gb_gcls( (ccol>>16)&0xff, (ccol>>8)&0xff, ccol&0xff );
	}
    
    //前処理
    [EAGLContext setCurrentContext:_context];
    glBindFramebufferOES(GL_FRAMEBUFFER_OES,_viewFrameBuff);
    
    //    glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR); 
    //    glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR); 
    glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_NEAREST); 
    glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_NEAREST); 
   
	return 0;
}


int gb_render_end( void )
{
    //後処理
    glBindRenderbufferOES(GL_RENDERBUFFER_OES,_viewRenderBuff);
    [_context presentRenderbuffer:GL_RENDERBUFFER_OES];
    
	return 0;
}


/*------------------------------------------------------------*/
/*
		interface
*/
/*------------------------------------------------------------*/

/*------------------------------------------------------------*/
/*
 Polygon Draw Routines
 */
/*------------------------------------------------------------*/

//テクスチャ頂点情報
static GLfloat vert2D[]={
    0,  0, //左上
    0, -1, //左下
    1,  0, //右上
    1, -1, //右下
};

static GLfloat vertf2D[]={
    0,  0, //左上
    0, -1, //左下
    1,  0, //右上
    1, -1, //右下
};

//テクスチャUV情報
static GLfloat uv2D[]={
    0.0f, 0.0f, //左上
    0.0f, 1.0f, //左下
    1.0f, 0.0f, //右上
    1.0f, 1.0f, //右下
};

static GLfloat uvf2D[]={
    0.0f, 0.0f, //左上
    0.0f, 1.0f, //左下
    1.0f, 0.0f, //右上
    1.0f, 1.0f, //右下
};


int gb_mes( BMSCR *bm, char *msg )
{
	if ( bm->type != HSPWND_TYPE_MAIN ) throw HSPERR_UNSUPPORTED_FUNCTION;
    
    gb_colorset( bm );
    
    NSString *nsstr = [[NSString alloc] initWithUTF8String:msg];

    //[_g drawString:nsstr x:bm->cx y:bm->cy];
    Image *image = [_g makeTextImage:nsstr];
	[nsstr release];

    if (image==nil) return -1;
    
    GLfloat *flp;
    GLfloat x1,y1,x2,y2;
    float ratex,ratey,psx,psy;
    
    psx = image.width;
    psy = image.height;
    
    flp = vertf2D;
    x1 = (GLfloat)bm->cx;
    y1 = (GLfloat)-bm->cy;
    x2 = x1+psx;
    y2 = y1-psy;
    
    *flp++ = x1;
    *flp++ = y1;
    *flp++ = x1;
    *flp++ = y2;
    *flp++ = x2;
    *flp++ = y1;
    *flp++ = x2;
    *flp++ = y2;
    
    //ratex = 1.0f / image.width;
    //ratey = 1.0f / image.height;
    ratex = image.ratex;
    ratey = image.ratey;
    
    flp = uvf2D;
    x1 = 0.0f;
    y1 = 0.0f;
    x2 = (GLfloat)(psx * ratex);
    y2 = (GLfloat)(psy * ratey);
    
    *flp++ = x1;
    *flp++ = y1;
    *flp++ = x1;
    *flp++ = y2;
    *flp++ = x2;
    *flp++ = y1;
    *flp++ = x2;
    *flp++ = y2;
    
    glBindTexture(GL_TEXTURE_2D,image.name);
    glVertexPointer(2,GL_FLOAT,0,vertf2D);
    glTexCoordPointer(2,GL_FLOAT,0,uvf2D);
    
    [_g setBlendMode:2 alpha:255];
    //    glDisableClientState(GL_COLOR_ARRAY);
    glDrawArrays(GL_TRIANGLE_STRIP,0,4);
    
#if 0
	NSString *nsstr = [[NSString alloc] initWithUTF8String:msg];
	[_g drawString:nsstr x:xx y:yy];
	[nsstr release];
#endif
    bm->printsizex = psx;
    bm->printsizey = psy * 0.8f;
    return 0;
}

/*------------------------------------------------------------*/
/*
 file I/O service
 */
/*------------------------------------------------------------*/

static  char fpath_tmp[1024];

char *gb_filepath( char *base )
{
	NSString *fname = [[NSString alloc] initWithUTF8String:base];
	NSString *path = [[NSBundle mainBundle] pathForResource:fname ofType:nil inDirectory:nil];
    if ( path ) {
        sprintf( fpath_tmp, "%s", [path cStringUsingEncoding:1] );
    } else {
        fpath_tmp[0] = 0;
    }
    [fname release];
    return fpath_tmp;
}


int gb_existdata(char* key)
{
	NSString *nskey = [[NSString alloc] initWithUTF8String:key];
	NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
	NSData* nsdata = [defaults dataForKey:nskey];
	[nskey release];
	if(nsdata) {
		int sizeorg = [nsdata length];
        return sizeorg;
	}
	return -1;
}


int gb_loaddata( char* key, char* data, int size, int offset )
{
	NSString *nskey = [[NSString alloc] initWithUTF8String:key];
	NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
	NSData* nsdata = [defaults dataForKey:nskey];
	[nskey release];
	if(nsdata) {
		int sizeorg = [nsdata length];
        if ( sizeorg > (size+offset) ) sizeorg = size-offset;
        unsigned char *dataorg = (unsigned char *)[nsdata bytes];
        memcpy( data, dataorg+offset, sizeorg );
        Alertf( "loaddata: %s,%d,%d", key, sizeorg, offset );
        return 0;
	}
	return -1;
}


void gb_savedata(char* key, char* data, int size, int offset)
{
    int orgsize;
    unsigned char* datatmp;
	NSString *nskey = [[NSString alloc] initWithUTF8String:key];
	NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    if ( offset <= 0 ) {
        orgsize = size;
        datatmp = new unsigned char[size];
        memcpy(datatmp, data, size);
    } else {
        orgsize = gb_existdata(key);
        if ( orgsize <= 0 ) orgsize = size + offset;
        if ( orgsize < (offset+size) ) orgsize = size + offset;
        datatmp = new unsigned char[orgsize];

        gb_loaddata( key, (char *)datatmp, orgsize, 0 );
        
        memcpy( datatmp+offset, data, size );
    }
    
	NSData* nsdata = [NSData dataWithBytes:datatmp length:orgsize];
	[defaults setObject:nsdata forKey:nskey];
    [defaults synchronize];
	
	Alertf( "savedata: %s,%d,%d", key, size, offset);
    
	delete datatmp;
    
	[nskey release];
}


int gb_dialog( int type, char *msg, char *msg_sub )
{
    //Alertf( "dialog: %s,%d", msg, type);
    [hspview dispDialog:type Msg:msg MsgSub:msg_sub];
    return 0;
}

int gb_exec( int type, char *name )
{
	NSString *fname = [[NSString alloc] initWithUTF8String:name];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:fname]];
    [fname release];
    return 0;
}

void gb_getSysModel( char *outbuf )
{
	NSString *dev = [[UIDevice currentDevice]model];
    sprintf( outbuf, "%s", [dev cStringUsingEncoding:1] );
}

void gb_getSysVer( char *outbuf )
{
	NSString *version = [[UIDevice currentDevice]systemVersion];
    sprintf( outbuf, "iOS %s", [version cStringUsingEncoding:1] );
}




