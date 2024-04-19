import 'dart:math';

import 'package:flutter/material.dart';

class ArcIndicator extends StatelessWidget {
  final double progress; // Progress value between 0.0 and 1.0
  final Widget child; // The button widget to wrap

  const ArcIndicator({
    super.key,
    required this.progress,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          painter: ArcPainter(progress: progress),
          child: Container(), // Container to fill the space
        ),
        child, // Place the button on top
      ],
    );
  }
}

class ArcPainter extends CustomPainter {
  final double progress;

  ArcPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFEC400)
      ..strokeWidth = 5.0 // Adjust stroke width
      ..style = PaintingStyle.stroke;

    final rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: size.width / 2 + 8,
    );

    final arcAngle = 2 * pi * progress; // Convert progress to arc angle

    canvas.drawArc(rect, -pi / 2, arcAngle, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
