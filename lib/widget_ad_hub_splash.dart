import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:widget_ad_hub/widget_ad_hub_banner.dart';

// ignore: must_be_immutable
class AdHubSplash extends StatefulWidget {
  String adId;
  OnViewCreated onCreated;
  _SplashState _state;

  AdHubSplash(String adId, {Key key, this.onCreated}) {
    this.adId = adId;
  }

  @override
  State<StatefulWidget> createState() {
    _state = _SplashState(this.adId, this.onCreated);
    return _state;
  }
}

class _SplashState extends State<AdHubSplash> with AutomaticKeepAliveClientMixin {
  /// 这个 ViewType 需要和上面在 Android 中定义的 ViewType 相同。
  static const String VIEW_TYPE = "com.cabe.flutter.widget.AdHubSplash";
  String _adId;
  OnViewCreated _onBannerCreated;

  _SplashState(String adId, OnViewCreated onBannerCreated) {
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
          "timeout": 4000,
        },
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: this._onBannerViewCreated,
      );
    } else if(defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: VIEW_TYPE,
        creationParams: {
          "adId": _adId,
          "timeout": 4000,
        },
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: this._onBannerViewCreated,
      );
    } else return null;
  }

  @override
  bool get wantKeepAlive => true;

  void _onBannerViewCreated(int id) {
    print("splash created: $id");
    MethodChannel channel = MethodChannel("${VIEW_TYPE}_$id");
    this._onBannerCreated(channel);
  }
}