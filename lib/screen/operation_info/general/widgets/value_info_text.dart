import 'package:flutter/material.dart';

class ValueInfoText extends StatelessWidget {
  final String text;

  const ValueInfoText(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(fontSize: 24, color: Colors.black));
  }
}
