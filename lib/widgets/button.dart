import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  final double width;
  final String text;
  final bool isLoad;
  final VoidCallback onPressed;

  const LoadingButton({
    Key? key,
    required this.width,
    required this.text,
    required this.onPressed,
    required this.isLoad,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: isLoad
              ? Container(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(color: Colors.white),
                )
              : Text(text, style: TextStyle(fontSize: 20)),
        ),
        style: _style,
      ),
    );
  }

  ButtonStyle get _style {
    return ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      ),
    );
  }
}
