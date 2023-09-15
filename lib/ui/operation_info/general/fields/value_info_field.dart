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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, color: Color(0xFFA8A8A8)),
          ),
          value
        ],
      ),
    );
  }
}
