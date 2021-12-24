import 'package:flutter/material.dart';

class MagnifierPainter extends CustomPainter {
  final double strokeWidth;
  final Color color;
  const MagnifierPainter({this.strokeWidth = 2, this.color = Colors.black});

  @override
  void paint(Canvas canvas, Size size) {
    Paint rectPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = color;
    final path = Path();
    path.addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(8)));
    canvas.drawPath(path, rectPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
