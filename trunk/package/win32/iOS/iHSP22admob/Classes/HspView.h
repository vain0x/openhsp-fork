#import "Canvas.h"
#import "Graphics.h"
#import "Image.h"
#import <iAd/iAd.h>

#define ACTMODE_LOCK 2
#define ACTMODE_NORMAL 1
#define ACTMODE_STOP 0

//HspViewの宣言
@interface HspView : Canvas <UIAlertViewDelegate,UIAccelerometerDelegate> {
    int act_mode;
    int disp_mode;
	int cls_mode;
	int cls_color;

    int dialog_type;
    int disp_sx, disp_sy;
    CGFloat      _scalefix;
    CGFloat      _scaleuse;
    int          _screenx;
    int          _screeny;

    int          mt_flag;
    bool         adview_enable;
    int          adview_flag;
    UIAccelerometer *accelerometer;
    UIViewController *parent;
    
}
- (void)actMode:(int)amode;
- (void)dispMode:(int)dmode;
- (void)dispRotate:(int)rmode;
- (void)clsMode:(int)mode color:(int)color;
- (void)dispDialog:(int)type Msg:(char *)msg MsgSub:(char *)msg2;
- (void)dispViewX:(int)x Y:(int)y;
- (void)dispScaleX:(int)x Y:(int)y;
- (void)dispAutoScale:(int)mode;
- (void)UseAccelerometer:(float)freq;
- (void)useMultiTouch;
- (void)useRetina;
- (void)setParent:(UIViewController *)controller;
- (id)initWithFrameSide:(CGRect)frame;
- (id)initWithFrameOrg:(CGRect)frame;


@end
