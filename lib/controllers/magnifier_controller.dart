import 'dart:async';

import 'package:better_textfield/constants/global_singleton.dart' as globals;
import 'package:better_textfield/services/magnifier_service.dart';
import 'package:flutter/material.dart';

class MagnifierController extends ChangeNotifier {
  // Getting service global variable
  final MagnifierService _magnifierService = globals.magnifierService;
  bool get enabled => _magnifierService.enabled;
  int get maxLines => _magnifierService.maxLines;
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

  set maxLines(int maxLines) {
    _magnifierService.maxLines = maxLines;
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
// void _onTextChanged() {
//     // substract text field padding to get available space
//     final inputWidth = _textFieldKey.currentContext.size.width - textFieldPadding.horizontal;

//     // calculate width of text using text painter
//     final textPainter = TextPainter(
//       textDirection: TextDirection.ltr,
//       text: TextSpan(
//         text: _controller.text,
//         style: textFieldTextStyle,
//       ),
//     );
//     textPainter.layout();

//     var textWidth = textPainter.width;
//     var fontSize = textFieldTextStyle.fontSize;

//     // not really efficient and doesn't find the perfect size, but you got all you need!
//     while (textWidth > inputWidth && fontSize > 1.0) {
//       fontSize -= 0.5;
//       textPainter.text = TextSpan(
//         text: _controller.text,
//         style: textFieldTextStyle.copyWith(fontSize: fontSize),
//       );
//       textPainter.layout();
//       textWidth = textPainter.width;
//     }

//     setState(() {
//       _textWidth = textPainter.width;
//       _fontSize = fontSize;
//     });
//   }
  void updatePosition(int baseOffset) {
    final keyContext = globals.globalKey.currentContext;
    if (keyContext != null) {
      // widget is visible
      final box = keyContext.findRenderObject() as RenderBox;
      _magnifierService.textFieldHeight = box.size.height;
      _magnifierService.magnifierPosition = box.localToGlobal(Offset(
          0 - _magnifierService.size.width / 2 + baseOffset * 9.7,
          0 - _magnifierService.size.height));
      notifyListeners();
    }
  }
}
