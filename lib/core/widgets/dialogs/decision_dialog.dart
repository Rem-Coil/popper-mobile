import 'package:flutter/cupertino.dart';

class DecisionDialog extends StatelessWidget {
  const DecisionDialog({
    Key? key,
    required this.title,
    this.message,
    this.cancelActionTitle = 'Пропустить',
    this.cancelAction,
    this.acceptActionTitle = 'Сохранить',
    this.acceptAction,
  }) : super(key: key);

  final String title;
  final String? message;

  final String cancelActionTitle;
  final VoidCallback? cancelAction;
  final String acceptActionTitle;
  final VoidCallback? acceptAction;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: message != null ? Text(message!) : null,
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () => cancelAction ?? Navigator.pop(context, false),
          child: Text(cancelActionTitle),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () => acceptAction ?? Navigator.pop(context, true),
          child: Text(acceptActionTitle),
        )
      ],
    );
  }
}
