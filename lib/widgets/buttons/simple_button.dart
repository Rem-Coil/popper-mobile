import 'package:flutter/material.dart';

class SimpleButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final Color? color;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  const SimpleButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.height,
    this.width,
    this.color,
    double? borderRadius,
    EdgeInsetsGeometry? padding,
  })  : this.borderRadius = borderRadius ?? 12,
        this.padding = padding ?? const EdgeInsets.all(16),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        child: child,
        style: _style,
      ),
    );
  }

  ButtonStyle get _style {
    return ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(padding),
      backgroundColor: MaterialStateProperty.all<Color?>(color),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}