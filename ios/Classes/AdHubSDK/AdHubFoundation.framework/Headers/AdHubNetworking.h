//
//  AdHubNetworking.h
//  AdHubFoundation
//
//  Created by 北京市吕俊学 on 2018/11/23.
//  Copyright © 2018年 北京市吕俊学. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Availability.h>
#import <TargetConditionals.h>

#ifndef _AdHubNETWORKING_
    #define _AdHubNETWORKING_

    #import "AdHubURLRequestSerialization.h"
    #import "AdHubURLResponseSerialization.h"
    #import "AdHubSecurityPolicy.h"

#if !TARGET_OS_WATCH
    #import "AdHubNetworkReachabilityManager.h"
#endif

    #import "AdHubURLSessionManager.h"
    #import "AdHubHTTPSessionManager.h"

#endif /* _AdHubNETWORKING_ */

