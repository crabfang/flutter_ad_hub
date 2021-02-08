//
//  AdHubNetworkReachabilityManager.h
//  AdHubFoundation
//
//  Created by 北京市吕俊学 on 2018/11/23.
//  Copyright © 2018年 北京市吕俊学. All rights reserved.
//


#import <Foundation/Foundation.h>

#if !TARGET_OS_WATCH
#import <SystemConfiguration/SystemConfiguration.h>

typedef NS_ENUM(NSInteger, AdHubNetworkReachabilityStatus) {
    AdHubNetworkReachabilityStatusUnknown          = -1,
    AdHubNetworkReachabilityStatusNotReachable     = 0,
    AdHubNetworkReachabilityStatusReachableViaWWAN = 1,
    AdHubNetworkReachabilityStatusReachableViaWiFi = 2,
};

NS_ASSUME_NONNULL_BEGIN

@interface AdHubNetworkReachabilityManager : NSObject

@property (readonly, nonatomic, assign) AdHubNetworkReachabilityStatus networkReachabilityStatus;

@property (readonly, nonatomic, assign, getter = isReachable) BOOL reachable;

@property (readonly, nonatomic, assign, getter = isReachableViaWWAN) BOOL reachableViaWWAN;

@property (readonly, nonatomic, assign, getter = isReachableViaWiFi) BOOL reachableViaWiFi;

+ (instancetype)sharedManager;

+ (instancetype)manager;

+ (instancetype)managerForDomain:(NSString *)domain;

+ (instancetype)managerForAddress:(const void *)address;

- (instancetype)initWithReachability:(SCNetworkReachabilityRef)reachability NS_DESIGNATED_INITIALIZER;

+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)init NS_UNAVAILABLE;

- (void)startMonitoring;

- (void)stopMonitoring;

- (NSString *)localizedNetworkReachabilityStatusString;

- (void)setReachabilityStatusChangeBlock:(nullable void (^)(AdHubNetworkReachabilityStatus status))block;

@end

FOUNDATION_EXPORT NSString * const AdHubNetworkingReachabilityDidChangeNotification;
FOUNDATION_EXPORT NSString * const AdHubNetworkingReachabilityNotificationStatusItem;

FOUNDATION_EXPORT NSString * AdHubStringFromNetworkReachabilityStatus(AdHubNetworkReachabilityStatus status);

NS_ASSUME_NONNULL_END
#endif

