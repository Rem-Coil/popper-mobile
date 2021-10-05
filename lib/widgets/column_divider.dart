import 'package:flutter/material.dart';

class ColumnDivider extends StatelessWidget {
  final double size;

  const ColumnDivider(this.size, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: size);
  }
}
