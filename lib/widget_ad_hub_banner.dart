import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

typedef OnViewCreated = void Function(MethodChannel channel);
// ignore: must_be_immutable
class AdHubBanner extends StatefulWidget {
  String adId;
  OnViewCreated onCreated;
  double showWidth;
  double showHeight;
  _BannerState _state;

  AdHubBanner(String adId, {Key key, this.onCreated, this.showWidth, this.showHeight}) {
    this.adId = adId;
  }

  @override
  State<StatefulWidget> createState() {
    _state = _BannerState(this.adId, this.onCreated, this.showWidth, this.showHeight);
    return _state;
  }
}

class _BannerState extends State<AdHubBanner> with AutomaticKeepAliveClientMixin {
  /// 这个 ViewType 需要和上面在 Android 中定义的 ViewType 相同。
  static const String VIEW_TYPE = "com.cabe.flutter.widget.AdHubBanner";
  String _adId;
  OnViewCreated _onBannerCreated;
  double _showWidth;
  double _showHeight;

  _BannerState(String adId, OnViewCreated onBannerCreated, double showWidth, double showHeight) {
    this._adId = adId;
    this._onBannerCreated = onBannerCreated;
    this._showWidth = showWidth;
    this._showHeight = showHeight;
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
          "timeout": 5000,
          "showWidth": _showWidth?.toInt(),
          "showHeight": _showHeight?.toInt(),
        },
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: this._onViewCreated,
      );
    } else if(defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: VIEW_TYPE,
        creationParams: {
          "adId": _adId,
          "timeout": 5000,
          "showWidth": _showWidth?.toInt(),
          "showHeight": _showHeight?.toInt(),
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