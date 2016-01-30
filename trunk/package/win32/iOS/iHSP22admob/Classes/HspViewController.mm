/*
    File: HspViewController.m
*/

#import "HspViewController.h"
extern "C" {
#import "../AdMob/GADBannerView.h"
};

static GADBannerView *adMobView;


@implementation HspViewController

- (instancetype)init
{
    self = [super init];
    NSLog(@"Init HspViewController");
    adView = nil;
    adMobView = nil;
    return self;
}

- (void)dealloc
{
    [super dealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setHspView:(HspView *)hspview
{
    [self setView:hspview];
    [hspview setParent:self];
}

- (void)controlBanner:(int)prm
{
    if ( adView == nil ) {
        CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
        adView = [[[ADBannerView alloc] initWithFrame:CGRectZero] autorelease];
        adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
        adView.frame = CGRectOffset(adView.frame, 0, screenRect.size.height);
    
        [self.view addSubview:adView];
        adView.delegate = self;
        bannerIsVisible = false;
        //[self bannerViewDidLoadAd:adView];
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear");
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"viewDidDisappear");
}


- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if (!bannerIsVisible)
    {
        [UIView
         animateWithDuration:1.0
         animations:^{
             adView.frame = CGRectOffset(banner.frame, 0, -banner.frame.size.height);
         }
         ];
        
        bannerIsVisible = true;
    }
}


- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError*)error
{
    if (bannerIsVisible)
    {
        [UIView
         animateWithDuration:1.0
         animations:^{
             adView.frame = CGRectOffset(banner.frame, 0, banner.frame.size.height);
         }
         ];
        
        bannerIsVisible = false;
    }
}

- (void)actMode:(int)amode
{
    HspView *hspview;
    hspview = (HspView *)self.view;
    [hspview actMode:amode];
    //NSLog(@"actmode%d",amode);
}

- (void)controlAdMobBanner:(int)prm
{
    if ( adMobView == nil ) {
	// 画面下部に標準サイズのビューを作成する
	adMobView = [[GADBannerView alloc]
                   initWithFrame:CGRectMake(0.0,
                                            self.view.frame.size.height -
                                            GAD_SIZE_320x50.height,
                                            GAD_SIZE_320x50.width,
                                            GAD_SIZE_320x50.height)];

	// 広告の「ユニット ID」を指定する。これは AdMob パブリッシャー ID です。
	adMobView.adUnitID = @"a??????????????";

	// ユーザーに広告を表示した場所に後で復元する UIViewController をランタイムに知らせて
	// ビュー階層に追加する。
	adMobView.rootViewController = self;
	[self.view addSubview:adMobView];

	// 一般的なリクエストを行って広告を読み込む。
	[adMobView loadRequest:[GADRequest request]];

    } else {
	if ( prm < 0 ) {
	    [adMobView release];
	    adMobView = nil;
	}
    }
}

@end
