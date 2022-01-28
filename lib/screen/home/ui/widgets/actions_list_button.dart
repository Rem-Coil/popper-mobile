import 'package:flutter/material.dart';
import 'package:popper_mobile/widgets/buttons/simple_button.dart';

class ActionsListButton extends StatelessWidget {
  final int color;
  final String title;
  final int count;

  const ActionsListButton({
    Key? key,
    required this.color,
    required this.title,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleButton(
      height: 176,
      color: Color(color),
      borderRadius: 16,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, color: Colors.white, height: 1.2),
          ),
          Spacer(),
          Text(
            '$count',
            style: TextStyle(
              fontSize: 64,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      onPressed: () {},
    );
  }
}
