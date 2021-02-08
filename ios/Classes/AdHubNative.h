//
//  AdHubNative.h
//  widget_ad_hub
//
//  Created by Howie Xu on 2021/2/7.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface AdHubNative : NSObject <FlutterPlatformView, FlutterPlugin>

@property (nonatomic, strong) NSObject<FlutterPluginRegistrar>* registrar;
- (instancetype)initWithWithFrame:(CGRect)frame
                   viewIdentifier:(int64_t)viewId
                        arguments:(id _Nullable)args
                  binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger;

@end

NS_ASSUME_NONNULL_END
