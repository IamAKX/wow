import 'package:flutter/material.dart';

class ButtonLoader extends StatelessWidget {
  final Color color;
  final double size;

  const ButtonLoader({
    Key? key,
    this.color = Colors.white,
    this.size = 20.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        color: color,
        strokeWidth: 2,
      ),
    );
  }
}
