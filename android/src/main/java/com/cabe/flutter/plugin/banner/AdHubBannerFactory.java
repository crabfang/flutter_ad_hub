package com.cabe.flutter.plugin.banner;

import android.content.Context;

import com.cabe.flutter.plugin.OnFactoryListener;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class AdHubBannerFactory extends PlatformViewFactory {
    private final OnFactoryListener listener;
    private final BinaryMessenger messenger;
    public AdHubBannerFactory(BinaryMessenger messenger, OnFactoryListener listener) {
        super(StandardMessageCodec.INSTANCE);
        this.messenger = messenger;
        this.listener = listener;
    }
    @Override
    public PlatformView create(Context context, int viewId, Object args) {
        return new AdHubBanner(listener.getActivity(), messenger, viewId, args);
    }
}