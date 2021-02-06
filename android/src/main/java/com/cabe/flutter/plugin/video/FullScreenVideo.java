package com.cabe.flutter.plugin.video;

import android.app.Activity;
import android.content.Context;
import android.util.Log;
import android.view.View;
import android.widget.FrameLayout;

import androidx.annotation.NonNull;

import com.adhub.ads.FullScreenVideoAd;
import com.adhub.ads.FullScreenVideoAdListener;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;

public class FullScreenVideo implements PlatformView, MethodChannel.MethodCallHandler {
    private static final String TAG = "FullScreenVideo";
    public static String VIEW_TYPE_ID = "com.cabe.flutter.widget.FullScreenVideoAd";
    private final FrameLayout containerLayout;
    private FullScreenVideoAd videoAd;

    public FullScreenVideo(final Context context, BinaryMessenger messenger, int id, Object args) {
        containerLayout = new FrameLayout(context);
        final MethodChannel methodChannel = new MethodChannel(messenger, VIEW_TYPE_ID + "#" + id);
        methodChannel.setMethodCallHandler(this);

        Map<String, Object> params = (Map<String, Object>) args;
        String adId = (String) params.get("adId");
        int timeout = 10000;

        try {
            videoAd = new FullScreenVideoAd(context, adId, new FullScreenVideoAdListener() {
                @Override
                public void onAdFailed(int errorCode) {
                    Log.i(TAG,TAG + " onAdFailed ");
                    Map<String, Object> params = new HashMap<>();
                    params.put("errorCode", errorCode);
                    methodChannel.invokeMethod("onAdFailed", params);
                }

                @Override
                public void onAdLoaded() {
                    Log.i(TAG,TAG + " onAdLoaded");
                    methodChannel.invokeMethod("onAdLoaded", null);
                    //全屏广告加载成功直接显示全屏视频
                    if (videoAd != null && videoAd.isLoaded()) {
                        videoAd.showAd((Activity) context);
                    }
                }
                @Override
                public void onAdShown() {
                    Log.i(TAG,TAG + " onAdShown");
                    methodChannel.invokeMethod("onAdShown", null);
                }
                @Override
                public void onAdClosed() {
                    Log.i(TAG,TAG + " onAdClosed");
                    methodChannel.invokeMethod("onAdClosed", null);
                }
                @Override
                public void onAdClick() {
                    Log.i("AdHubsDemo",TAG + " onAdClick");
                    methodChannel.invokeMethod("onAdClick", null);
                }
            }, timeout);//广告请求超时时长，建议5秒以上,该参数单位为ms
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void onMethodCall(@NonNull MethodCall methodCall, @NonNull MethodChannel.Result result) {
        String method = methodCall.method;
        System.out.println(TAG + " MethodChannel call.method: " + method+ " call arguments: " + methodCall.arguments);
        if(method.equals("destroy")) {
            if(videoAd != null) videoAd.destroy();
        } else if(method.equals("loadAd")) {
            if(videoAd != null)videoAd.loadAd();
        }
    }

    @Override
    public View getView() {
        return containerLayout;
    }

    @Override
    public void onFlutterViewAttached(@NonNull View flutterView) {}

    @Override
    public void onFlutterViewDetached() {}

    @Override
    public void dispose() {}

    @Override
    public void onInputConnectionLocked() {}

    @Override
    public void onInputConnectionUnlocked() {}
}