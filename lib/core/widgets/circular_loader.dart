import 'package:flutter/material.dart';

class CircularLoader extends StatelessWidget {
  const CircularLoader({
    Key? key,
    this.size,
    this.strokeWidth,
    this.color,
  }) : super(key: key);

  final double? size;
  final double? strokeWidth;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth ?? 4,
        color: color,
      ),
    );
  }
}
