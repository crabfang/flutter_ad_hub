import 'package:widget_ad_hub/widget_base.dart';

// ignore: must_be_immutable
class AdHubSplash extends AdHubWidget {
  AdHubSplash(String adIdOfAndroid, String adIdOfIOS) : super(adIdOfAndroid, adIdOfIOS);

  @override
  AdHubState<AdHubWidget> onGetAdHubState(onViewCreated) {
    return _SplashState(this.adIdOfAndroid, this.adIdOfIOS, onViewCreated);
  }
}

class _SplashState extends AdHubState<AdHubSplash> {
  @override String onGetViewType() => "com.cabe.flutter.widget.AdHubSplash";

  _SplashState(String adIdOfAndroid, String adIdOfIOS, OnViewCreated onCreated) : super(adIdOfAndroid, adIdOfIOS, onCreated);
}