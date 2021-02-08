## 介绍
widget_ad_hub 是一个基于Flutter提供的ADSdk广告插件，支持Andorid、iOS平台

## 使用

#### 引入插件
在主工程的pubspec.yaml文件的dependencies引入本地插件

```yaml
dependencies:
    widget_ad_hub:
    path: ../
```

#### 初始化插件

```dart
    AdHubPlugin.init("appIdOfAndroid", "appIdOfIOS");
```

#### 控件使用

```dart
    //闪屏控件
    AdHubSplash("adIdOfAndroid", "adIdOfIOS");

    //banner控件
    AdHubBanner("adIdOfAndroid", "adIdOfIOS", showWidth: 360);

    //native控件
    AdHubNative("adIdOfAndroid", "adIdOfIOS", showWidth: 360, showHeight: 200,);

    //激励视频
    RewardedVideoAd("adIdOfAndroid", "adIdOfIOS").loadAD();

    //全屏视频
    FullscreenVideoAd("adIdOfAndroid", "adIdOfIOS").loadAD();
    
```
