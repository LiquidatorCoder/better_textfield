package com.abhay.better_textfield

import android.content.Context
import android.view.View
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import io.flutter.plugin.common.BinaryMessenger;

class NativeViewFactory constructor(messenger:BinaryMessenger): PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    private val messenger: BinaryMessenger;
    init{
        this.messenger = messenger;
    }
    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        return NativeView(context, viewId, messenger)
    }
}