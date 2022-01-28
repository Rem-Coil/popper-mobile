import 'package:flutter/material.dart';
import 'package:popper_mobile/widgets/buttons/simple_button.dart';

class SuccessScreen extends StatelessWidget {
  static const String route = '/success';
  final SuccessScreenArgs args;

  const SuccessScreen({Key? key, required this.args}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 40),
              Expanded(
                flex: 4,
                child: args.image,
              ),
              SizedBox(height: 30),
              Expanded(
                flex: 4,
                child: Text(
                  args.successText,
                  overflow: TextOverflow.fade,
                  maxLines: 4,
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 30),
              Expanded(
                child: SimpleButton(
                  child: Text(args.navigateText),
                  onPressed: args.navigateAction,
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class SuccessScreenArgs {
  final Image image;
  final String successText;
  final String navigateText;
  final VoidCallback? navigateAction;

  SuccessScreenArgs({
    required String imagePath,
    required this.successText,
    required this.navigateText,
    required this.navigateAction,
  }) : image = Image.asset(imagePath);
}
