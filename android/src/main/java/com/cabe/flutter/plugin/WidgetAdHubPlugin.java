package com.cabe.flutter.plugin;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.adhub.ads.AdHubs;
import com.cabe.flutter.plugin.banner.AdHubBanner;
import com.cabe.flutter.plugin.banner.AdHubBannerFactory;
import com.cabe.flutter.plugin.banner.AdHubNative;
import com.cabe.flutter.plugin.banner.AdHubNativeFactory;
import com.cabe.flutter.plugin.splash.AdHubSplash;
import com.cabe.flutter.plugin.splash.AdHubSplashFactory;
import com.cabe.flutter.plugin.video.FullScreenVideo;
import com.cabe.flutter.plugin.video.FullScreenVideoFactory;
import com.cabe.flutter.plugin.video.RewardedVideo;
import com.cabe.flutter.plugin.video.RewardedVideoFactory;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** WidgetAdHubPlugin */
public class WidgetAdHubPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private ActivityPluginBinding activityBinding = null;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    BinaryMessenger messenger = flutterPluginBinding.getBinaryMessenger();
    channel = new MethodChannel(messenger, "AdHubPlugin");
    channel.setMethodCallHandler(this);

    OnFactoryListener listener = new OnFactoryListener() {
      @Override
      public Activity getActivity() {
        return activityBinding.getActivity();
      }
    };
    flutterPluginBinding.getPlatformViewRegistry().registerViewFactory(AdHubSplash.VIEW_TYPE_ID, new AdHubSplashFactory(messenger, listener));
    flutterPluginBinding.getPlatformViewRegistry().registerViewFactory(AdHubBanner.VIEW_TYPE_ID, new AdHubBannerFactory(messenger, listener));
    flutterPluginBinding.getPlatformViewRegistry().registerViewFactory(AdHubNative.VIEW_TYPE_ID, new AdHubNativeFactory(messenger, listener));
    flutterPluginBinding.getPlatformViewRegistry().registerViewFactory(RewardedVideo.VIEW_TYPE_ID, new RewardedVideoFactory(messenger, listener));
    flutterPluginBinding.getPlatformViewRegistry().registerViewFactory(FullScreenVideo.VIEW_TYPE_ID, new FullScreenVideoFactory(messenger, listener));
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("init")) {
      initAdHubs(call, result);
    } else {
      result.notImplemented();
    }
  }

  private void initAdHubs(@NonNull MethodCall call, @NonNull Result result) {
    try {
      String appId = (String) call.argument("appId");
      AdHubs.init(activityBinding.getActivity(), appId);
      result.success(true);
    } catch (Exception e) {
      e.printStackTrace();
      result.success(false);
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    activityBinding = binding;
  }

  @Override
  public void onDetachedFromActivity() {
    activityBinding = null;
  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
  }
}
