//
//  AdHubURLResponseSerialization.h
//  AdHubFoundation
//
//  Created by 北京市吕俊学 on 2018/11/23.
//  Copyright © 2018年 北京市吕俊学. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT id AdHubJSONObjectByRemovingKeysWithNullValues(id JSONObject, NSJSONReadingOptions readingOptions);

@protocol AdHubURLResponseSerialization <NSObject, NSSecureCoding, NSCopying>

- (nullable id)responseObjectForResponse:(nullable NSURLResponse *)response
                           data:(nullable NSData *)data
                          error:(NSError * _Nullable __autoreleasing *)error NS_SWIFT_NOTHROW;

@end

#pragma mark -

@interface AdHubHTTPResponseSerializer : NSObject <AdHubURLResponseSerialization>

- (instancetype)init;

+ (instancetype)serializer;

@property (nonatomic, copy, nullable) NSIndexSet *acceptableStatusCodes;

@property (nonatomic, copy, nullable) NSSet <NSString *> *acceptableContentTypes;

- (BOOL)validateResponse:(nullable NSHTTPURLResponse *)response
                    data:(nullable NSData *)data
                   error:(NSError * _Nullable __autoreleasing *)error;

@end

#pragma mark -

@interface AdHubJSONResponseSerializer : AdHubHTTPResponseSerializer

- (instancetype)init;

@property (nonatomic, assign) NSJSONReadingOptions readingOptions;

@property (nonatomic, assign) BOOL removesKeysWithNullValues;

+ (instancetype)serializerWithReadingOptions:(NSJSONReadingOptions)readingOptions;

@end

#pragma mark -

@interface AdHubXMLParserResponseSerializer : AdHubHTTPResponseSerializer

@end

#pragma mark -

#ifdef __MAC_OS_X_VERSION_MIN_REQUIRED

@interface AdHubXMLDocumentResponseSerializer : AdHubHTTPResponseSerializer

- (instancetype)init;

@property (nonatomic, assign) NSUInteger options;

+ (instancetype)serializerWithXMLDocumentOptions:(NSUInteger)mask;

@end

#endif

#pragma mark -

@interface AdHubPropertyListResponseSerializer : AdHubHTTPResponseSerializer

- (instancetype)init;

@property (nonatomic, assign) NSPropertyListFormat format;

@property (nonatomic, assign) NSPropertyListReadOptions readOptions;

+ (instancetype)serializerWithFormat:(NSPropertyListFormat)format
                         readOptions:(NSPropertyListReadOptions)readOptions;

@end

#pragma mark -

@interface AdHubImageResponseSerializer : AdHubHTTPResponseSerializer

#if TARGET_OS_IOS || TARGET_OS_TV || TARGET_OS_WATCH

@property (nonatomic, assign) CGFloat imageScale;

@property (nonatomic, assign) BOOL automaticallyInflatesResponseImage;
#endif

@end

#pragma mark -

@interface AdHubCompoundResponseSerializer : AdHubHTTPResponseSerializer

@property (readonly, nonatomic, copy) NSArray <id<AdHubURLResponseSerialization>> *responseSerializers;

+ (instancetype)compoundSerializerWithResponseSerializers:(NSArray <id<AdHubURLResponseSerialization>> *)responseSerializers;

@end

FOUNDATION_EXPORT NSString * const AdHubURLResponseSerializationErrorDomain;

FOUNDATION_EXPORT NSString * const AdHubNetworkingOperationFailingURLResponseErrorKey;

FOUNDATION_EXPORT NSString * const AdHubNetworkingOperationFailingURLResponseDataErrorKey;

NS_ASSUME_NONNULL_END


