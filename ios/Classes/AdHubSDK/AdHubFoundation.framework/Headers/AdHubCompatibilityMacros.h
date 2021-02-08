//
//  AdHubCompatibilityMacros.h
//  AdHubFoundation
//
//  Created by 北京市吕俊学 on 2018/11/23.
//  Copyright © 2018年 北京市吕俊学. All rights reserved.
//


#ifndef AdHubCompatibilityMacros_h
#define AdHubCompatibilityMacros_h

#ifdef API_AVAILABLE
    #define AdHub_API_AVAILABLE(...) API_AVAILABLE(__VA_ARGS__)
#else
    #define AdHub_API_AVAILABLE(...)
#endif // API_AVAILABLE

#ifdef API_UNAVAILABLE
    #define AdHub_API_UNAVAILABLE(...) API_UNAVAILABLE(__VA_ARGS__)
#else
    #define AdHub_API_UNAVAILABLE(...)
#endif // API_UNAVAILABLE

#if __has_warning("-Wunguarded-availability-new")
    #define AdHub_CAN_USE_AT_AVAILABLE 1
#else
    #define AdHub_CAN_USE_AT_AVAILABLE 0
#endif

#if ((__IPHONE_OS_VERSION_MAX_ALLOWED && __IPHONE_OS_VERSION_MAX_ALLOWED < 100000) || (__MAC_OS_VERSION_MAX_ALLOWED && __MAC_OS_VERSION_MAX_ALLOWED < 101200) ||(__WATCH_OS_MAX_VERSION_ALLOWED && __WATCH_OS_MAX_VERSION_ALLOWED < 30000) ||(__TV_OS_MAX_VERSION_ALLOWED && __TV_OS_MAX_VERSION_ALLOWED < 100000))
    #define AdHub_CAN_INCLUDE_SESSION_TASK_METRICS 0
#else
    #define AdHub_CAN_INCLUDE_SESSION_TASK_METRICS 1
#endif

#endif /* AdHubCompatibilityMacros_h */

