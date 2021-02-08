import 'package:flutter/widgets.dart';
import 'package:widget_ad_hub/widget_base.dart';

// ignore: must_be_immutable
class AdHubSplash extends AdHubWidget {
  String bottomPic = "";
  AdHubSplash(String adIdOfAndroid, String adIdOfIOS, { Key key, this.bottomPic}) : super(adIdOfAndroid, adIdOfIOS);

  @override
  AdHubState<AdHubWidget> onGetAdHubState(onViewCreated) {
    return _SplashState(this.adIdOfAndroid, this.adIdOfIOS, onViewCreated, bottomPic);
  }
}

class _SplashState extends AdHubState<AdHubSplash> {
  String _bottomPic = "";
  @override String onGetViewType() => "com.cabe.flutter.widget.AdHubSplash";

  _SplashState(String adIdOfAndroid, String adIdOfIOS, OnViewCreated onCreated, String bottomPic) : super(adIdOfAndroid, adIdOfIOS, onCreated) {
    this._bottomPic = bottomPic;
  }

  @override
  dynamic creationParams(String adId) {
    Map<String, Object> params = {
      "bottomPic": _bottomPic,
    };
    params.addAll(super.creationParams(adId));
    return params;
  }
}