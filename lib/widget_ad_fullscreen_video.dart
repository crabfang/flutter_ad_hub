import 'package:widget_ad_hub/widget_base.dart';

// ignore: must_be_immutable
class FullscreenVideoAd extends AdHubWidget {
  FullscreenVideoAd(String adIdOfAndroid, String adIdOfIOS) : super(adIdOfAndroid, adIdOfIOS);

  @override
  AdHubState<AdHubWidget> onGetAdHubState(onViewCreated) {
    return _FullscreenVideoAdState(this.adIdOfAndroid, this.adIdOfIOS, onViewCreated);
  }

  void loadAD() {
    print("$tag: loadAD $channel");
    channel?.invokeMethod("loadAd");
  }
}

class _FullscreenVideoAdState extends AdHubState<FullscreenVideoAd> {
  @override String onGetViewType() => "com.cabe.flutter.widget.FullScreenVideoAd";

  _FullscreenVideoAdState(String adIdOfAndroid, String adIdOfIOS, OnViewCreated onCreated) : super(adIdOfAndroid, adIdOfIOS, onCreated);
}