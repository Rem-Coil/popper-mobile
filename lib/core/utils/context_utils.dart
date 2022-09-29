import 'package:flutter/material.dart';

extension SnackBars on BuildContext {
  void showSuccessSnackBar(String message, {int seconds = 1}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        duration: Duration(seconds: seconds),
        content: Text(
          message,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  void showErrorSnackBar(String message, {int seconds = 1}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        duration: Duration(seconds: seconds),
        content: Text(
          message,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
