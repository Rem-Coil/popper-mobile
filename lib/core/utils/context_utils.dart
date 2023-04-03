import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:popper_mobile/core/widgets/circular_loader.dart';

extension SnackBars on BuildContext {
  void showLoadingSnackBar({String? message}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        duration: const Duration(days: 365),
        content: Row(
          children: [
            const CircularLoader(
              size: 24,
              strokeWidth: 2,
            ),
            const SizedBox(width: 16),
            if (message != null) Text(message)
          ],
        ),
      ),
    );
  }

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

  void showErrorSnackBar(String message, {int seconds = 2}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        duration:
            kDebugMode ? const Duration(days: 1) : Duration(seconds: seconds),
        content: Text(
          message,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  void hideCurrentSnackBar() =>
      ScaffoldMessenger.of(this).hideCurrentSnackBar();
}
