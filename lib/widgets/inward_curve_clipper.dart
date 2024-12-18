import 'package:flutter/material.dart';

class InwardCurveClipper extends CustomClipper<Path> {
  final double width;
  final double height;

  InwardCurveClipper({super.reclip, required this.width, required this.height});
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, 0.0); // Start at the top-left corner

    // Top side - inward curve
    path.quadraticBezierTo(
      width / 2, // Control point X (center of the width)
      -50, // Control point Y (move upwards for inward curve)
      width, // End point X (right side of the width)
      0.0, // End point Y (back to the top right corner)
    );

    path.lineTo(width, height); // Right side down to the bottom-right corner
    path.lineTo(
        0.0, height); // Left side from bottom-right to bottom-left corner
    path.close(); // Close the path back to the starting point

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; // No need to reclip
  }
}
