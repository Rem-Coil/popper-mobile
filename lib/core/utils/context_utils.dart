import 'package:flutter/material.dart';

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
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
