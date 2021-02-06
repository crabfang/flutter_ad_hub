import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:widget_ad_hub/plugin_ad_hub.dart';
import 'package:widget_ad_hub/widget_ad_hub_banner.dart';
import 'package:widget_ad_hub/widget_ad_hub_native.dart';
import 'package:widget_ad_hub/widget_ad_hub_splash.dart';
import 'package:widget_ad_hub/widget_ad_fullscreen_video.dart';
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
    AdHubPlugin.init("20159").then((value) => {

    });
  }

  @override
  Widget build(BuildContext context) {
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
                child: AdHubSplash("103222",onCreated: _onViewCreated),
              ),
              Container(
                width: double.infinity,
                height: 100,
                margin: EdgeInsets.only(top: 10.0),
                child: AdHubBanner("103223", onCreated: _onViewCreated, showWidth: 360,),
              ),
              Container(
                width: double.infinity,
                height: 200,
                margin: EdgeInsets.only(top: 10.0),
                child: AdHubNative("103224",onCreated: _onViewCreated, showWidth: 360),
              ),
              Container(
                width: double.infinity,
                height: 100,
                margin: EdgeInsets.only(top: 10.0),
                child: RewardedVideoAd("103226",onCreated: _onRewardedCreated,),
              ),
              Container(
                width: double.infinity,
                height: 100,
                margin: EdgeInsets.only(top: 10.0),
                child: FullscreenVideoAd("103225",onCreated: _onFullscreenCreated,),
              )
            ],
          ),
        ),
      ),
    );
  }

  MethodChannel _fullscreenChannel;
  MethodChannel _rewardedChannel;
  void _onViewCreated(MethodChannel channel) {
    print("_onViewCreated: " + channel.toString());
  }
  void _onFullscreenCreated(MethodChannel channel) {
    print("_onFullscreenCreated");
    this._fullscreenChannel = channel;
  }
  void _onRewardedCreated(MethodChannel channel) {
    print("_onRewardedCreated");
    this._rewardedChannel = channel;
  }
  
  void _actionFullScreenVideo() {
    print("_actionFullScreenVideo");
    if(_fullscreenChannel != null) _fullscreenChannel.invokeMethod("loadAd");
  }
  void _actionRewardedVideo() {
    print("_actionRewardedVideo");
    if(_rewardedChannel != null) _rewardedChannel.invokeMethod("loadAd");
  }
}
