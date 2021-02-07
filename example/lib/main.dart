import 'package:flutter/material.dart';
import 'package:widget_ad_hub/plugin_ad_hub.dart';
import 'package:widget_ad_hub/widget_ad_fullscreen_video.dart';
import 'package:widget_ad_hub/widget_ad_hub_banner.dart';
import 'package:widget_ad_hub/widget_ad_hub_native.dart';
import 'package:widget_ad_hub/widget_ad_hub_splash.dart';
import 'package:widget_ad_hub/widget_ad_rewarded_video.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    AdHubPlugin.init("20159", "20160");
  }

  RewardedVideoAd rewardedAd;
  FullscreenVideoAd fullscreenAd;
  @override
  Widget build(BuildContext context) {
    rewardedAd = RewardedVideoAd("103226", "103232");
    fullscreenAd = FullscreenVideoAd("103225", "103231");
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
                    onTap: _actionFullScreenVideo,
                    child: Text("全屏视频"),
                  ),
                  Text("      "),
                  GestureDetector(
                    onTap: _actionRewardedVideo,
                    child: Text("激励视频"),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 600,
                child: AdHubSplash("103222", "103228"),
              ),
              Container(
                width: double.infinity,
                height: 100,
                margin: EdgeInsets.only(top: 10.0),
                child: AdHubBanner("103223", "103229", showWidth: 360),
              ),
              Container(
                width: double.infinity,
                height: 200,
                margin: EdgeInsets.only(top: 10.0),
                child: AdHubNative("103224", "103230", showWidth: 360),
              ),
              Container(
                width: double.infinity,
                height: 100,
                margin: EdgeInsets.only(top: 10.0),
                child: rewardedAd,
              ),
              Container(
                width: double.infinity,
                height: 100,
                margin: EdgeInsets.only(top: 10.0),
                child: fullscreenAd,
              )
            ],
          ),
        ),
      ),
    );
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
