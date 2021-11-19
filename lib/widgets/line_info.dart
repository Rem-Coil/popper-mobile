import 'package:flutter/material.dart';

class LineInfo extends StatelessWidget {
  final String label;
  final Widget infoValue;

  const LineInfo({
    Key? key,
    required this.label,
    required this.infoValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label, style: TextStyle(fontSize: 25)),
        Spacer(),
        infoValue
      ],
    );
  }
}
