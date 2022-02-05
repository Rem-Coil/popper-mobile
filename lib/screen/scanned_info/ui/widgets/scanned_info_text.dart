import 'package:flutter/material.dart';

class ScannedInfoText extends StatelessWidget {
  final String text;

  const ScannedInfoText(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 24,
        color: Colors.black,
      ),
    );
  }
}
