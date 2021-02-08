#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import "WidgetAdHubPlugin.h"
#import <AdHubSDK/AdHubSDK.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //[AdHubSDKManager configureWithApplicationID:@"20160"];
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
