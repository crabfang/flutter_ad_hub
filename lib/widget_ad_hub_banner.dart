import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:widget_ad_hub/widget_base.dart';

// ignore: must_be_immutable
class AdHubBanner extends AdHubWidget {
  double showWidth;
  double showHeight;

  AdHubBanner(String adIdOfAndroid, String adIdOfIOS, {Key key, this.showWidth, this.showHeight}) : super(adIdOfAndroid, adIdOfIOS);

  @override
  AdHubState<AdHubWidget> onGetAdHubState(onViewCreated) {
    return _BannerState(this.adIdOfAndroid, this.adIdOfIOS, onViewCreated, this.showWidth, this.showHeight);
  }
}

class _BannerState extends AdHubState<AdHubBanner> {
  double _showWidth;
  double _showHeight;

  @override String onGetViewType() => "com.cabe.flutter.widget.AdHubBanner";
  @override
  dynamic creationParams() {
    Map<String, Object> params = {
      "showWidth": _showWidth?.toInt(),
      "showHeight": _showHeight?.toInt(),
    };
    params.addAll(super.creationParams());
    return params;
  }

  _BannerState(String adIdOfAndroid, String adIdOfIOS, OnViewCreated onCreated, double showWidth, double showHeight) : super(adIdOfAndroid, adIdOfIOS, onCreated) {
    this._showWidth = showWidth;
    this._showHeight = showHeight;
  }
}