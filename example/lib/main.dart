import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:widget_ad_hub/widget_ad_hub.dart';

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
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            GestureDetector(
              onTap: _onTap,
              child: Text("row title"),
            ),
            Container(
              height: 60,
              child: AdHubBanner(onBannerCreated: _onBannerViewCreated),
            )
          ],
        ),
      ),
    );
  }

  MethodChannel bannerChannel;
  int _clickCount = 0;
  void _onBannerViewCreated(MethodChannel bannerChannel) {
    this.bannerChannel = bannerChannel;
    print("_onBannerViewCreated");
  }
  
  void _onTap() {
    print("_onTap: $_clickCount");
    if(bannerChannel != null) {
      int period = 4;
      if(_clickCount % period == 0) {
        _setText();
      } else if(_clickCount % period == 1) {
        _setTextColor();
      } else if(_clickCount % period == 2) {
        _setTextSize();
      } else if(_clickCount % period == 3) {
        _setBackground();
      }
    }
    _clickCount ++;
  }
  
  void _setText() {
    bannerChannel.invokeMethod("setText", "flutter widget").then((value) => {
      print("text str: $value")
    });
  }

  void _setTextColor() {
    bannerChannel.invokeMethod("setTextColor", "#FF0000").then((value) => {
      print("text color: $value")
    });
  }

  void _setTextSize() {
    bannerChannel.invokeMethod("setTextSize", 40).then((value) => {
      print("text size: $value")
    });
  }

  void _setBackground() {
    bannerChannel.invokeMethod("setBackground", "#00FF00").then((value) => {
      print("background: $value")
    });
  }
}
