package com.cabe.flutter.plugin.video;

import android.app.Activity;
import android.content.Context;
import android.util.Log;
import android.view.View;
import android.widget.FrameLayout;

import androidx.annotation.NonNull;

import com.adhub.ads.RewardedVideoAd;
import com.adhub.ads.RewardedVideoAdListener;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;

public class RewardedVideo implements PlatformView, MethodChannel.MethodCallHandler {
    private static final String TAG = "RewardedVideo";
    public static String VIEW_TYPE_ID = "com.cabe.flutter.widget.RewardedVideoAd";
    private final FrameLayout containerLayout;
    private RewardedVideoAd videoAd;

    public RewardedVideo(final Context context, BinaryMessenger messenger, int id, Object args) {
        containerLayout = new FrameLayout(context);
        final MethodChannel methodChannel = new MethodChannel(messenger, VIEW_TYPE_ID + "#" + id);
        methodChannel.setMethodCallHandler(this);

        Map<String, Object> params = (Map<String, Object>) args;
        String adId = (String) params.get("adId");
        int timeout = 10000;

        try {
            videoAd = new RewardedVideoAd(context, adId, new RewardedVideoAdListener() {
                @Override
                public void onRewarded() {
                    Log.d(TAG,"onRewarded");
                    methodChannel.invokeMethod("onRewarded", null);
                }
                @Override
                public void onRewardedVideoAdFailedToLoad(int errorCode) {
                    Log.d(TAG,"onRewardedVideoAdFailedToLoad errorCode = "+errorCode);
                    Map<String, Object> params = new HashMap<>();
                    params.put("errorCode", errorCode);
                    methodChannel.invokeMethod("onRewardedVideoAdFailedToLoad", params);
                }
                @Override
                public void onRewardedVideoAdLoaded() {
                    Log.d(TAG,"onRewardedVideoAdLoaded");
                    methodChannel.invokeMethod("onRewardedVideoAdLoaded", null);
                    //广告加载成功直接显示
                    if (videoAd != null && videoAd.isLoaded()) {
                        videoAd.showAd((Activity) context);
                    }
                }
                @Override
                public void onRewardedVideoAdShown() {
                    Log.d(TAG,"onRewardedVideoAdShown");
                    methodChannel.invokeMethod("onRewardedVideoAdShown", null);
                }
                @Override
                public void onRewardedVideoAdClosed() {
                    Log.d(TAG,"onRewardedVideoAdClosed");
                    methodChannel.invokeMethod("onRewardedVideoAdClosed", null);
                }
                @Override
                public void onRewardedVideoClick() {
                    Log.d(TAG,"onRewardedVideoClick");
                    methodChannel.invokeMethod("onRewardedVideoClick", null);
                }
            }, timeout);//广告请求超时时长，建议5秒以上,该参数单位为ms
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void onMethodCall(@NonNull MethodCall methodCall, @NonNull MethodChannel.Result result) {
        Log.w(TAG, "onMethodCall: method: " + methodCall.method + " arguments: " + methodCall.arguments);
        if(methodCall.method.equals("destroy")) {
            if(videoAd != null) videoAd.destroy();
        } else if(methodCall.method.equals("loadAd")) {
            if(videoAd != null) videoAd.loadAd();
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