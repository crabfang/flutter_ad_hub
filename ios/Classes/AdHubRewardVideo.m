//
//  AdHubRewardVideo.m
//  widget_ad_hub
//
//  Created by Howie Xu on 2021/2/7.
//

#import "AdHubRewardVideo.h"
#import <AdHubSDK/AdHubSDK.h>

@interface AdHubRewardVideo () <AdHubRewardedVideoDelegate>

@property (nonatomic, strong) AdHubRewardedVideo *rewardedVideo;
@property (nonatomic, strong) NSObject<FlutterBinaryMessenger>* messenger;
@property (nonatomic, strong) FlutterMethodChannel* channel;
@property (nonatomic, strong) FlutterBasicMessageChannel *basicChannel;



@end

@implementation AdHubRewardVideo

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
    NSString *channelName = [NSString stringWithFormat:@"%@#%lld", @"com.cabe.flutter.widget.RewardedVideoAd", _viewId];
    _channel = [FlutterMethodChannel methodChannelWithName:channelName binaryMessenger:[registrar messenger]];
    _basicChannel = [FlutterBasicMessageChannel messageChannelWithName:channelName binaryMessenger:[registrar messenger]];
    [_registrar addMethodCallDelegate:self channel:_channel];
}

- (UIView *)view {
    NSString *adId = _args[@"adId"];
    NSInteger timeout = [_args[@"timeout"] integerValue];
    if (!_rewardedVideo) {
        self.rewardedVideo = [[AdHubRewardedVideo alloc]initWithSpaceID:adId spaceParam:@"" lifeTime:timeout];
        self.rewardedVideo.delegate = self;
    }
    
//    [self.rewardedVideo ADH_loadRewardedVideoAd];
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"loadAd" isEqualToString:call.method]) {
      NSLog(@"ADH_loadAd");
    [self.rewardedVideo ADH_loadRewardedVideoAd];
  }
}

/**
激励视频物料请求成功
*/
- (void)ADH_rewardedVideoDidReceiveAd:(AdHubRewardedVideo *)adHubRewardedVideo {
    NSLog(@"ADH_rewardedVideoDidReceiveAd");
    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
    [self.rewardedVideo ADH_showRewardedVideoAdFromRootViewController:window.rootViewController];
    [_channel invokeMethod:@"ADH_rewardedVideoDidReceiveAd" arguments:nil];
}

/**
激励展现并开始播放视频
*/
- (void)ADH_rewardedVideoDidStartPlay:(AdHubRewardedVideo *)adHubRewardedVideo {
    NSLog(@"---- ADH_rewardedVideoDidStartPlay");
    [_channel invokeMethod:@"ADH_rewardedVideoDidStartPlay" arguments:nil];
}

/**
激励视频点击
*/
- (void)ADH_rewardedVideoDidClick:(AdHubRewardedVideo *)adHubRewardedVideo {
    NSLog(@"---- ADH_rewardedVideoDidClick");
    [_channel invokeMethod:@"ADH_rewardedVideoDidClick" arguments:nil];
}

/**
激励视频消失
*/
- (void)ADH_rewardedVideoDidDismissScreen:(AdHubRewardedVideo *)adHubRewardedVideo {
    NSLog(@"---- ADH_rewardedVideoDidDismissScreen");
    [_channel invokeMethod:@"ADH_rewardedVideoDidDismissScreen" arguments:nil];
}

/**
激励视频请求失败
*/
- (void)ADH_rewardedVideo:(AdHubRewardedVideo *)adHubRewardedVideo didFailToLoadAdWithError:(AdHubRequestError *)error {
    NSLog(@"---- ADH_rewardedVideo didFailToLoadAdWithError");
    [_channel invokeMethod:@"ADH_rewardedVideo didFailToLoadAdWithError" arguments:@{@"errorCode": @(error.code)}];
    
}

/**
激励视频奖励
如果有渠道时，此方法仅限用于给用户发放奖励回调，奖励内容不可用。
@param reward 奖励内容 JSON字符串，自行解析
*/
- (void)ADH_rewardedVideo:(AdHubRewardedVideo *)adHubRewardedVideo didRewardUserWithReward:(NSObject *)reward {
    [_channel invokeMethod:@"ADH_rewardedVideo didRewardUserWithReward" arguments:nil];
}

@end
