package com.abhay.better_textfield

import android.content.Context
import android.graphics.Color
import android.view.View
import android.widget.TextView
import android.widget.ScrollView
import android.widget.LinearLayout
import android.widget.EditText
import io.flutter.plugin.platform.PlatformView

internal class NativeView(context: Context, id: Int, creationParams: Map<String?, Any?>?) : PlatformView {
    private val et: EditText
    private val sv: ScrollView
    private val ll: LinearLayout

    override fun getView(): View {
        return sv
    }

    override fun dispose() {}

    init {
        sv = ScrollView(context);
        ll = LinearLayout(context);
        ll.setOrientation(LinearLayout.VERTICAL);
        sv.addView(ll);
        et = EditText(context)
        et.textSize = (creationParams?.getValue("textSize") as Double).toFloat();
        et.setBackgroundColor(Color.TRANSPARENT)
        et.setText(String.format("Rendered on a native Android view (id: %s) with text: %s", id, creationParams.getValue("text")))
        ll.addView(et);
    }
}