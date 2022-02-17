import 'package:flutter/material.dart';
import 'package:popper_mobile/widgets/buttons/simple_button.dart';
import 'package:popper_mobile/widgets/circular_loader.dart';

class LoadingButton extends StatelessWidget {
  final double? width;
  final String text;
  final bool isLoad;
  final VoidCallback onPressed;

  const LoadingButton({
    Key? key,
    this.width,
    required this.text,
    required this.onPressed,
    required this.isLoad,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleButton(
      width: width,
      child: isLoad
          ? CircularLoader(size: 25, color: Colors.white)
          : Text(text, style: TextStyle(fontSize: 20)),
      onPressed: onPressed,
    );
  }
}
