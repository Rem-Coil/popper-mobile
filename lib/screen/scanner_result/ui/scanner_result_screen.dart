import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:popper_mobile/core/setup/app_router.dart';
import 'package:popper_mobile/screen/scanner_result/model/scanner_result_arguments.dart';
import 'package:popper_mobile/widgets/buttons/simple_button.dart';

class ScannerResultScreen extends StatelessWidget {
  final ScannerResultArguments args;

  const ScannerResultScreen({Key? key, required this.args}) : super(key: key);

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
              child: Image.asset(args.image),
            ),
            const SizedBox(height: 30),
            Expanded(
              flex: 4,
              child: Text(
                args.message,
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
            Expanded(
              child: SimpleButton(
                child: const Text('На главную'),
                onPressed: () => context.router.navigate(const HomeRoute()),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
