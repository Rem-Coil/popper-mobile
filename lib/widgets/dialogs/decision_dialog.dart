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
  })  : this.destructiveActionTitle = destructiveActionTitle ?? 'Пропустить',
        this.saveActionTitle = saveActionTitle ?? 'Сохранить',
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: message != null ? Text(message!) : null,
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          child: Text(destructiveActionTitle),
          isDestructiveAction: true,
          onPressed: () => destructiveAction ?? Navigator.pop(context, false),
        ),
        CupertinoDialogAction(
          child: Text(saveActionTitle),
          isDefaultAction: true,
          onPressed: () => saveAction ?? Navigator.pop(context, true),
        )
      ],
    );
  }
}
