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

  set enabled(bool enabled) {
    _magnifierService.enabled = enabled;
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
}
