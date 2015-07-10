/*
    File: HspViewController.h
*/

#import <UIKit/UIKit.h>
#import <iAD/iAd.h>
#import "HspView.h"

@interface HspViewController : UIViewController<ADBannerViewDelegate>  {
    
    ADBannerView *adView;
    bool bannerIsVisible;
}
- (void)setHspView:(HspView *)hspview;
- (void)controlBanner:(int)prm;
- (void)actMode:(int)amode;

@end
