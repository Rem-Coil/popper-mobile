import 'package:flutter/cupertino.dart';

class OperationTypeDialog extends StatelessWidget {
  const OperationTypeDialog({
    Key? key,
    this.title = 'Выберите тип операции',
    this.firstActionTitle = 'Проверка',
    this.secondActionTitle = 'Приёмка',
  }) : super(key: key);

  final String title;
  final String firstActionTitle;
  final String secondActionTitle;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          onPressed: () => Navigator.pop(context, 'First operation type'),
          child: Text(firstActionTitle),
        ),
        CupertinoDialogAction(
          onPressed: () => Navigator.pop(context, 'Second operation type'),
          child: Text(secondActionTitle),
        )
      ],
    );
  }
}
