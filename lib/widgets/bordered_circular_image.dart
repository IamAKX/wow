import 'package:flutter/material.dart';

class BorderedCircularImage extends StatelessWidget {
  final String imagePath;
  final double diameter;
  final Color borderColor;
  final double borderThickness;
  const BorderedCircularImage({
    super.key,
    required this.imagePath,
    required this.diameter,
    required this.borderColor,
    required this.borderThickness,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter + borderThickness,
      height: diameter + borderThickness,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: borderThickness),
      ),
      child: ClipOval(
        child: Image.asset(
          imagePath,
          width: diameter,
          height: diameter,
        ),
      ),
    );
  }
}
