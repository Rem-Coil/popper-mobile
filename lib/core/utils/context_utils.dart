import 'package:flutter/widgets.dart';

extension Navigateon on BuildContext {
  pushReplacement(String route) {
    Navigator.of(this).pushReplacementNamed(route);
  }

  push(String route) {
    Navigator.of(this).pushNamed(route);
  }
}