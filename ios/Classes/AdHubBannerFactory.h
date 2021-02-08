//
//  AdHubBannerFactory.h
//  widget_ad_hub
//
//  Created by Howie Xu on 2021/2/7.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface AdHubBannerFactory : NSObject<FlutterPlatformViewFactory>

@property (nonatomic, strong) NSObject<FlutterPluginRegistrar>* registrar;
- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger>*)messager;

@end

NS_ASSUME_NONNULL_END
