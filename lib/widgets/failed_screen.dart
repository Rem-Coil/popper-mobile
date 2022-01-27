import 'package:flutter/material.dart';
import 'package:popper_mobile/widgets/button.dart';

class FailedScreen extends StatelessWidget {
  static const String route = '/failed';
  final FailedScreenArgs args;

  const FailedScreen({
    Key? key,
    required this.args,
  }) : super(key: key);

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
                  args.failText,
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
                child: Row(
                  children: [
                    Expanded(
                      child: SimpleButton(
                        child: Text(args.dropText),
                        onPressed: args.dropAction,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: SimpleButton(
                        child: Text(args.saveText),
                        onPressed: args.saveAction,
                      ),
                    ),
                  ],
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

class FailedScreenArgs {
  final Image image;
  final String failText;

  final String dropText;
  final VoidCallback? dropAction;
  final String saveText;
  final VoidCallback? saveAction;

  FailedScreenArgs({
    required String imagePath,
    required this.failText,
    required this.dropText,
    required this.dropAction,
    required this.saveText,
    required this.saveAction,
  }) : image = Image.asset(imagePath);
}
