import 'package:flutter/material.dart';

class TwoPartBorderPainter extends CustomPainter {
  final Color firstPartColor;
  final Color secondPartColor;

  TwoPartBorderPainter({
    required this.firstPartColor,
    required this.secondPartColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    final double radius = size.width / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);

    // Draw the first (yellow) part of the border (270 degrees)
    paint.color = firstPartColor;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.14 / 2, // Start angle (-90 degrees)
      3 * 3.14 / 2, // Sweep angle (270 degrees)
      false,
      paint,
    );

    // Draw the second (grey) part of the border (90 degrees)
    paint.color = secondPartColor;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      3.14 / 2, // Start angle (90 degrees)
      3.14 / 2, // Sweep angle (90 degrees)
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
