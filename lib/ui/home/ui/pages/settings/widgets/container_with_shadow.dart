import 'package:flutter/material.dart';

class ContainerWithShadow extends StatelessWidget {
  const ContainerWithShadow({
    super.key,
    required this.child,
    this.verticalMargin = 8.0,
  });

  final Widget child;
  final double verticalMargin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: verticalMargin),
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Color(0xFFffffff),
        borderRadius: BorderRadius.all(Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: Color(0xC9E0E0E0),
            blurRadius: 5.0,
            spreadRadius: 1.0,
            offset: Offset.zero,
          )
        ],
      ),
      child: child,
    );
  }
}
