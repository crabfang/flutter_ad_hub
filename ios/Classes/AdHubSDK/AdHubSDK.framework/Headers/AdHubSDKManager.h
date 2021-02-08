//
//  AdHubSDKManager.h
//  AdHubSDK
//
//  Created by Cookie on 2019/12/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AdHubSDKManager : NSObject

/**
 配置 AppID
 @param applicationID 商户分配到的唯一appID
 */
+ (void)configureWithApplicationID:(NSString *)applicationID;

/**
 开启错误日志
 */
+ (void)openTheAdHubLog;

/**
 SDK版本号
 @return SDK版本号
 */
+ (NSString *)sdkVersion;

@end

NS_ASSUME_NONNULL_END
