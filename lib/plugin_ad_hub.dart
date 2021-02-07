import 'package:flutter/services.dart';

class AdHubPlugin {
  static const MethodChannel _channel = const MethodChannel('AdHubPlugin');

  static Future<int> init(String appIdAndroid, String appIdIOS) async {
    Map<String, Object> params = {
      "appIdOfAndroid": appIdAndroid,
      "appIdOfIOS": appIdIOS
    };
    return await _channel.invokeMethod("init", params);
  }
}