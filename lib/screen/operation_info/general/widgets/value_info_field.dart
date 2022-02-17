import 'package:flutter/material.dart';

class ValueInfoField extends StatelessWidget {
  final String title;
  final Widget value;

  const ValueInfoField({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, color: Color(0xFFA8A8A8)),
        ),
        value
      ],
    );
  }
}
