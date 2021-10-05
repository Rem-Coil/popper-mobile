import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final double size;

  const Logo(this.size, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/images/logo.png',
        width: size,
        fit: BoxFit.fill,
      ),
    );
  }
}
