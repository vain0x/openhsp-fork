#import "HspView.h"
#import "HspViewController.h"
#import "iOSBridge.h"
#import <AudioToolbox/AudioServices.h>

#include "../hsp3/hsp3config.h"
#include "../hsp3/hgio.h"
#include "../hsp3embed/hsp3embed.h"
#include "../hsp3/sysreq.h"

void gb_setogl( EAGLContext *context, GLuint viewRenderBuff, GLuint viewFrameBuff );


/*----------------------------------------------------------*/
//		DevInfo Call
/*----------------------------------------------------------*/
static HSP3DEVINFO *mem_devinfo;
static HspViewController *hspview_controller;
static int devinfo_dummy;
static char *devres_none;

static int hsp3dish_devprm( char *name, char *value )
{
	return -1;
}

static int hsp3dish_devcontrol( char *cmd, int p1, int p2, int p3 )
{
    
	if ( strcmp( cmd, "vibrate" )==0 ) {
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
		return 0;
	}
	if ( strcmp( cmd, "sound" )==0 ) {
        AudioServicesPlaySystemSound(p1);
		return 0;
	}
	if ( strcmp( cmd, "iAd" )==0 ) {
        [hspview_controller controlBanner:p1];
		return 0;
	}
	return -1;
}

static int *hsp3dish_devinfoi( char *name, int *size )
{
	*size = -1;
	return NULL;
    //	return &devinfo_dummy;
}

static char *hsp3dish_devinfo( char *name )
{
	if ( strcmp( name, "name" )==0 ) {
		return mem_devinfo->devname;
	}
	if ( strcmp( name, "error" )==0 ) {
		return mem_devinfo->error;
	}
	return NULL;
}

static void hsp3dish_setdevinfo( void )
{
	//		Initalize DEVINFO
    HSP3DEVINFO *devinfo;
    devinfo = (HSP3DEVINFO *)hsp3eb_getDevInfo();
    mem_devinfo = devinfo;
	devinfo_dummy = 0;
    devres_none = (char *)&devinfo_dummy;
	devinfo->devname = (char *)"iOSdev";
	devinfo->error = (char *)"";
	devinfo->devprm = hsp3dish_devprm;
	devinfo->devcontrol = hsp3dish_devcontrol;
	devinfo->devinfo = hsp3dish_devinfo;
	devinfo->devinfoi = hsp3dish_devinfoi;
}

/*----------------------------------------------------------*/

//HspViewの実装
@implementation HspView

//フレームの初期化
- (id)initWithFrameOrg:(CGRect)frame {
    if (self=[super initWithFrame:frame]) {
        InitSysReq();
        //グラフィックスの生成
        int sx,sy;
        sx = frame.size.width;
        sy = frame.size.height;
        disp_sx = sx;
        disp_sy = sy;
        _screenx = sx;
        _screeny = sy;
       
        _scalefix = [UIScreen mainScreen].scale;
        _scaleuse = 1.0f;

        NSLog(@"Init HspView(%d,%d)",sx,sy);
        hgio_init( 0, sx, sy, NULL );

        accelerometer = nil;
        mt_flag = 0;
        adview_enable = false;
    }
    act_mode = 0;
    return self;
}

//フレームの初期化(横画面)
- (id)initWithFrameSide:(CGRect)frame {
    CGRect side = CGRectMake( frame.origin.x, frame.origin.y, frame.size.height, frame.size.width );
    return [self initWithFrameOrg:side ];
}

//フレームの初期化(縦画面)
- (id)initWithFrame:(CGRect)frame {

    return [self initWithFrameOrg:frame ];
}

//メモリ解放
- (void)dealloc {
	hsp3eb_bye();
	hgio_term();
    if ( accelerometer != nil ) [accelerometer release];
    [super dealloc];
}

//セットアップ
- (void)setup {
    //グラフィックスのセットアップ
    gb_sethspview( self );
    gb_setogl( _context, _viewRenderBuff, _viewFrameBuff );
    gb_reset( _screenx, _screeny );
//    gb_reset( self.bgWidth, self.bgHeight );
	hsp3eb_init();
    act_mode = 1;
    hsp3dish_setdevinfo();
}

//定期処理
- (void)onTick {

    if ( act_mode == ACTMODE_NORMAL ) {
        //hsp3eb_exec();
        hsp3eb_exectime( hgio_gettick() );
        //	gb_dbgtest();
    }
}


