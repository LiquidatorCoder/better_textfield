import 'dart:developer';

import 'package:better_textfield/controllers/native_text_field_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  // Controller to handle text or input from our native text field
  final NativeTextViewController _controller = NativeTextViewController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(32),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFa8e063), Color(0xFF56ab2f)],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              const Text(
                'So nice to meet you! What do your friends call you?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFeaecff),
                ),
              ),
              const Spacer(flex: 3),
              // Basic Native Textfield
              Container(
                padding: const EdgeInsets.all(2),
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12)),
                child:
                    // Hybrid composition android view
                    PlatformViewLink(
                  // Setting viewType
                  viewType: 'NativeTextField',
                  surfaceFactory: (BuildContext context,
                      PlatformViewController controller) {
                    return AndroidViewSurface(
                      controller: controller as AndroidViewController,
                      gestureRecognizers: const <
                          Factory<OneSequenceGestureRecognizer>>{},
                      hitTestBehavior: PlatformViewHitTestBehavior.opaque,
                    );
                  },
                  // Handling focus events
                  onCreatePlatformView: (PlatformViewCreationParams params) {
                    return PlatformViewsService.initSurfaceAndroidView(
                      id: params.id,
                      viewType: 'NativeTextField',
                      layoutDirection: TextDirection.ltr,
                      creationParamsCodec: const StandardMessageCodec(),
                      onFocus: () {
                        params.onFocusChanged(true);
                      },
                    )
                      ..addOnPlatformViewCreatedListener(
                          params.onPlatformViewCreated)
                      ..create();
                  },
                ),
              ),
              const Spacer(flex: 4),
            ],
          ),
        ),
      ),
      // Call to action button which gets text input value
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 16, right: 16),
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 6),
              blurRadius: 10,
            ),
          ],
          borderRadius: BorderRadius.circular(16),
        ),
        child: IconButton(
          icon: const Icon(Icons.check),
          color: const Color(0xFF56ab2f),
          onPressed: () {
            // log("Done!", name: "fab");
            // _controller.setText("Hello World!");
            _controller.getText().then((String? text) {
              log(text ?? '', name: "text");
            });
          },
        ),
      ),
    );
  }
}
