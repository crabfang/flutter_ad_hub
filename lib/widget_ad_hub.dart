

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

typedef OnAdHubBannerCreated = void Function(MethodChannel channel);
// ignore: must_be_immutable
class AdHubBanner extends StatefulWidget {
  OnAdHubBannerCreated onBannerCreated;
  _AdHubBannerState _state;

  AdHubBanner({Key key, this.onBannerCreated});

  @override
  State<StatefulWidget> createState() {
    _state = _AdHubBannerState(this.onBannerCreated);
    return _state;
  }
}

class _AdHubBannerState extends State<AdHubBanner> with AutomaticKeepAliveClientMixin {
  /// 这个 ViewType 需要和上面在 Android 中定义的 ViewType 相同。
  static const String VIEW_TYPE = "com.cabe.flutter.widget.TestText";
  OnAdHubBannerCreated _onBannerCreated;

  _AdHubBannerState(OnAdHubBannerCreated onBannerCreated) {
    this._onBannerCreated = onBannerCreated;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    // 这里使用 AndroidView，告知 Flutter 这是个原生控件，控件的类型是 VIEW_TYPE。
    return AndroidView(
      viewType: VIEW_TYPE,
      onPlatformViewCreated: this._onBannerViewCreated,
    );
  }

  @override
  bool get wantKeepAlive => true;

  void _onBannerViewCreated(int id) {
    print("banner created: $id");
    MethodChannel channel = MethodChannel("${VIEW_TYPE}_$id");
    this._onBannerCreated(channel);
  }
}