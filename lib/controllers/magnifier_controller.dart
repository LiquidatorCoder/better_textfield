import 'dart:async';

import 'package:better_textfield/constants/global_singleton.dart' as globals;
import 'package:better_textfield/services/magnifier_service.dart';
import 'package:flutter/material.dart';

class MagnifierController extends ChangeNotifier {
  // Getting service global variable
  final MagnifierService _magnifierService = globals.magnifierService;
  bool get enabled => _magnifierService.enabled;
  double get scale => _magnifierService.scale;
  CustomPainter get painter =>
      _magnifierService.painter; // CustomPainter to draw magnifier
  Offset get magnifierPosition => _magnifierService.magnifierPosition;
  double get textFieldHeight => _magnifierService.textFieldHeight;
  Size get size => _magnifierService.size;
  BorderRadius get radius => _magnifierService.radius;
  Timer? _timer;

  set enabled(bool enabled) {
    _magnifierService.enabled = enabled;
    if (enabled) {
      if (_timer?.isActive ?? false) {
        _timer?.cancel();
      }
      _timer = Timer(const Duration(milliseconds: 1000), () {
        _magnifierService.enabled = false;
        notifyListeners();
      });
    }
    notifyListeners();
  }

  set magnifierPosition(Offset magnifierPosition) {
    _magnifierService.magnifierPosition = magnifierPosition;
    notifyListeners();
  }

  set size(Size size) {
    _magnifierService.size = size;
    notifyListeners();
  }

  set textFieldHeight(double textFieldHeight) {
    _magnifierService.textFieldHeight = textFieldHeight;
    notifyListeners();
  }

  set radius(BorderRadius radius) {
    _magnifierService.radius = radius;
    notifyListeners();
  }

  void toggleVisbility() {
    _magnifierService.enabled = !_magnifierService.enabled;
    notifyListeners();
  }

  void updatePosition(int baseOffset) {
    final keyContext = globals.globalKey.currentContext;
    if (keyContext != null) {
      // widget is visible
      final box = keyContext.findRenderObject() as RenderBox;
      _magnifierService.textFieldHeight = box.size.height;
      _magnifierService.magnifierPosition = box.localToGlobal(Offset(
          0 - _magnifierService.size.width / 2 + baseOffset * 9.7,
          0 - box.size.height));
      notifyListeners();
    }
  }
}
