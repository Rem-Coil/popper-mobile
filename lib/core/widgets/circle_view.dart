import 'package:flutter/material.dart';

class CircleView extends StatelessWidget {
  const CircleView({
    super.key,
    this.size = 20,
    this.color = Colors.red,
  });

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: Size(size, size), painter: _CirclePainter(color));
  }
}

class _CirclePainter extends CustomPainter {
  const _CirclePainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawOval(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
