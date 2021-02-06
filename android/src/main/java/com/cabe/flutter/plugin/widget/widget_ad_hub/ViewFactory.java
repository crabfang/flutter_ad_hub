package com.cabe.flutter.plugin.widget.widget_ad_hub;

import android.content.Context;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class ViewFactory extends PlatformViewFactory {
    private final BinaryMessenger messenger;
    public ViewFactory(BinaryMessenger messenger) {
        super(StandardMessageCodec.INSTANCE);
        this.messenger = messenger;
    }
    @Override
    public PlatformView create(Context context, int viewId, Object args) {
        return new TestText(context, messenger, viewId);
    }
}
