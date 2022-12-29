import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:popper_mobile/core/setup/app_router.dart';
import 'package:popper_mobile/widgets/buttons/simple_button.dart';

class ResultView extends StatelessWidget {
  const ResultView({
    super.key,
    required this.message,
    this.isSuccess = true,
  });

  final String message;
  final bool isSuccess;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Expanded(
              flex: 4,
              child: Image.asset(
                isSuccess
                    ? 'assets/images/success.png'
                    : 'assets/images/save_exception.png',
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              flex: 4,
              child: Text(
                message,
                overflow: TextOverflow.fade,
                maxLines: 4,
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),
            SimpleButton(
              width: double.infinity,
              height: 55,
              child: const Text('На главную', style: TextStyle(fontSize: 18)),
              onPressed: () => context.router.navigate(const HomeRoute()),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
