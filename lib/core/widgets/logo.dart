import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key, this.width}) : super(key: key);

  final double? width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/images/logo.png',
        width: width,
        fit: BoxFit.fill,
      ),
    );
  }
}
