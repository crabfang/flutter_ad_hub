//
//  AdHubNative.m
//  widget_ad_hub
//
//  Created by Howie Xu on 2021/2/7.
//

#import "AdHubNative.h"
#import <AdHubSDK/AdHubNativeExpress.h>
#import <AdHubSDK/AdHubSDK.h>
@interface AdHubNative ()<AdHubNativeExpressDelegate>

@property (nonatomic, strong) AdHubNativeExpress *nativePress;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) NSObject<FlutterBinaryMessenger>* messenger;
@property (nonatomic, strong) FlutterMethodChannel* channel;

@end

@implementation AdHubNative
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
    NSString *channelName = [NSString stringWithFormat:@"%@#%lld", @"com.cabe.flutter.widget.AdHubNative", _viewId];
    _channel = [FlutterMethodChannel methodChannelWithName:channelName binaryMessenger:[registrar messenger]];
    [_registrar addMethodCallDelegate:self channel:_channel];
}

- (UIView *)view {
    NSString *adId = _args[@"adId"];
    NSInteger timeout = [_args[@"timeout"] integerValue];
    NSInteger showWidth = [_args[@"showWidth"] integerValue];
    NSInteger showHeight = [_args[@"showHeight"] integerValue];
    if (showWidth < 1) {
        showWidth = 360;
    }
    if (showHeight < 1) {
        showHeight = showWidth;
    }
    // 创建加载原生广告的View
    if (!self.bgView) {
        self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, showWidth, showHeight)];
//        self.bgView.backgroundColor = [UIColor orangeColor];
    }
    self.bgView.frame = (CGRect){0, 0, showWidth, showHeight};
//    [self.view addSubview:self.bgView];
    // 初始化广告位
    if (!self.nativePress) {
        self.nativePress = [[AdHubNativeExpress alloc] initWithSpaceID:adId spaceParam:@"" lifeTime:timeout];
        // 设置当前的VC，用于广告位点击跳转
        UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
        self.nativePress.adhubNativeViewController = window.rootViewController;
        // 设置加载广告的View
        self.nativePress.adhubNativeView = self.bgView;
        self.nativePress.delegate = self;
    }
    // 加载广告的个数，广告分为渠道广告和AdHub自由广告，当请求自由广告时，默认返回1条广告，渠道广告返回设置条数，不要超过5条。ps：设置多条会影响广告的曝光率，广告展示才可以曝光，当请求多条广告，可能有一些广告没有曝光就不在使用了，会影响价格。
    [self.nativePress ADH_loadNativeExpressAd:1 viewSize:CGSizeMake(showWidth, showHeight)];
    return self.bgView;
}

- (void)ADH_nativeExpressDidLoad:(AdHubNativeExpress *)adHubNativeExpress{
    UIView *adView = adHubNativeExpress.channeNativeAdView.firstObject;
    NSInteger showWidth = [_args[@"showWidth"] integerValue];
    NSInteger showHeight = [_args[@"showHeight"] integerValue];
    if (showWidth < 1) {
        showWidth = 360;
    }
    if (showHeight < 1) {
        showHeight = showWidth;
    }
    adView.frame = (CGRect){0, 0, showWidth, showHeight};
    if (self.bgView.subviews.count > 0) {
        [self.bgView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    [self.bgView addSubview:adView];
    [_channel invokeMethod:@"ADH_nativeExpressDidLoad" arguments:nil];
    NSLog(@"arthur：广告加载成功");
}

- (void)ADH_nativeExpressDislikeDidClick:(AdHubNativeExpress *)adHubNativeExpress{
    [_channel invokeMethod:@"ADH_nativeExpressDislikeDidClick" arguments:nil];
    NSLog(@"arthur：广告点击关闭");
}

- (void)ADH_nativeExpress:(AdHubNativeExpress *)adHubNativeExpress didFailToLoadAdWithError:(AdHubRequestError *)error{
    [_channel invokeMethod:@"ADH_nativeExpress didFailToLoadAdWithError" arguments:@{@"errorCode": @(error.code)}];
    NSLog(@"arthur: 广告加载失败：%@", error);
}

- (void)ADH_nativeExpressDidClick:(AdHubNativeExpress *)adHubNativeExpress {
    [_channel invokeMethod:@"ADH_nativeExpressDidClick" arguments:nil];
    NSLog(@"arthur：广告点击");
}

@end
