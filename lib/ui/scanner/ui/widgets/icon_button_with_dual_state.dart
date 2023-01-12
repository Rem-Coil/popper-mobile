import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class IconButtonWithDualState<T> extends StatelessWidget {
  const IconButtonWithDualState({
    super.key,
    this.color = Colors.white,
    this.size = 32,
    required this.onPressed,
    required this.valueListenable,
    required this.firstValue,
    required this.firstIcon,
    required this.anotherIcon,
  });

  final VoidCallback onPressed;
  final Color color;
  final double size;
  final ValueListenable<T> valueListenable;
  final T firstValue;
  final Widget firstIcon;
  final Widget anotherIcon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: Colors.white,
      iconSize: 32.0,
      onPressed: onPressed,
      icon: ValueListenableBuilder<T>(
        valueListenable: valueListenable,
        builder: (context, state, child) {
          if (state == firstValue) {
            return firstIcon;
          }
          return anotherIcon;
        },
      ),
    );
  }
}
