package com.cabe.flutter.plugin.banner;

import android.content.Context;
import android.util.Log;
import android.view.View;
import android.widget.FrameLayout;

import androidx.annotation.NonNull;

import com.adhub.ads.BannerAd;
import com.adhub.ads.BannerAdListener;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;

public class AdHubBanner implements PlatformView, MethodChannel.MethodCallHandler {
    private static final String TAG = "AdHubBanner";
    public static String VIEW_TYPE_ID = "com.cabe.flutter.widget.AdHubBanner";

    private final String adId;
    private int timeout;
    private int showWidth;
    private int showHeight;
    private final MethodChannel methodChannel;
    private final FrameLayout containerLayout;
    private BannerAd bannerAd;

    public AdHubBanner(Context context, BinaryMessenger messenger, int id, Object args) {
        containerLayout = new FrameLayout(context);
        methodChannel = new MethodChannel(messenger, VIEW_TYPE_ID + "#" + id);
        methodChannel.setMethodCallHandler(this);

        Map<String, Object> params = (Map<String, Object>) args;
        adId = (String) params.get("adId");
        timeout = 5000;
        if(params.containsKey("timeout")) {
            try {
                timeout = (int) params.get("timeout");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        showWidth = 400;
        if(params.containsKey("showWidth")) {
            try {
                showWidth = (int) params.get("showWidth");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        showHeight = Math.round(showWidth / 6.4F);
        if(params.containsKey("showHeight")) {
            try {
                showHeight = (int) params.get("showHeight");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        createBanner();
    }

    @Override
    public void onMethodCall(@NonNull MethodCall methodCall, @NonNull MethodChannel.Result result) {
        Log.w(TAG, "onMethodCall: method: " + methodCall.method + " arguments: " + methodCall.arguments);
        if(methodCall.method.equals("destroy")) {
            if(bannerAd != null) bannerAd.destroy();
            result.success(true);
        } else if(methodCall.method.equals("refresh")) {
            createBanner();
            result.success(true);
        } else {
            result.notImplemented();
        }
    }

    private void createBanner() {
        try {
            containerLayout.removeAllViews();

            bannerAd = new BannerAd(containerLayout.getContext(), adId, new BannerAdListener() {
                @Override
                public void onAdFailed(int errorCode) {
                    Log.d(TAG,"onAdFailed " + errorCode);
                    Map<String, Object> params = new HashMap<>();
                    params.put("code", errorCode);
                    methodChannel.invokeMethod("onAdFailed", params);
                }
                @Override
                public void onAdLoaded() {
                    Log.d(TAG,"onAdLoaded");
                    methodChannel.invokeMethod("onAdLoaded", null);
                }
                @Override
                public void onAdShown() {
                    Log.d(TAG,"onAdShown");
                    methodChannel.invokeMethod("onAdShown", null);
                }
                @Override
                public void onAdClosed() {
                    Log.d(TAG,"onAdClosed");
                    containerLayout.removeAllViews();
                    methodChannel.invokeMethod("onAdClosed", null);
                }
                @Override
                public void onAdClick() {
                    Log.d(TAG,"onAdClick");
                    methodChannel.invokeMethod("onAdClick", null);
                }
            }, timeout);//广告请求超时时长，建议5秒以上,该参数单位为ms

            //建议Banner宽高比为6.4:1，特别说明：宽和高的单位是dp
            //广告view的宽度特别说明：假如广告有左右间距，故广告view的宽度 = 屏幕宽度 - 左右间距总和
            bannerAd.loadAd((float) showWidth, (float) showHeight, containerLayout);
        } catch (Exception e) {
            e.printStackTrace();
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
