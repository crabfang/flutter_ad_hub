//
//  AdHubDrawFlowManager.h
//  AdHubSDK
//
//  Created by Arthur on 2020/12/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AdHubDrawFlowDelegate;
@class AdHubRequestError;
@class AdHubDrawFlowView;

@interface AdHubDrawFlow : NSObject

@property (nonatomic, copy, readonly) NSString *spaceID;
@property (nonatomic, copy, readonly) NSString *spaceParam;

/**
 用来接收开屏广告读取和展示状态变化通知的 delegate
 */
@property (nonatomic, weak) id<AdHubDrawFlowDelegate> delegate;

/**
 广告加载成功后获得的 View广告
 */
@property (nonatomic, strong, readonly) NSArray *channeNativeAdView;


/**
 初始化方法
 @param spaceID 广告位 ID
 @param spaceParam 广告位参数 可填写任意字符串
 @param lifeTime 给予广告请求时间
 @return 开屏广告对象
 */
- (instancetype)initWithSpaceID:(NSString *)spaceID
                     spaceParam:(NSString *)spaceParam
                       lifeTime:(uint64_t)lifeTime NS_DESIGNATED_INITIALIZER;

/**
 请求加载DrawFlow，需要用此方法load
 */
- (void)ADH_loadDrawFlowAd;


@end

/**
 代理方法
 */
@protocol AdHubDrawFlowDelegate <NSObject>

@optional
/**
 DrawFlow模板广告请求成功
 */
- (void)ADH_drawFlowManagerDidLoadSuccess:(AdHubDrawFlow *)adHubDrawFlowManager;

/**
 DrawFlow模板广告请求失败
 */
- (void)ADH_drawFlowManager:(AdHubDrawFlow *)adHubDrawFlowManager didFailToLoadAdWithError:(AdHubRequestError *)error;



/**
 DrawFlow模板广告图层即将显示
 */
- (void)ADH_drawAdViewWillShow;

/**
 DrawFlow模板广告图层视频播放失败
 */
- (void)ADH_drawAdViewVideoDidFailedWithError:(NSError *)error;




/**
 DrawFlow模板广告图层视频开始播放
 */
- (void)ADH_drawAdViewVideoDidStart;


/**
 DrawFlow模板广告图层被点击
 */
- (void)ADH_drawAdViewDidClick;

/**
 DrawFlow模板广告图层展示广告详情页
 */
- (void)ADH_drawAdViewDidShowOtherController;

/**
 DrawFlow模板广告图层关闭广告详情页
 */
- (void)ADH_drawAdViewDidCloseOtherController;

/**
 DrawFlow模板广告用户点击不喜欢
 */
- (void)ADH_drawAdViewDislikeDidClick;

@end

@interface AdHubDrawFlowView : NSObject

@end


NS_ASSUME_NONNULL_END
