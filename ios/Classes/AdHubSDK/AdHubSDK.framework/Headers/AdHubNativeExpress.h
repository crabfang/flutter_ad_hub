//
//  AdHubNativeExpress.h
//  AdHubSDK
//
//  Created by Arthur on 2020/6/9.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AdHubNativeExpressDelegate;
@class AdHubNativeAdDataModel;
@class AdHubRequestError;

@interface AdHubNativeExpress : NSObject

@property (nonatomic, copy, readonly) NSString *spaceID;
@property (nonatomic, copy, readonly) NSString *spaceParam;

/**
 用来接收原生广告获取状态变化通知的 delegate
 */
@property (nonatomic, weak) id<AdHubNativeExpressDelegate> delegate;

/**
 显示adhub广告的View，此参数不能为空
 */
@property (nonatomic, weak) UIView *adhubNativeView;

/**
 adhubNativeViewController 展示view的控制器或者弹出落地页的需要的控制器，此参数不能为空
 */
@property (nonatomic, weak) UIViewController *adhubNativeViewController;


/**
 初始化方法
 @param spaceID 广告位 ID
 @param spaceParam 广告位参数 可填写任意字符串
 @return 原生广告对象
 */
- (instancetype)initWithSpaceID:(NSString *)spaceID
                     spaceParam:(NSString *)spaceParam
                       lifeTime:(uint64_t)lifeTime NS_DESIGNATED_INITIALIZER;


/**
 广告加载成功后获得的 View广告（数组内部为加载完成的View形式广告，直接add到目标View）
 */
@property (nonatomic, strong, readonly) NSArray *channeNativeAdView;

/**
 Native 获取
 @param count 广告条数（渠道广告时候生效，adhub广告只能拉取1条广告）
 @param viewSize 原生广告展示的size
 */
- (void)ADH_loadNativeExpressAd:(int)count viewSize:(CGSize)viewSize;

@end

/**
 代理方法
 */
@protocol AdHubNativeExpressDelegate <NSObject>

@optional

/**
 原生模板广告请求成功
 */
- (void)ADH_nativeExpressDidLoad:(AdHubNativeExpress *)adHubNativeExpress;

/**
 原生模板广告点击
 */
- (void)ADH_nativeExpressDidClick:(AdHubNativeExpress *)adHubNativeExpress;

/**
 原生模板广告点击关闭
 */
- (void)ADH_nativeExpressDislikeDidClick:(AdHubNativeExpress *)adHubNativeExpress;

/**
 原生模板广告请求失败
 */
- (void)ADH_nativeExpress:(AdHubNativeExpress *)adHubNativeExpress didFailToLoadAdWithError:(AdHubRequestError *)error;


@end

NS_ASSUME_NONNULL_END
