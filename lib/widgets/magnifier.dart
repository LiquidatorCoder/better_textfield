import 'dart:ui';

import 'package:better_textfield/controllers/magnifier_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Magnifier extends StatelessWidget {
  final Widget child;

  const Magnifier({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Consumer<MagnifierController>(
          builder: (context, _controller, child) {
            double newX =
                _controller.magnifierPosition.dx + (_controller.size.width / 2);
            double newY = _controller.magnifierPosition.dy +
                (_controller.size.height / 2) +
                _controller.textFieldHeight * 2;
            final Matrix4 matrix = Matrix4.identity()
              ..translate(newX, newY)
              ..scale(_controller.scale, _controller.scale)
              ..translate(-newX, -newY);
            return (_controller.enabled)
                ? Positioned(
                    left: _controller.magnifierPosition.dx,
                    top: _controller.magnifierPosition.dy,
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
                        borderRadius: _controller.radius,
                        child: BackdropFilter(
                          filter: ImageFilter.matrix(matrix.storage),
                          child: CustomPaint(
                            painter: _controller.painter,
                            size: _controller.size,
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
