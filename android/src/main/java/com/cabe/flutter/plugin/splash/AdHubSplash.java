package com.cabe.flutter.plugin.splash;

import android.content.Context;
import android.util.Log;
import android.view.View;
import android.widget.FrameLayout;

import androidx.annotation.NonNull;

import com.adhub.ads.AdListener;
import com.adhub.ads.SplashAd;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;

public class AdHubSplash implements PlatformView, MethodChannel.MethodCallHandler {
    private static final String TAG = "AdHubSplash";
    public static String VIEW_TYPE_ID = "com.cabe.flutter.widget.AdHubSplash";
    private final FrameLayout containerLayout;
    private SplashAd splashAd;

    public AdHubSplash(Context context, BinaryMessenger messenger, int id, Object args) {
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
        try {
            splashAd = new SplashAd(context, containerLayout, adId, new AdListener() {
                @Override
                public void onAdLoaded() {
                    Log.d(TAG, "onAdLoaded");
                    methodChannel.invokeMethod("onAdLoaded", null);
                }
                @Override
                public void onAdShown() {
                    Log.d(TAG, "onAdShown");
                    methodChannel.invokeMethod("onAdShown", null);
                }
                @Override
                public void onAdFailedToLoad(int errorCode) {
                    Log.d(TAG, "onAdFailedToLoad:" + errorCode);
                    Map<String, Object> params = new HashMap<>();
                    params.put("errorCode", errorCode);
                    methodChannel.invokeMethod("onAdFailedToLoad", params);
                }
                @Override
                public void onAdClosed() {
                    Log.d(TAG, "onAdClosed");
                    methodChannel.invokeMethod("onAdClosed", null);
                }
                /**
                 * 倒计时回调，返回广告还将被展示的剩余时间。
                 * 通过这个接口，开发者可以自行决定是否显示倒计时提示，或者还剩几秒的时候显示倒计时
                 */
                @Override
                public void onAdTick(long millisUnitFinished) {
                    Log.d(TAG, "onAdTick: " + millisUnitFinished);
                    Map<String, Object> params = new HashMap<>();
                    params.put("millisUnitFinished", millisUnitFinished);
                    methodChannel.invokeMethod("onAdTick", params);
                }
                @Override
                public void onAdClicked() {
                    Log.d(TAG, "onAdClick");
                    methodChannel.invokeMethod("onAdClicked", null);
                }
            }, timeout);//广告请求超时时长，建议5秒以上,该参数单位为ms
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void onMethodCall(@NonNull MethodCall methodCall, @NonNull MethodChannel.Result result) {
        System.out.println(TAG + " MethodChannel call.method: " + methodCall.method+ " call arguments: " + methodCall.arguments);
        if(methodCall.method.equals("cancel")) {
            if(splashAd != null) splashAd.cancel(containerLayout.getContext());
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
