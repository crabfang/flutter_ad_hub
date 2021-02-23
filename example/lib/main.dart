import 'package:flutter/material.dart';
import 'package:widget_ad_hub/plugin_ad_hub.dart';
import 'package:widget_ad_hub_example/sample.dart';

void main() {
  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AdHubPlugin.init("20159", "20160");
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
              title: const Text('Plugin example app'),
          ),
          body: new RaisedButton(
            child: new Text('Launch Demo'),
              onPressed: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (context) => new Sample()),
                );
              },
            ),
        ),
    );
  }
}