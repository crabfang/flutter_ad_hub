
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:widget_ad_hub/widget_ad_fullscreen_video.dart';
import 'package:widget_ad_hub/widget_ad_hub_banner.dart';
import 'package:widget_ad_hub/widget_ad_hub_native.dart';
import 'package:widget_ad_hub/widget_ad_hub_splash.dart';
import 'package:widget_ad_hub/widget_ad_rewarded_video.dart';

class Sample extends StatefulWidget {
  @override
  _SampleState createState() => _SampleState();
}

class _SampleState extends State<Sample> {
  @override
  void initState() {
    super.initState();
  }

  AdHubSplash splash;
  AdHubBanner banner;
  RewardedVideoAd rewardedAd;
  FullscreenVideoAd fullscreenAd;
  @override
  Widget build(BuildContext context) {
    final physicalWidth = window.physicalSize.width;
    final dpr = window.devicePixelRatio;
    final screenWidth = physicalWidth / dpr;
    final bannerHeight = screenWidth / 6.4;
    final nativeHeight = 220.0;

    splash = AdHubSplash("103222", "103228", bottomPic: "splash_bottom",);
    splash.setChannelHandle(onHandleSplash);
    banner = AdHubBanner("103223", "103229", showWidth: screenWidth);
    rewardedAd = RewardedVideoAd("103226", "103232");
    fullscreenAd = FullscreenVideoAd("103225", "103231");
    int splashHeight = 10;
    if(defaultTargetPlatform == TargetPlatform.android) splashHeight = 600;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: _actionBannerRefresh,
                    child: Container(
                      width: 100,
                      height: 30,
                      child: Text("刷新banner"),
                    ),
                  ),
                  Text("      "),
                  GestureDetector(
                    onTap: _actionFullScreenVideo,
                    child: Container(
                      width: 100,
                      height: 30,
                      child: Text("全屏视频"),
                    ),
                  ),
                  Text("      "),
                  GestureDetector(
                    onTap: _actionRewardedVideo,
                    child: Container(
                      width: 100,
                      height: 30,
                      child: Text("激励视频"),
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: splashHeight.toDouble(),
                child: splash,
              ),
              Container(
                width: screenWidth,
                height: bannerHeight,
                margin: EdgeInsets.only(top: 10.0),
                child: banner,
              ),
              Container(
                width: screenWidth,
                height: nativeHeight,
                margin: EdgeInsets.only(top: 10.0),
                child: AdHubNative("103224", "103230", showWidth: screenWidth, showHeight: nativeHeight, ),
              ),
              Container(
                width: double.infinity,
                height: 1,
                child: rewardedAd,
              ),
              Container(
                width: double.infinity,
                height: 1,
                child: fullscreenAd,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> onHandleSplash(MethodCall call) async {
    print("onHandleSplash: ${call.method}: ${call.arguments}");
  }

  void _actionBannerRefresh() {
    print("_actionBannerRefresh");
    banner?.refresh();
  }

  void _actionFullScreenVideo() {
    print("_actionFullScreenVideo");
    fullscreenAd?.loadAD();
  }
  void _actionRewardedVideo() {
    print("_actionRewardedVideo");
    rewardedAd?.loadAD();
  }
}
