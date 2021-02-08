//
//  AdHubSplash.m
//  widget_ad_hub
//
//  Created by Howie Xu on 2021/2/7.
//

#import "AdHubSplashAd.h"
#import <AdHubSDK/AdHubSDK.h>
@interface AdHubSplashAd () <AdHubSplashDelegate>

@property (nonatomic, strong) AdHubSplash *splash;
@property (nonatomic, strong) NSObject<FlutterBinaryMessenger>* messenger;
@property (nonatomic, strong) FlutterMethodChannel* channel;

@end

@implementation AdHubSplashAd

{
    CGRect _frame;
    int64_t _viewId;
    id _args;
    UILabel *_subLabel;
}

- (instancetype)initWithWithFrame:(CGRect)frame
                   viewIdentifier:(int64_t)viewId
                        arguments:(id _Nullable)args
                  binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger {
    if (self = [super init])
    {
        _frame = frame;
        _viewId = viewId;
        _args = args;
        _messenger = messenger;
    }
    return self;
}

- (void)setRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    _registrar = registrar;
    NSString *channelName = [NSString stringWithFormat:@"%@#%lld", @"com.cabe.flutter.widget.AdHubSplash", _viewId];
    _channel = [FlutterMethodChannel methodChannelWithName:channelName binaryMessenger:[registrar messenger]];
    [_registrar addMethodCallDelegate:self channel:_channel];
}

- (UIView *)view {
    NSString *adId = _args[@"adId"];
    NSInteger timeout = [_args[@"timeout"] integerValue];
    // 初始化广告位
    if (!_splash) {
        self.splash = [[AdHubSplash alloc]initWithSpaceID:adId spaceParam:@"" lifeTime:timeout];
        // 设置当前的VC，用于广告位点击跳转
        self.splash.delegate = self;
    }
    [self.splash ADH_loadAndDisplaySplashAd];
    return [[UIView alloc] initWithFrame:CGRectZero];
}

/**
@return 展示下部logo位置，需要给传入view设置尺寸。
*/
//- (UIView *)ADH_splashBottomView {
//    
//}

/**
开屏展现
*/
- (void)ADH_splashDidPresentScreen:(AdHubSplash *)adHubSplash {
    NSLog(@"---- ADH_splashDidPresentScreen");
    [_channel invokeMethod:@"ADH_splashDidPresentScreen" arguments:nil];
}

/**
开屏点击
*/
- (void)ADH_splashDidClick:(AdHubSplash *)adHubSplash {
    NSLog(@"---- ADH_splashDidClick");
    [_channel invokeMethod:@"ADH_splashDidClick" arguments:nil];
}

/**
开屏消失
*/
- (void)ADH_splashDidDismissScreen:(AdHubSplash *)adHubSplash {
    NSLog(@"---- ADH_splashDidDismissScreen");
    [_channel invokeMethod:@"ADH_splashDidDismissScreen" arguments:nil];
}

/**
开屏请求失败
*/
- (void)ADH_splash:(AdHubSplash *)adHubSplash didFailToLoadAdWithError:(AdHubRequestError *)error {
    NSLog(@"---- ADH_splash didFailToLoadAdWithError");
    [_channel invokeMethod:@"ADH_splash didFailToLoadAdWithError" arguments:@{@"errorCode": @(error.code)}];
}
/**
开屏剩余时间，自定义跳过按钮时候有回调
*/

- (void)ADH_splashAdLifeTime:(int)lifeTime {
    NSLog(@"ADH_splashAdLifeTime");
    [_channel invokeMethod:@"ADH_splashAdLifeTime" arguments:nil];
}

@end
