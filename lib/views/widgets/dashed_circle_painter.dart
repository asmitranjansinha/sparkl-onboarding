import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class DashedCirclePainter extends CustomPainter {
  final Color dashColor;
  final double dashWidth;
  final double dashGap;
  final double iconSize;
  final int onBoardingView; // Add this to track the current view

  DashedCirclePainter({
    required this.dashColor,
    required this.dashWidth,
    required this.dashGap,
    required this.iconSize,
    required this.onBoardingView, // Pass the current view
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double radius =
        iconSize / 2 + dashWidth; // Adjust radius to include dash width
    final Rect rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: radius,
    );

    final double circumference = 2 * 3.1416 * radius;
    final double dashLength =
        (circumference - 3 * dashGap) / 3; // Adjust for 3 dashes
    final double dashAngle = (dashLength / circumference) * 2 * 3.1416;
    final double gapAngle = (dashGap / circumference) * 2 * 3.1416;

    double startAngle = -3.1416 / 2; // Start at the top

    for (int i = 0; i < 3; i++) {
      // Determine the color of each dash based on the current view
      final Color currentDashColor =
          onBoardingView >= i + 1 ? dashColor : Colors.grey;

      final Paint paint = Paint()
        ..color = currentDashColor
        ..strokeWidth = dashWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        rect, // Rect for the circle
        startAngle, // Start angle
        dashAngle, // Sweep angle (length of the dash)
        false, // Don't use center (draw an arc, not a sector)
        paint, // Paint object
      );
      startAngle += dashAngle + gapAngle; // Move to the next dash
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
