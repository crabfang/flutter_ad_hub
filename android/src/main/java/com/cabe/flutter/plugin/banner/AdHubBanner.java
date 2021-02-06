package com.cabe.flutter.plugin.banner;

import android.content.Context;
import android.graphics.Color;
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
    private static String TAG = "AdHubBanner";
    public static String VIEW_TYPE_ID = "com.cabe.flutter.widget.AdHubBanner";
    private final FrameLayout bannerLayout;
    private BannerAd bannerAd;

    public AdHubBanner(Context context, BinaryMessenger messenger, int id, Object args) {
        bannerLayout = new FrameLayout(context);
        final MethodChannel methodChannel = new MethodChannel(messenger, VIEW_TYPE_ID + "#" + id);
        methodChannel.setMethodCallHandler(this);

        Map<String, Object> params = (Map<String, Object>) args;
        String adId = (String) params.get("adId");
        int timeout = 5000;
        if(params.containsKey("timeout")) {
            try {
                timeout = (int) params.get("timeout");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        double bannerWidth = 400;
        if(params.containsKey("bannerWidth")) {
            try {
                bannerWidth = (double) params.get("bannerWidth");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        double bannerHeight = Math.round(bannerWidth / 6.4F);
        if(params.containsKey("bannerHeight")) {
            try {
                bannerWidth = (double) params.get("bannerHeight");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        try {
            bannerAd = new BannerAd(context, adId, new BannerAdListener() {
                @Override
                public void onAdFailed(int code) {
                    Log.i("AdHubsDemo",TAG + " Banner ad onAdFailed " + code);
                    Map<String, Object> params = new HashMap<>();
                    params.put("code", code);
                    methodChannel.invokeMethod("onAdFailed", params);
                }
                @Override
                public void onAdLoaded() {
                    Log.i("AdHubsDemo",TAG + " Banner ad onAdLoaded");
                    methodChannel.invokeMethod("onAdLoaded", null);
                }
                @Override
                public void onAdShown() {
                    Log.i("AdHubsDemo",TAG + " Banner ad onAdShown");
                    methodChannel.invokeMethod("onAdShown", null);
                }
                @Override
                public void onAdClosed() {
                    Log.i("AdHubsDemo",TAG + " Banner ad onAdClosed");
                    methodChannel.invokeMethod("onAdClosed", null);
                }
                @Override
                public void onAdClick() {
                    Log.i("AdHubsDemo",TAG + " Banner ad onAdClick");
                    methodChannel.invokeMethod("onAdClick", null);
                }
            }, timeout);//广告请求超时时长，建议5秒以上,该参数单位为ms

            //建议Banner宽高比为6.4:1，特别说明：宽和高的单位是dp
            //广告view的宽度特别说明：假如广告有左右间距，故广告view的宽度 = 屏幕宽度 - 左右间距总和
            bannerAd.loadAd((float) bannerWidth, (float) bannerHeight, bannerLayout);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void onMethodCall(@NonNull MethodCall methodCall, @NonNull MethodChannel.Result result) {
        System.out.println("AdHubBanner MethodChannel call.method: " + methodCall.method+ " call arguments: " + methodCall.arguments);
        if(methodCall.method.equals("destroy")) {
            if(bannerAd != null) bannerAd.destroy();
        }
    }

    @Override
    public View getView() {
        return bannerLayout;
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
