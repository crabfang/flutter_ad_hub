//
//  AdHubRequestError.h
//  AdHubSDK
//
//  Created by Cookie on 2019/12/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// AdHubSDK Ads error domain.
extern NSString *const kAdHubErrorDomain;

// NSError codes for AdHub error domain.
typedef NS_ENUM(NSInteger, AdHubErrorCode) {
    kAdHubErrorTimeout                              = 9999,
    
    // 未知错误
    kAdHubErrorUnknow                               = 1,
    
    // 配置文件错误
    kAdHubErrorConfigureError                       = 10001,
    
    // 未发现此广告位
    kAdHubErrorSpaceIDNULL                          = 10100,
    
    // 广告类型不匹配
    kAdHubErrorIDUseError                           = 10110,
    
    // 广告请求时间过短
    kAdHubErrorRequestTimeLess                      = 10120,
    
    // 内部错误
    kAdHubErrorFilterError                          = 10130,
    
    // 内部错误
    kAdHubErrorStatusError                          = 10131,
    
    // 内部错误
    kAdHubErrorInternalError                        = 10132,
    
    // 广告没有填充
    kAdHubErrorNoFill                               = 10140,
    
    // 没有广告位信息
    kAdHubErrorNoBuyerInfo                          = 10150,
    
    // 渠道未知错误
    kAdHubErrorChannelUnknow                        = 10160,
    
    // 广告load失败
    kAdHubErrorLoadAdError                          = 10200,
    
    // 广告类型不匹配
    kAdHubErrorMapIDError                           = 10220,
    
};

@interface AdHubRequestError : NSError

+ (AdHubRequestError *)errorWithCode:(AdHubErrorCode)code;

@end

NS_ASSUME_NONNULL_END
