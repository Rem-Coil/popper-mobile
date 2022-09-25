import 'package:flutter/cupertino.dart';

class DecisionDialog extends StatelessWidget {
  final String title;
  final String? message;

  final String destructiveActionTitle;
  final VoidCallback? destructiveAction;
  final String saveActionTitle;
  final VoidCallback? saveAction;

  const DecisionDialog({
    Key? key,
    required this.title,
    this.message,
    String? destructiveActionTitle,
    this.destructiveAction,
    String? saveActionTitle,
    this.saveAction,
  })  : destructiveActionTitle = destructiveActionTitle ?? 'Пропустить',
        saveActionTitle = saveActionTitle ?? 'Сохранить',
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: message != null ? Text(message!) : null,
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () => destructiveAction ?? Navigator.pop(context, false),
          child: Text(destructiveActionTitle),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () => saveAction ?? Navigator.pop(context, true),
          child: Text(saveActionTitle),
        )
      ],
    );
  }
}
