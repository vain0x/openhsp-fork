/*
    File: HspViewController.m
*/

#import "HspViewController.h"


@implementation HspViewController

- (instancetype)init
{
    self = [super init];
    NSLog(@"Init HspViewController");
    adView = nil;
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
    NSLog(@"controlBanner___");
    if ( adView == nil ) {
        CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
        adView = [[[ADBannerView alloc] initWithFrame:CGRectZero] autorelease];
        adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
        adView.frame = CGRectOffset(adView.frame, 0, screenRect.size.height);
    
        [self.view addSubview:adView];
        adView.delegate = self;
        bannerIsVisible = false;
        //[self bannerViewDidLoadAd:adView];
        NSLog(@"controlBanner");
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

@end
