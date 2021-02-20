#import "WidgetAdHubPlugin.h"
#import <AdHubSDK/AdHubSDK.h>
#import "AdHubBannerFactory.h"
#import "AdHubNativeFactory.h"
#import "AdHubSplashFactory.h"
#import "AdHubRewardVideoFactory.h"
#import "AdHubFullScreenVideoFactory.h"

@implementation WidgetAdHubPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    
    FlutterMethodChannel* channel = [FlutterMethodChannel methodChannelWithName:@"AdHubPlugin" binaryMessenger:[registrar messenger]];
    WidgetAdHubPlugin* instance = [[WidgetAdHubPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
    
    AdHubBannerFactory *bannerFactory = [[AdHubBannerFactory alloc] init];
    bannerFactory.registrar = registrar;
    [registrar registerViewFactory:bannerFactory withId:@"com.cabe.flutter.widget.AdHubBanner"];
    AdHubFullScreenVideoFactory *fullScreenFactory = [[AdHubFullScreenVideoFactory alloc] init];
    fullScreenFactory.registrar = registrar;
    [registrar registerViewFactory:fullScreenFactory withId:@"com.cabe.flutter.widget.FullScreenVideoAd"];
    AdHubNativeFactory *nativeFactory = [[AdHubNativeFactory alloc] init];
    nativeFactory.registrar = registrar;
    [registrar registerViewFactory:nativeFactory withId:@"com.cabe.flutter.widget.AdHubNative"];
    AdHubSplashFactory *splashFactory = [[AdHubSplashFactory alloc] init];
    splashFactory.registrar = registrar;
    [registrar registerViewFactory:splashFactory withId:@"com.cabe.flutter.widget.AdHubSplash"];
    AdHubRewardVideoFactory *rewardFactory = [[AdHubRewardVideoFactory alloc] init];
    rewardFactory.registrar = registrar;
    [registrar registerViewFactory:rewardFactory withId:@"com.cabe.flutter.widget.RewardedVideoAd"];
}


- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else if ([@"init" isEqualToString:call.method]) {
    NSString *appId = call.arguments[@"appIdOfIOS"];
    [AdHubSDKManager configureWithApplicationID:appId];
    [AdHubSDKManager openTheAdHubLog];
    // result(@{@"code":@(0)});
    result(@0);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
