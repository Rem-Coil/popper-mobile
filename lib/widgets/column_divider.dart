import 'package:flutter/material.dart';

class ColumnDivider extends StatelessWidget {
  const ColumnDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 5),
        Divider(height: 1),
        SizedBox(height: 5),
      ],
    );
  }
}
