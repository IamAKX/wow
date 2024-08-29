import 'package:flutter/material.dart';

class DefaultPageLoader extends StatelessWidget {
  const DefaultPageLoader({
    super.key,
    this.progressColor,
  });
  final Color? progressColor;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: progressColor ?? Colors.black,
      ),
    );
  }
}
