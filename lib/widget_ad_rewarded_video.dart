import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:widget_ad_hub/widget_ad_hub_banner.dart';

// ignore: must_be_immutable
class RewardedVideoAd extends StatefulWidget {
  String adId;
  OnViewCreated onCreated;
  _RewardedVideoAdState _state;

  RewardedVideoAd(String adId, {Key key, this.onCreated}) {
    this.adId = adId;
  }

  @override
  State<StatefulWidget> createState() {
    _state = _RewardedVideoAdState(this.adId, this.onCreated);
    return _state;
  }
}

class _RewardedVideoAdState extends State<RewardedVideoAd> with AutomaticKeepAliveClientMixin {
  /// 这个 ViewType 需要和上面在 Android 中定义的 ViewType 相同。
  static const String VIEW_TYPE = "com.cabe.flutter.widget.RewardedVideoAd";
  String _adId;
  OnViewCreated _onBannerCreated;

  _RewardedVideoAdState(String adId, OnViewCreated onBannerCreated) {
    this._adId = adId;
    this._onBannerCreated = onBannerCreated;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    // 这里使用 AndroidView，告知 Flutter 这是个原生控件，控件的类型是 VIEW_TYPE。
    if(defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: VIEW_TYPE,
        creationParams: {
          "adId": _adId,
          "timeout": 10000,
        },
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: this._onViewCreated,
      );
    } else if(defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: VIEW_TYPE,
        creationParams: {
          "adId": _adId,
          "timeout": 10000,
        },
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: this._onViewCreated,
      );
    } else return null;
  }

  @override
  bool get wantKeepAlive => true;

  void _onViewCreated(int id) {
    print("created: $id");
    MethodChannel channel = MethodChannel("$VIEW_TYPE#$id");
    this._onBannerCreated(channel);
  }
}