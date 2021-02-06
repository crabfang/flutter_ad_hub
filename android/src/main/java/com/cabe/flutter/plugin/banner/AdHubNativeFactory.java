package com.cabe.flutter.plugin.banner;

import android.content.Context;

import com.cabe.flutter.plugin.OnFactoryListener;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class AdHubNativeFactory extends PlatformViewFactory {
    private final OnFactoryListener listener;
    private final BinaryMessenger messenger;
    public AdHubNativeFactory(BinaryMessenger messenger, OnFactoryListener listener) {
        super(StandardMessageCodec.INSTANCE);
        this.messenger = messenger;
        this.listener = listener;
    }
    @Override
    public PlatformView create(Context context, int viewId, Object args) {
        return new AdHubNative(listener.getActivity(), messenger, viewId, args);
    }
}
