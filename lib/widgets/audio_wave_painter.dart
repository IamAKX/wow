import 'package:flutter/material.dart';

class AudioWavePainter extends CustomPainter {
  final double animationValue;

  AudioWavePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint wavePaint = Paint()
      ..color = Colors.blue.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    // Draw multiple expanding circles to simulate audio waves
    for (int i = 0; i < 4; i++) {
      final double radius = (size.width / 2) * (animationValue + i / 4);
      if (radius < size.width / 2) {
        canvas.drawCircle(
          Offset(size.width / 2, size.height / 2),
          radius,
          wavePaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
