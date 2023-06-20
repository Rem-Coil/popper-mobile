import 'package:flutter/material.dart';

class ValueInfoText extends StatelessWidget {
  final String text;
  final Color color;

  const ValueInfoText(
    this.text, {
    Key? key,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 24, color: color),
    );
  }
}
