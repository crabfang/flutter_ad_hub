package com.cabe.flutter.plugin.widget.widget_ad_hub;

import android.content.Context;
import android.graphics.Color;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;

public class TestText implements PlatformView, MethodChannel.MethodCallHandler {
    public static String NATIVE_CCTV_VIEW_TYPE_ID = "com.cabe.flutter.widget.TestText";
    private final TextView myNativeView;

    public TestText(Context context, BinaryMessenger messenger, int id) {
        this.myNativeView = new TextView(context);
        myNativeView.setTextSize(20);
        myNativeView.setTextColor(Color.parseColor("#333333"));
        myNativeView.setText("init text");
//        ViewGroup.LayoutParams params = new ViewGroup.LayoutParams(
//                ViewGroup.LayoutParams.WRAP_CONTENT,
//                ViewGroup.LayoutParams.WRAP_CONTENT
//        );
//        myNativeView.setLayoutParams(params);
        MethodChannel methodChannel = new MethodChannel(messenger, NATIVE_CCTV_VIEW_TYPE_ID + "_" + id);
        methodChannel.setMethodCallHandler(this);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall methodCall, @NonNull MethodChannel.Result result) {
        System.out.println("TestText MethodChannel call.method: " + methodCall.method+ " call arguments: " + methodCall.arguments);
        if ("setText".equals(methodCall.method)) {
            String text = (String) methodCall.arguments;
            myNativeView.setText(text);
            result.success("setText success");
        } else if ("setTextColor".equals(methodCall.method)) {
            String textColor = (String) methodCall.arguments;
            myNativeView.setTextColor(Color.parseColor(textColor));
            result.success("setTextColor success");
        } else if ("setTextSize".equals(methodCall.method)) {
            int textSize = (int) methodCall.arguments;
            myNativeView.setTextSize(textSize);
            result.success("setTextSize success");
        } else if ("setBackground".equals(methodCall.method)) {
            String background = (String) methodCall.arguments;
            myNativeView.setBackgroundColor(Color.parseColor(background));
            result.success("setBackground success");
        }
    }

    @Override
    public View getView() {
        return myNativeView;
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
