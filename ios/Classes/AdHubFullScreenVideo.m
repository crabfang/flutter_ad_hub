//
//  AdHubFullScreenVideo.m
//  widget_ad_hub
//
//  Created by Howie Xu on 2021/2/7.
//

#import "AdHubFullScreenVideo.h"
#import <AdHubSDK/AdHubSDK.h>

@interface AdHubFullScreenVideo () <AdHubFullscreenVideoDelegate>

@property (nonatomic, strong) AdHubFullscreenVideo *fullscreenVideo;
@property (nonatomic, strong) NSObject<FlutterBinaryMessenger>* messenger;
@property (nonatomic, strong) FlutterMethodChannel* channel;

@end

@implementation AdHubFullScreenVideo

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
    NSString *channelName = [NSString stringWithFormat:@"%@#%lld", @"com.cabe.flutter.widget.FullScreenVideoAd", _viewId];
    _channel = [FlutterMethodChannel methodChannelWithName:channelName binaryMessenger:[registrar messenger]];
//    _basicChannel = [FlutterBasicMessageChannel messageChannelWithName:channelName binaryMessenger:[registrar messenger]];
    [_registrar addMethodCallDelegate:self channel:_channel];
}

- (UIView *)view {
    NSString *adId = _args[@"adId"];
    NSInteger timeout = [_args[@"timeout"] integerValue];
    if (!_fullscreenVideo) {
        self.fullscreenVideo = [[AdHubFullscreenVideo alloc]initWithSpaceID:adId spaceParam:@"" lifeTime:timeout];
        self.fullscreenVideo.delegate = self;
    }
//    [self.fullscreenVideo ADH_loadFullscreenVideoAd];
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"loadAd" isEqualToString:call.method]) {
      [self.fullscreenVideo ADH_loadFullscreenVideoAd];
  }
}

/**
全屏视频物料请求成功
*/
- (void)ADH_fullscreenVideoDidReceiveAd:(AdHubFullscreenVideo *)adHubFullscreenVideo {
    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
    [self.fullscreenVideo ADH_showFullscreenVideoAdFromRootViewController:window.rootViewController];
    [_channel invokeMethod:@"ADH_fullscreenVideoDidReceiveAd" arguments:nil];
}

/**
全屏展现并开始播放视频
*/
- (void)ADH_fullscreenVideoDidStartPlay:(AdHubFullscreenVideo *)adHubFullscreenVideo {
    [_channel invokeMethod:@"ADH_fullscreenVideoDidStartPlay" arguments:nil];
}

/**
全屏视频点击
*/
- (void)ADH_fullscreenVideoDidClick:(AdHubFullscreenVideo *)adHubFullscreenVideo {
    [_channel invokeMethod:@"ADH_fullscreenVideoDidClick" arguments:nil];
}

/**
全屏视频消失
*/
- (void)ADH_fullscreenVideoDidDismissScreen:(AdHubFullscreenVideo *)adHubFullscreenVideo {
    [_channel invokeMethod:@"ADH_fullscreenVideoDidDismissScreen" arguments:nil];
}

/**
全屏视频请求失败
*/
- (void)ADH_fullscreenVideo:(AdHubFullscreenVideo *)adHubFullscreenVideo didFailToLoadAdWithError:(AdHubRequestError *)error {
    [_channel invokeMethod:@"ADH_fullscreenVideo didFailToLoadAdWithError" arguments:@{@"errorCode": @(error.code)}];
}

@end
