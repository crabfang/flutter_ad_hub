import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:widget_ad_hub/plugin_ad_hub.dart';
import 'package:widget_ad_hub/widget_ad_hub_banner.dart';
import 'package:widget_ad_hub/widget_ad_hub_splash.dart';

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
        body: Column(
          children: [
            GestureDetector(
              onTap: _onTap,
              child: Text("row title"),
            ),
            // Container(
            //   width: double.infinity,
            //   height: 500,
            //   child: AdHubSplash("103222",onCreated: _onSplashCreated),
            // ),
            Container(
              width: double.infinity,
              height: 100,
              margin: EdgeInsets.only(top: 10.0),
              child: AdHubBanner("103223",onCreated: _onSplashCreated, bannerWidth: 400,),
            )
          ],
        ),
      ),
    );
  }

  MethodChannel bannerChannel;
  int _clickCount = 0;
  void _onSplashCreated(MethodChannel bannerChannel) {
    this.bannerChannel = bannerChannel;
    print("_onSplashCreated");
  }
  
  void _onTap() {
    print("_onTap: $_clickCount");
    if(_clickCount == 0) {
      AdHubPlugin.init("20159");
    }
    _clickCount ++;
  }
}
