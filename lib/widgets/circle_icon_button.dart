import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color color;
  final VoidCallback onPressed;

  const CircleIconButton({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          onTap: onPressed,
          child: SizedBox(
            width: 40,
            height: 40,
            child: Icon(icon, color: iconColor),
          ),
        ),
      ),
    );
  }
}
