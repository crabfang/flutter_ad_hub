//
//  AdHubSplash.h
//  AdHubSDK
//
//  Created by Cookie on 2019/12/11.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AdHubSplashDelegate;
@class AdHubRequestError;

@interface AdHubSplash : NSObject

@property (nonatomic, copy, readonly) NSString *spaceID;
@property (nonatomic, copy, readonly) NSString *spaceParam;

/**
 用来接收开屏广告读取和展示状态变化通知的 delegate
 */
@property (nonatomic, weak) id<AdHubSplashDelegate> delegate;

/**
 showLaunchImage 是否展示启动图片到广告显示。
 ps：广告异步加载，会先进入主页，广告加载完成后在弹出，此属性可控制是否进入先进入主页。默认开启。
 请在load广告前设置是否需要。
 */
@property (nonatomic, assign) BOOL showLaunchImage;

/**
 launchImage 展示的启动图片到广告显示。
 */
@property (nonatomic, assign) UIImage *launchImage;

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
 请求加载开屏广告并控制是否要不显示，需要用此方法load
 */
- (void)ADH_loadAndDisplaySplashAd;
/**
 使用ADH_loadAndDisplaySplashAd加载的开屏，不在显示。
 */
- (void)ADH_removeSplashAd;

/**
 获取启动图片，特殊需求时获取
 @return 启动Image
 */
+ (UIImage *)ADH_launchImage;

@end

/**
 代理方法
 */
@protocol AdHubSplashDelegate <NSObject>

@optional

/**
 @return 展示下部logo位置，需要给传入view设置尺寸。
 */
- (UIView *)ADH_splashBottomView;

/**
 开屏展现
 */
- (void)ADH_splashDidPresentScreen:(AdHubSplash *)adHubSplash;

/**
 开屏点击
 */
- (void)ADH_splashDidClick:(AdHubSplash *)adHubSplash;

/**
 开屏消失
 */
- (void)ADH_splashDidDismissScreen:(AdHubSplash *)adHubSplash;

/**
 开屏请求失败
 */
- (void)ADH_splash:(AdHubSplash *)adHubSplash didFailToLoadAdWithError:(AdHubRequestError *)error;

/**
 开屏剩余时间，自定义跳过按钮时候有回调
*/
- (void)ADH_splashAdLifeTime:(int)lifeTime;

@end

NS_ASSUME_NONNULL_END
