package com.abhay.better_textfield

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
  // Registering view factory
      override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        flutterEngine
                .platformViewsController
                .registry
                .registerViewFactory("NativeTextField", NativeViewFactory(flutterEngine.dartExecutor.binaryMessenger))
    }
}
