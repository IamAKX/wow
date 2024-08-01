import 'package:flutter/material.dart';

class CircularImage extends StatelessWidget {
  final String imagePath;
  final double diameter;
  const CircularImage({
    super.key,
    required this.imagePath,
    required this.diameter,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(diameter),
      child: Image.asset(
        imagePath,
        width: diameter,
        height: diameter,
      ),
    );
  }
}
