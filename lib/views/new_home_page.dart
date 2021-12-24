import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class NewHomePage extends StatelessWidget {
  const NewHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String viewType = 'textfield';
    Map<String, dynamic> creationParams = <String, dynamic>{
      'text': 'a',
      'textSize': Theme.of(context).textTheme.subtitle1?.fontSize ?? 10.0,
    };
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(32),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF838aeb), Color(0xFF7c77cd)],
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
              Text(
                'So nice to meet you! What do your friends call you?',
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFeaecff),
                ),
              ),
              const Spacer(flex: 3),
              Container(
                padding: const EdgeInsets.all(2),
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8)),
                child: PlatformViewLink(
                  viewType: viewType,
                  surfaceFactory: (BuildContext context,
                      PlatformViewController controller) {
                    return AndroidViewSurface(
                      controller: controller as AndroidViewController,
                      gestureRecognizers: const <
                          Factory<OneSequenceGestureRecognizer>>{},
                      hitTestBehavior: PlatformViewHitTestBehavior.opaque,
                    );
                  },
                  onCreatePlatformView: (PlatformViewCreationParams params) {
                    return PlatformViewsService.initSurfaceAndroidView(
                      id: params.id,
                      viewType: viewType,
                      layoutDirection: TextDirection.ltr,
                      creationParams: creationParams,
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
          color: const Color(0xFF838aeb),
          onPressed: () => log("Done!", name: "fab"),
        ),
      ),
    );
  }
}
