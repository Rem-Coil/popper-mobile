import 'package:flutter/cupertino.dart';

class OperationTypeDialog extends StatelessWidget {
  const OperationTypeDialog({
    Key? key,
    required this.title,
    this.message,
    required this.firstActionTitle,
    this.cancelAction,
    required this.secondActionTitle,
    this.acceptAction,
  }) : super(key: key);

  final String title;
  final String? message;

  final String firstActionTitle;
  final VoidCallback? cancelAction;
  final String secondActionTitle;
  final VoidCallback? acceptAction;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: message != null ? Text(message!) : null,
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          onPressed: () => cancelAction ?? Navigator.pop(context, 'First operation type'),
          child: Text(firstActionTitle),
        ),
        CupertinoDialogAction(
          onPressed: () => acceptAction ?? Navigator.pop(context, 'Second operation type'),
          child: Text(secondActionTitle),
        )
      ],
    );
  }
}
