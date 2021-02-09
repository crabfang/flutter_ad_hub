//
//  AdHubBanner.m
//  widget_ad_hub
//
//  Created by Howie Xu on 2021/2/7.
//

#import "AdHubBanner.h"
#import <AdHubSDK/AdHubSDK.h>

@interface AdHubBanner () <AdHubBannerViewDelegate>

@property (nonatomic, strong) AdHubBannerView *banner;
@property (nonatomic, strong) AdHubNativeExpress *nativeExpress;
@property (nonatomic, strong) NSObject<FlutterBinaryMessenger>* messenger;
@property (nonatomic, strong) FlutterMethodChannel* channel;
@property (nonatomic, strong) UIView *bgView;


@end

@implementation AdHubBanner
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
        _args[@"showHeight"] = @(64);
        _messenger = messenger;
    }
    return self;
}

- (void)setRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    _registrar = registrar;
    NSString *channelName = [NSString stringWithFormat:@"%@#%lld", @"com.cabe.flutter.widget.AdHubBanner", _viewId];
    _channel = [FlutterMethodChannel methodChannelWithName:channelName binaryMessenger:[registrar messenger]];
    [_registrar addMethodCallDelegate:self channel:_channel];
}

- (UIView *)view {
    // 初始化广告位
    NSString *adId = _args[@"adId"];
    NSInteger timeout = [_args[@"timeout"] integerValue];
    NSInteger showWidth = [_args[@"showWidth"] integerValue];
    NSInteger showHeight = [_args[@"showHeight"] integerValue];
    if (showWidth < 1) {
        showWidth = 360;
    }
    if (showHeight < 1) {
        showHeight = showWidth / 6.4;
    }
    if (!_bgView) {
        self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, showWidth, showHeight)];
    }

    if (!_banner) {
        self.banner = [[AdHubBannerView alloc] initWithFrame:CGRectMake(0, 0, showWidth, showHeight) spaceID:adId spaceParam:@"" lifeTime:timeout];
        self.banner.delegate = self;
    }
    // 设置当前的VC，用于广告位点击跳转
    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
    self.banner.adhubBannerViewController = window.rootViewController;

    // 加载广告
    [self.banner ADH_loadBannerAd];
    [self.bgView addSubview:self.banner];
    return self.bgView;
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"refresh" isEqualToString:call.method]) {
      NSLog(@"ADH_refresh");
      NSString *adId = _args[@"adId"];
      NSInteger timeout = [_args[@"timeout"] integerValue];
      NSInteger showWidth = [_args[@"showWidth"] integerValue];
      NSInteger showHeight = [_args[@"showHeight"] integerValue];
      if (showWidth < 1) {
          showWidth = 360;
      }
      if (showHeight < 1) {
          showHeight = showWidth / 6.4;
      }
//      if (!_banner) {
          self.banner = [[AdHubBannerView alloc] initWithFrame:CGRectMake(0, 0, showWidth, showHeight) spaceID:adId spaceParam:@"" lifeTime:timeout];
          self.banner.delegate = self;
//      }

      // 设置当前的VC，用于广告位点击跳转
      UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
      self.banner.adhubBannerViewController = window.rootViewController;
      // 加载广告
      [self.banner ADH_loadBannerAd];
  }
}

/**
Banner广告请求成功
*/
- (void)ADH_bannerDidReceiveAd:(AdHubBannerView *)adHubBanner {
    [_channel invokeMethod:@"ADH_bannerDidReceiveAd" arguments:nil];
    if (self.bgView.subviews.count > 0) {
        [self.bgView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    [self.bgView addSubview:self.banner];
}

/**
Banner广告点击
*/
- (void)ADH_bannerDidClick:(AdHubBannerView *)adHubBanner {
    [_channel invokeMethod:@"ADH_bannerDidClick" arguments:nil];
}

/**
Banner广告消失
*/
- (void)ADH_bannerDidDismissScreen:(AdHubBannerView *)adHubBanner {
    [_channel invokeMethod:@"ADH_bannerDidDismissScreen" arguments:nil];
}

/**
Banner广告请求失败
*/
- (void)ADH_banner:(AdHubBannerView *)adHubBanner didFailToLoadAdWithError:(AdHubRequestError *)error {
    [_channel invokeMethod:@"ADH_banner didFailToLoadAdWithError" arguments:@{@"errorcode": @(error.code)}];
}

@end
