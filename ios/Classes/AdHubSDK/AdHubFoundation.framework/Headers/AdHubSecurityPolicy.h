//
//  AdHubSecurityPolicy.h
//  AdHubFoundation
//
//  Created by 北京市吕俊学 on 2018/11/23.
//  Copyright © 2018年 北京市吕俊学. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

typedef NS_ENUM(NSUInteger, AdHubSSLPinningMode) {
    AdHubSSLPinningModeNone,
    AdHubSSLPinningModePublicKey,
    AdHubSSLPinningModeCertificate,
};

NS_ASSUME_NONNULL_BEGIN

@interface AdHubSecurityPolicy : NSObject <NSSecureCoding, NSCopying>

@property (readonly, nonatomic, assign) AdHubSSLPinningMode SSLPinningMode;

@property (nonatomic, strong, nullable) NSSet <NSData *> *pinnedCertificates;

@property (nonatomic, assign) BOOL allowInvalidCertificates;

@property (nonatomic, assign) BOOL validatesDomainName;

+ (NSSet <NSData *> *)certificatesInBundle:(NSBundle *)bundle;

+ (instancetype)defaultPolicy;

+ (instancetype)policyWithPinningMode:(AdHubSSLPinningMode)pinningMode;

+ (instancetype)policyWithPinningMode:(AdHubSSLPinningMode)pinningMode withPinnedCertificates:(NSSet <NSData *> *)pinnedCertificates;

- (BOOL)evaluateServerTrust:(SecTrustRef)serverTrust
                  forDomain:(nullable NSString *)domain;

@end

NS_ASSUME_NONNULL_END



