import 'package:flutter/material.dart';
import 'package:popper_mobile/core/utils/context_utils.dart';
import 'package:popper_mobile/screen/scanner_result/model/scanner_result_arguments.dart';
import 'package:popper_mobile/widgets/buttons/simple_button.dart';

class ScannerResultScreen extends StatelessWidget {
  static const route = "/scanner_result";
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
            SizedBox(height: 40),
            Expanded(
              flex: 4,
              child: Image.asset(args.image),
            ),
            SizedBox(height: 30),
            Expanded(
              flex: 4,
              child: Text(
                args.message,
                overflow: TextOverflow.fade,
                maxLines: 4,
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: SimpleButton(
                child: Text('На главную'),
                onPressed: () => context.pop(),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
