package com.cabe.flutter.plugin.banner;

import android.content.Context;
import android.util.Log;
import android.view.View;
import android.widget.FrameLayout;

import androidx.annotation.NonNull;

import com.adhub.ads.NativeAd;
import com.adhub.ads.NativeAdListener;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;

public class AdHubNative implements PlatformView, MethodChannel.MethodCallHandler {
    private static final String TAG = "AdHubNative";
    public static String VIEW_TYPE_ID = "com.cabe.flutter.widget.AdHubNative";
    private final FrameLayout containerLayout;
    private NativeAd nativeAd;

    public AdHubNative(Context context, BinaryMessenger messenger, int id, Object args) {
        containerLayout = new FrameLayout(context);
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
        int showWidth = 0;
        if(params.containsKey("showWidth")) {
            try {
                showWidth = (int) params.get("showWidth");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        int showHeight = 0;
        if(params.containsKey("showHeight")) {
            try {
                showHeight = (int) params.get("showHeight");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        try {
            nativeAd = new NativeAd(context, adId, new NativeAdListener() {
                @Override
                public void onAdFailed(int errorCode) {
                    Log.d(TAG,"onAdFailed " + errorCode);
                    Map<String, Object> params = new HashMap<>();
                    params.put("code", errorCode);
                    methodChannel.invokeMethod("onAdFailed", params);
                }
                @Override
                public void onAdLoaded(View view) {
                    Log.d(TAG,"onAdLoaded");
                    methodChannel.invokeMethod("onAdLoaded", null);
                    if (containerLayout.getChildCount() > 0) {
                        containerLayout.removeAllViews();
                    }
                    // 广告可见才会产生曝光，否则将无法产生收益。
                    containerLayout.addView(view);
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
            nativeAd.loadAd((float) showWidth, (float) showHeight);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void onMethodCall(@NonNull MethodCall methodCall, @NonNull MethodChannel.Result result) {
        Log.w(TAG, "onMethodCall: method: " + methodCall.method + " arguments: " + methodCall.arguments);
        if(methodCall.method.equals("destroy")) {
            if(nativeAd != null) nativeAd.destroy();
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
