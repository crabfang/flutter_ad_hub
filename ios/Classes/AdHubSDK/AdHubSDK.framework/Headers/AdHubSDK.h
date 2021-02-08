//
//  AdHubSDK.h
//  Pods
//
//  Created by Cookie on 2019/12/6.
//

#import <UIKit/UIKit.h>

//! Project version number for AdHubSDK.
FOUNDATION_EXPORT double AdHubSDKVersionNumber;

//! Project version string for AdHubSDK.
FOUNDATION_EXPORT const unsigned char AdHubSDKVersionString[];

// 初始化SDK
#import <AdHubSDK/AdHubSDKManager.h>

// 开屏广告
#import <AdHubSDK/AdHubSplash.h>

//原生广告
#import <AdHubSDK/AdHubNativeExpress.h>

//激励视频广告
#import <AdHubSDK/AdHubRewardedVideo.h>

//横幅广告
#import <AdHubSDK/AdHubBannerView.h>

//全屏视频广告
#import <AdHubSDK/AdHubFullscreenVideo.h>

//Draw流广告
#import <AdHubSDK/AdHubDrawFlow.h>

// 错误信息
#import <AdHubSDK/AdHubRequestError.h>
