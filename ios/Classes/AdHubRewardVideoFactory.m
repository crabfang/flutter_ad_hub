//
//  AdHubRewardVideoFactory.m
//  widget_ad_hub
//
//  Created by Howie Xu on 2021/2/7.
//

#import "AdHubRewardVideoFactory.h"
#import "AdHubRewardVideo.h"

@implementation AdHubRewardVideoFactory {
    NSObject<FlutterBinaryMessenger>*_messenger;
}

- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger> *)messager{
    self = [super init];
    if (self) {
        _messenger = messager;
    }
    return self;
}

-(NSObject<FlutterMessageCodec> *)createArgsCodec{
    return [FlutterStandardMessageCodec sharedInstance];
}

- (NSObject <FlutterPlatformView> *)createWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id _Nullable)args {
    AdHubRewardVideo *view = [[AdHubRewardVideo alloc] initWithWithFrame:frame viewIdentifier:viewId arguments:args binaryMessenger:_messenger];
    view.registrar = _registrar;
    return view;
}

@end
