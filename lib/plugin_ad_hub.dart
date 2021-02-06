import 'package:flutter/services.dart';

class AdHubPlugin {
  static const MethodChannel _channel = const MethodChannel('AdHubPlugin');

  static Future<bool> init(String appId) async {
    Map<String, Object> params = {"appId": appId};
    return await _channel.invokeMethod("init", params);
  }
}