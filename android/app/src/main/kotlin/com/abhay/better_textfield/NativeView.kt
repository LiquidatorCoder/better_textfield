package com.abhay.better_textfield

import android.content.Context
import android.graphics.Color
import android.view.View
import android.widget.TextView
import android.widget.ScrollView
import android.widget.LinearLayout
import android.widget.EditText
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;

internal class NativeView(context: Context, id: Int, messenger: BinaryMessenger) : PlatformView {
    private val et: EditText
    private val sv: ScrollView
    private val ll: LinearLayout
    private val mc: MethodChannel

    override fun getView(): View {
        return sv
    }

    override fun dispose() {}

    init {
        // Instantiate the method channel
        mc = MethodChannel(messenger, "NativeTextField")
        sv = ScrollView(context);
        ll = LinearLayout(context);
        ll.setOrientation(LinearLayout.VERTICAL);
        sv.addView(ll);
        // Create a new EditText inside a LinearLayout
        et = EditText(context)
        et.setBackgroundColor(Color.TRANSPARENT)
        ll.addView(et);
        // Registering the method call handler
        mc.setMethodCallHandler({
            call, result ->
           if (call.method == "setText"){
               // Set text of EditText
                et.setText(call.argument<String>("text"))
                result.success(true)
           }
           else if (call.method == "getText"){
               // Return text from EditText
            result.success(et.text.toString())
            }
            else {
                // Not implemented
                result.notImplemented()
            }
          })
    }
}