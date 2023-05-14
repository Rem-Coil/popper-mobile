import 'package:flutter/material.dart';

class ActionsButton extends StatelessWidget {
  const ActionsButton({
    super.key,
    required this.buttons,
  });

  final List<ActionButtonItemInfo> buttons;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<ActionButtonItemInfo>(
      onSelected: (item) {
        item.onPressed();
      },
      itemBuilder: (BuildContext context) => buttons.map((b) {
        return PopupMenuItem<ActionButtonItemInfo>(
          value: b,
          child: Row(
            children: [
              Icon(b.icon, color: Colors.black),
              const SizedBox(width: 8),
              Text(b.title),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class ActionButtonItemInfo {
  const ActionButtonItemInfo({
    required this.icon,
    required this.title,
    required this.onPressed,
  });

  final IconData icon;
  final String title;
  final VoidCallback onPressed;
}
