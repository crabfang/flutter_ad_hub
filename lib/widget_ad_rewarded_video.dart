import 'package:widget_ad_hub/widget_base.dart';

// ignore: must_be_immutable
class RewardedVideoAd extends AdHubWidget {
  RewardedVideoAd(String adIdOfAndroid, String adIdOfIOS) : super(adIdOfAndroid, adIdOfIOS);

  @override
  AdHubState<AdHubWidget> onGetAdHubState(onViewCreated) {
    return _RewardedVideoAdState(this.adIdOfAndroid, this.adIdOfIOS, onViewCreated);
  }

  void loadAD() {
    channel?.invokeMethod("loadAd");
  }
}

class _RewardedVideoAdState extends AdHubState<RewardedVideoAd> {
  @override String onGetViewType() => "com.cabe.flutter.widget.RewardedVideoAd";

  _RewardedVideoAdState(String adIdOfAndroid, String adIdOfIOS, OnViewCreated onCreated) : super(adIdOfAndroid, adIdOfIOS, onCreated);
}