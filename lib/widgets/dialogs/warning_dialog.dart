import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

class WarningDialog extends StatelessWidget {
  final String title;
  final String? message;
  final String actionTitle;

  const WarningDialog({
    Key? key,
    required this.title,
    this.message,
    String? actionTitle,
  })  : this.actionTitle = actionTitle ?? 'Пропустить',
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: message != null ? Text(message!) : null,
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          child: Text(actionTitle),
          isDestructiveAction: true,
          onPressed: () => context.router.navigateBack(),
        ),
      ],
    );
  }
}
