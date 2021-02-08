
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

typedef OnViewCreated = void Function(MethodChannel channel);
// ignore: must_be_immutable
abstract class AdHubWidget extends StatefulWidget {
  String tag = "AdHubWidget";
  String adIdOfAndroid;
  String adIdOfIOS;
  MethodChannel channel;
  AdHubState onGetAdHubState(OnViewCreated onViewCreated);

  AdHubWidget(String adIdOfAndroid, String adIdOfIOS) {
    this.tag = runtimeType.toString();
    this.adIdOfAndroid = adIdOfAndroid;
    this.adIdOfIOS = adIdOfIOS;
  }

  @override
  State<StatefulWidget> createState() {
    return onGetAdHubState((MethodChannel channel) {
      this.channel = channel;
      channel.setMethodCallHandler(onHandlerChannel);
    });
  }

  Future<dynamic> onHandlerChannel(MethodCall call) async {
    print("$tag: onHandlerChannel: ${call.method}: ${call.arguments}");
  }
}

abstract class AdHubState<T extends AdHubWidget> extends State<T> with AutomaticKeepAliveClientMixin {
  String tag = "AdHubState";
  String adIdOfAndroid;
  String adIdOfIOS;

  @override bool get wantKeepAlive => true;
  OnViewCreated _onCreated;
  String onGetViewType();
  int onGetTimeout() => 5000;
  dynamic creationParams(String adId) => {
    "adId": adId,
    "timeout": onGetTimeout(),
  };
  AndroidView onCreateAndroidView() => AndroidView(
    viewType: onGetViewType(),
    creationParams: creationParams(adIdOfAndroid),
    creationParamsCodec: const StandardMessageCodec(),
    onPlatformViewCreated: this._onViewCreated,
  );
  UiKitView onCreateUiKitView() => UiKitView(
    viewType: onGetViewType(),
    creationParams: creationParams(adIdOfIOS),
    creationParamsCodec: const StandardMessageCodec(),
    onPlatformViewCreated: this._onViewCreated,
  );

  AdHubState(String adIdOfAndroid, String adIdOfIOS, OnViewCreated onCreated) {
    this.tag = runtimeType.toString();
    this.adIdOfAndroid = adIdOfAndroid;
    this.adIdOfIOS = adIdOfIOS;
    this._onCreated = onCreated;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    // 这里使用 AndroidView，告知 Flutter 这是个原生控件，控件的类型是 VIEW_TYPE。
    if(defaultTargetPlatform == TargetPlatform.android) {
      return onCreateAndroidView();
    } else if(defaultTargetPlatform == TargetPlatform.iOS) {
      return onCreateUiKitView();
    } else return null;
  }

  void _onViewCreated(int id) {
    print("$tag _onViewCreated: $id");
    MethodChannel channel = MethodChannel("${onGetViewType()}#$id");
    this._onCreated(channel);
  }
}