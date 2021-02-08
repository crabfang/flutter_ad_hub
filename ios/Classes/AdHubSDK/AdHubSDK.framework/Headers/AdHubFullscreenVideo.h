//
//  AdHubFullscreenVideo.h
//  AdHubSDK
//
//  Created by Cookie on 2020/8/11.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AdHubFullscreenVideoDelegate;
@class AdHubRequestError;

@interface AdHubFullscreenVideo : NSObject

@property (nonatomic, copy, readonly) NSString *spaceID;
@property (nonatomic, copy, readonly) NSString *spaceParam;

/**
 广告是否加载完成。
*/
@property (nonatomic, readonly) BOOL adValid;

/**
 用来接收激励视频广告读取和展示状态变化通知的 delegate
 */
@property (nonatomic, weak) id<AdHubFullscreenVideoDelegate> delegate;

/**
 初始化方法
 @param spaceID 广告位 ID
 @param spaceParam 广告位参数 可填写任意字符串
 @param lifeTime 超时时长，单位毫秒
 @return 全屏视频广告对象
 */
- (instancetype)initWithSpaceID:(NSString *)spaceID
                     spaceParam:(NSString *)spaceParam
                       lifeTime:(uint64_t)lifeTime NS_DESIGNATED_INITIALIZER;

/**
 请求加载全屏视频广告
 */
- (void)ADH_loadFullscreenVideoAd;

/**
 全屏视频展示，确保广告加载成功后调用
 rootViewController 展示view的控制器或者弹出落地页的需要的控制器，此参数不能为空
 */
- (void)ADH_showFullscreenVideoAdFromRootViewController:(UIViewController *)rootViewController;

@end

/**
 代理方法
 */
@protocol AdHubFullscreenVideoDelegate <NSObject>

@optional

/**
 全屏视频物料请求成功
 */
- (void)ADH_fullscreenVideoDidReceiveAd:(AdHubFullscreenVideo *)adHubFullscreenVideo;

/**
 全屏展现并开始播放视频
 */
- (void)ADH_fullscreenVideoDidStartPlay:(AdHubFullscreenVideo *)adHubFullscreenVideo;

/**
 全屏视频点击
 */
- (void)ADH_fullscreenVideoDidClick:(AdHubFullscreenVideo *)adHubFullscreenVideo;

/**
 全屏视频消失
 */
- (void)ADH_fullscreenVideoDidDismissScreen:(AdHubFullscreenVideo *)adHubFullscreenVideo;

/**
 全屏视频请求失败
 */
- (void)ADH_fullscreenVideo:(AdHubFullscreenVideo *)adHubFullscreenVideo
 didFailToLoadAdWithError:(AdHubRequestError *)error;

@end

NS_ASSUME_NONNULL_END
