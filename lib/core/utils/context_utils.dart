import 'package:flutter/material.dart';
import 'package:popper_mobile/core/error/failure.dart';

extension Navigateon on BuildContext {
  pushReplacement(String route, {Object? args}) {
    Navigator.of(this).pushReplacementNamed(route, arguments: args);
  }

  push(String route, {Object? args}) {
    Navigator.of(this).pushNamed(route, arguments: args);
  }
}

extension SnackBars on BuildContext {
  void successSnackBar(String message, {int seconds = 1}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text(message),
        duration: Duration(seconds: seconds),
      ),
    );
  }

  void errorSnackBar(Failure failure, {int seconds = 1}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          failure.message,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}