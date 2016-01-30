//
//  AppDelegate.m
//  for hsp3dish
//
//

#import "AppDelegate.h"
#import "../../iHSP23/Classes/HspView.h"

@implementation AppDelegate

@synthesize window = _window;

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];

    //ビューの生成と追加
    HspView* view=[[HspView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];

    [view startFrame:60];
    [view useRetina];
//    [view dispRotate:3];
    [view useMultiTouch];
    [view dispViewX:480 Y:800];
    [view dispAutoScale:0];
    [view clsMode:0 color:0xffffff];
//    [view UseAccelerometer::1.0f / 30.0f];

    hsp = [[HspViewController alloc] init];
    [hsp setHspView:view];
    self.window.rootViewController = hsp;
    
    [view release];
    
    // Override point for customization after application launch.
    //self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
    HspView* view =(HspView*)[self.window.subviews objectAtIndex:0];
    [view actMode:0];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    HspView* view =(HspView*)[self.window.subviews objectAtIndex:0];
    [view actMode:1];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
