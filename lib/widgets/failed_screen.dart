import 'package:flutter/material.dart';
import 'package:popper_mobile/widgets/buttons/simple_button.dart';

class FailedScreen extends StatelessWidget {
  final Image image;
  final String failText;

  final String dropText;
  final VoidCallback? dropAction;
  final String saveText;
  final VoidCallback? saveAction;

  FailedScreen({
    Key? key,
    required String imagePath,
    required this.failText,
    required this.dropText,
    required this.dropAction,
    required this.saveText,
    required this.saveAction,
  }) : image = Image.asset(imagePath), super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SizedBox(height: 40),
          Expanded(
            flex: 4,
            child: image,
          ),
          SizedBox(height: 30),
          Expanded(
            flex: 4,
            child: Text(
              failText,
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
                    child: Text(dropText),
                    onPressed: dropAction,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: SimpleButton(
                    child: Text(saveText),
                    onPressed: saveAction,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}