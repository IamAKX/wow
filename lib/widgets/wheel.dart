import 'dart:math';

import 'package:flutter/material.dart';

import 'package:worldsocialintegrationapp/models/spin_data_model.dart';

class WheelPainter extends CustomPainter {
  List<SpinDataModel> spinDataList;
  WheelPainter({
    required this.spinDataList,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double radius = 105;
    final Offset center = Offset(size.width / 2, size.height / 2);

    // Define the 8 segment colors
    final List<Color> colors = [
      Colors.white,
      const Color(0xFF00D000),
      Colors.white,
      const Color(0xFF7F00D9),
      Colors.white,
      const Color(0xFFDC0000),
      Colors.white,
      const Color(0xFF028BFF),
    ];

    final Paint paint = Paint()..style = PaintingStyle.fill;
    const double sweepAngle = 2 * pi / 8;

    for (int i = 0; i < spinDataList.length; i++) {
      paint.color = colors[i];
      final startAngle = i * sweepAngle;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );

      // Draw the text in each segment
      _drawTextInSegment(
          canvas, size, center, startAngle + sweepAngle / 2, radius, i);
    }
  }

  void _drawTextInSegment(Canvas canvas, Size size, Offset center, double angle,
      double radius, int segmentIndex) {
    canvas.save();

    // Move the canvas to the center and rotate by the angle to align the text with the segment
    canvas.translate(center.dx, center.dy);
    canvas.rotate(angle + (pi / 2));

    // Move canvas to the top center of the segment
    canvas.translate(0, -radius / 1.5);

    // Define the text styles
    TextSpan textSpan = TextSpan(
      children: [
        TextSpan(
          text: '${spinDataList[segmentIndex].header}\n',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: segmentIndex % 2 == 0 ? Colors.black : Colors.white,
          ),
        ),
        TextSpan(
          text: spinDataList[segmentIndex].subtitle ?? '' + '\n\n',
          style: TextStyle(
            fontSize: 8,
            color: segmentIndex % 2 == 0 ? Colors.black : Colors.white,
          ),
        ),
      ],
    );

    final TextPainter textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout();

    // Draw the text at the calculated position, aligned vertically
    textPainter.paint(
      canvas,
      Offset(-textPainter.width / 2, -textPainter.height / 2),
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
