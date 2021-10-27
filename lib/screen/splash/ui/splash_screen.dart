import 'package:flutter/material.dart';
import 'package:popper_mobile/widgets/logo.dart';

class SplashScreen extends StatelessWidget {
  static const route = '/splash';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Logo(250),
      ),
    );
  }
}
