import 'package:flutter/material.dart';

extension Navigation on BuildContext {
  Future<void> pushReplacement(String route, {Object? args}) {
    return Navigator.of(this).pushReplacementNamed(route, arguments: args);
  }

  Future<void> push(String route, {Object? args}) {
    return Navigator.of(this).pushNamed(route, arguments: args);
  }

  void pop() {
    Navigator.of(this).pop();
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

  void errorSnackBar(String message, {int seconds = 1}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          message,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
