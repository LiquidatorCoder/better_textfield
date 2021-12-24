import 'dart:ui';

import 'package:better_textfield/widgets/magnifier_painter.dart';
import 'package:flutter/material.dart';

class Magnifier extends StatefulWidget {
  final Widget child;
  final double scale;
  final Size size;
  final bool enabled;
  final CustomPainter painter;
  final Offset magnifierPosition;
  final double height;

  const Magnifier(
      {required this.child,
      this.enabled = true,
      this.scale = 1.2,
      this.size = const Size(80, 80),
      this.painter = const MagnifierPainter(),
      this.magnifierPosition = const Offset(0, 0),
      this.height = 0,
      Key? key})
      : super(key: key);

  @override
  _MagnifierState createState() => _MagnifierState();
}

class _MagnifierState extends State<Magnifier> {
  Size? _magnifierSize;
  double? _scale;
  BorderRadius? _radius;

  Matrix4 matrix = Matrix4.identity();

  @override
  void initState() {
    _magnifierSize = widget.size;
    _scale = widget.scale;
    _radius = BorderRadius.circular(8);
    matrix = Matrix4.identity()..scale(widget.scale);
    super.initState();
  }

  @override
  void didUpdateWidget(Magnifier oldWidget) {
    if (oldWidget.size != widget.size) {
      _magnifierSize = widget.size;
      _radius = BorderRadius.circular(8);
    }
    if (oldWidget.scale != widget.scale) {
      _scale = widget.scale;
      matrix = Matrix4.identity()..scale(_scale);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    double newX = widget.magnifierPosition.dx + (_magnifierSize!.width / 2);
    double newY = widget.magnifierPosition.dy +
        (_magnifierSize!.height / 2) +
        widget.height * 2;
    final Matrix4 newMatrix = Matrix4.identity()
      ..translate(newX, newY)
      ..scale(_scale, _scale)
      ..translate(-newX, -newY);

    matrix = newMatrix;

    return Stack(
      alignment: Alignment.center,
      children: [
        widget.child,
        if (widget.enabled)
          Positioned(
            left: widget.magnifierPosition.dx,
            top: widget.magnifierPosition.dy,
            child: DecoratedBox(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: _radius,
                child: BackdropFilter(
                  filter: ImageFilter.matrix(matrix.storage),
                  child: CustomPaint(
                    painter: widget.painter,
                    size: _magnifierSize!,
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }
}
