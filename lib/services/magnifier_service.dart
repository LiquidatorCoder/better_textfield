import 'package:better_textfield/widgets/magnifier_painter.dart';
import 'package:flutter/material.dart';

class MagnifierService {
  bool enabled = false;
  double scale = 2;
  CustomPainter painter =
      const MagnifierPainter(strokeWidth: 0.5, color: Colors.black12);
  Offset magnifierPosition = Offset.zero;
  double textFieldHeight = 0;
  Size size = const Size(110, 50);
  BorderRadius radius = const BorderRadius.all(Radius.circular(8));
}