- (void)clsMode:(int)mode color:(int)color
{
    hgio_clsmode( mode, color, 0 );
    cls_mode = mode;
    cls_color = color;
}


- (void)actMode:(int)amode
{
    if ( act_mode & ACTMODE_LOCK ) {
        if ( amode & ACTMODE_LOCK ) {
            act_mode = amode & ACTMODE_NORMAL;
        }
    } else {
        act_mode = amode;
    }
}

- (void)UseAccelerometer:(float)freq
{
    accelerometer = [UIAccelerometer sharedAccelerometer];
    accelerometer.updateInterval = freq;
    accelerometer.delegate = self;
}


- (void)useRetina {

    CAEAGLLayer* eaglLayer=(CAEAGLLayer*)self.layer;

    if ( _scalefix > 1.0f ) {
        _scaleuse = _scalefix;
        self.contentScaleFactor = _scalefix;
        eaglLayer.contentsScale = _scalefix;
        _screenx = (int)((float)disp_sx * _scalefix);
        _screeny = (int)((float)disp_sy * _scalefix);
    
        hgio_size( _screenx, _screeny );
        hgio_scale( _scalefix, _scalefix );
    }
}


- (void)useMultiTouch {

    self.multipleTouchEnabled = true;
    mt_flag = 1;
}


- (void)dispMode:(int)dmode
{
    disp_mode = dmode;
}


- (void)dispRotate:(int)rmode
{
    CGAffineTransform tf;
    float adj;
    adj = ((float)abs( disp_sx - disp_sy )) * 0.5f;
    //NSLog(@"Init Adj(%f)(%d,%d)",adj,disp_sx , disp_sy);
    switch( rmode ) {
        case 1:
            tf = CGAffineTransformMakeRotation(M_PI * 1.5f);
            tf = CGAffineTransformTranslate( tf, -adj, -adj );
            self.transform = tf;
            break;
        case 2:
            tf = CGAffineTransformMakeRotation(M_PI);
            self.transform = tf;
            break;
        case 3:
            tf = CGAffineTransformMakeRotation(M_PI * 0.5f);
            //tf = CGAffineTransformTranslate( tf, adj, adj );
            self.transform = tf;
            break;
        default:
            break;
    }
}


- (void)dispDialog:(int)type Msg:(char *)msg MsgSub:(char *)msg_sub
{
	NSString *msg1 = [[NSString alloc] initWithUTF8String:msg];
	NSString *msg2 = nil;
    UIAlertView *view_alert;
    if ( *msg_sub != 0 ) {
        msg2 = [[NSString alloc] initWithUTF8String:msg_sub];
    }
    
    dialog_type = type;
    if ( type&2 ) {
        view_alert = [[UIAlertView alloc] initWithTitle:msg2
                                                message:msg1
                                               delegate:self
                                      cancelButtonTitle:@"いいえ"
                                      otherButtonTitles:@"はい",nil
                      ];
    } else {
        view_alert = [[UIAlertView alloc] initWithTitle:msg2
                                                message:msg1
                                               delegate:self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil
                      ];
    }

    [self actMode:ACTMODE_LOCK|ACTMODE_STOP];
    
    [view_alert show];
    [view_alert release];
    [msg1 release];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ( dialog_type & 2 ) {
        if ( buttonIndex == 0 )  hsp3eb_setstat(7);
        if ( buttonIndex == 1 )  hsp3eb_setstat(6);
    } else {
        hsp3eb_setstat(0);
    }
    [self actMode:ACTMODE_LOCK|ACTMODE_NORMAL];
}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch;
	CGPoint location;
    int count;
    int p_id;

	if ( mt_flag ) {
        // マルチタッチ時
        count = 0;
        NSEnumerator *enumlator = [touches objectEnumerator];
        while( touch = [enumlator nextObject] ) {
            location = [touch locationInView:self];
            p_id = [touch hash];
            hgio_mtouchid( p_id, location.x * _scaleuse, location.y * _scaleuse, 1, count );
            count++;
        }

    } else {
        // マルチタッチでない時
        touch = [touches anyObject];
        location = [touch locationInView:self];
        p_id = -1;
        //NSInteger taps = [touch tapCount];
        hgio_touch( location.x * _scaleuse, location.y * _scaleuse, 1 );
    }

	//NSLog(@"タップ開始 %f, %f ID%d", location.x, location.y, p_id );
	[super touchesBegan:touches withEvent:event];
}


- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch;
//  CGPoint oldLocation;
	CGPoint newLocation;
    int p_id;
    int count;
    
	if ( mt_flag ) {
        // マルチタッチ時
        count = 0;
        NSEnumerator *enumlator = [touches objectEnumerator];
        while( touch = [enumlator nextObject] ) {
            //oldLocation = [touch previousLocationInView:self];
            newLocation = [touch locationInView:self];
            p_id = [touch hash];
            hgio_mtouchid( p_id, newLocation.x * _scaleuse, newLocation.y * _scaleuse, 1, count );
            count++;
        }
        
    } else {
        // マルチタッチでない時
        touch = [touches anyObject];
//        oldLocation = [touch previousLocationInView:self];
        newLocation = [touch locationInView:self];
        p_id = -1;
        hgio_touch( newLocation.x * _scaleuse, newLocation.y * _scaleuse, 1 );
    }
    
	//NSLog( @"指の動き：%f, %f ID%d", newLocation.x, newLocation.y, p_id);
	[super touchesMoved:touches withEvent:event];
}


- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch;
	CGPoint location;
    int p_id;
    int count;
    
	if ( mt_flag ) {
        // マルチタッチ時
        count = 0;
        NSEnumerator *enumlator = [touches objectEnumerator];
        while( touch = [enumlator nextObject] ) {
            //oldLocation = [touch previousLocationInView:self];
            location = [touch locationInView:self];
            p_id = [touch hash];
            hgio_mtouchid( p_id, location.x * _scaleuse, location.y * _scaleuse, 0, count );
            count++;
        }
        //NSLog(@"タップ終了 %f, %f ID%d", location.x, location.y, p_id);
        
    } else {
        // マルチタッチでない時
        touch = [touches anyObject];
        location = [touch locationInView:self];
        //NSInteger taps = [touch tapCount];
        hgio_touch( location.x * _scaleuse, location.y * _scaleuse, 0 );
        //NSLog(@"タップ終了 %f, %f", location.x, location.y);
    }
	
	[super touchesEnded:touches withEvent:event];
	
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch;
	CGPoint location;
    int p_id;
    int count;
    
	if ( mt_flag ) {
        // マルチタッチ時
        count = 0;
        NSEnumerator *enumlator = [touches objectEnumerator];
        while( touch = [enumlator nextObject] ) {
            //oldLocation = [touch previousLocationInView:self];
            location = [touch locationInView:self];
            p_id = [touch hash];
            hgio_mtouchid( p_id, location.x * _scaleuse, location.y * _scaleuse, 0, count );
            count++;
            //NSLog(@"タップ終了 %f, %f ID%d", location.x, location.y, p_id);
        }
    
    } else {
        // マルチタッチでない時
        touch = [touches anyObject];
        location = [touch locationInView:self];
        //NSInteger taps = [touch tapCount];
        hgio_touch( location.x * _scaleuse, location.y * _scaleuse, 0 );
        //NSLog(@"タップ終了 %f, %f", location.x, location.y);
    }
	
	[super touchesCancelled:touches withEvent:event];
	
}

- (void) accelerometer:(UIAccelerometer*)accelerometer didAccelerate:(UIAcceleration*)acceleration
{
    hgio_setinfo( HGIO_INFO_ACCEL_X, (HSPREAL)acceleration.x );
    hgio_setinfo( HGIO_INFO_ACCEL_Y, (HSPREAL)acceleration.y );
    hgio_setinfo( HGIO_INFO_ACCEL_Z, (HSPREAL)acceleration.z );
	//[view SetAccel_x:acceleration.x accy:acceleration.y accz:acceleration.z];
	//NSLog(@"---%g,%g,%g", x,y,z );
	//[glView updateAccelerometer:accelerometer.x Y:accelerometer.y Z:accelerometer.z];
}


- (void)dispViewX:(int)x Y:(int)y
{
    int xsize, ysize;
    xsize = x; ysize = y;
    if ( xsize < 0 ) { xsize = disp_sx; }
    if ( ysize < 0 ) { ysize = disp_sy; }
    hgio_view(xsize,ysize);
}

- (void)dispScaleX:(int)x Y:(int)y
{
    hgio_scale(x, y);
}

- (void)dispAutoScale:(int)mode
{
    hgio_autoscale(mode);
}

- (void)setParent:(UIViewController *)controller
{
    parent = controller;
    hspview_controller = (HspViewController *)controller;
	NSLog(@"---%x", controller );
}

@end
