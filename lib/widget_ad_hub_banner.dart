import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

typedef OnViewCreated = void Function(MethodChannel channel);
// ignore: must_be_immutable
class AdHubBanner extends StatefulWidget {
  String adId;
  OnViewCreated onCreated;
  double bannerWidth;
  double bannerHeight;
  _BannerState _state;

  AdHubBanner(String adId, {Key key, this.onCreated, this.bannerWidth, this.bannerHeight}) {
    this.adId = adId;
  }

  @override
  State<StatefulWidget> createState() {
    _state = _BannerState(this.adId, this.onCreated, this.bannerWidth, this.bannerHeight);
    return _state;
  }
}

class _BannerState extends State<AdHubBanner> with AutomaticKeepAliveClientMixin {
  /// 这个 ViewType 需要和上面在 Android 中定义的 ViewType 相同。
  static const String VIEW_TYPE = "com.cabe.flutter.widget.AdHubBanner";
  String _adId;
  OnViewCreated _onBannerCreated;
  double _bannerWidth;
  double _bannerHeight;

  _BannerState(String adId, OnViewCreated onBannerCreated, double bannerWidth, double bannerHeight) {
    this._adId = adId;
    this._onBannerCreated = onBannerCreated;
    this._bannerWidth = bannerWidth;
    this._bannerHeight = bannerHeight;
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
          "timeout": 2000,
          "bannerWidth": _bannerWidth,
          "_bannerHeight": _bannerHeight,
        },
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: this._onBannerViewCreated,
      );
    } else if(defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: VIEW_TYPE,
        creationParams: {
          "adId": _adId,
          "timeout": 2000,
          "bannerWidth": _bannerWidth,
          "_bannerHeight": _bannerHeight,
        },
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: this._onBannerViewCreated,
      );
    } else return null;
  }

  @override
  bool get wantKeepAlive => true;

  void _onBannerViewCreated(int id) {
    print("banner created: $id");
    MethodChannel channel = MethodChannel("${VIEW_TYPE}_$id");
    this._onBannerCreated(channel);
  }
}