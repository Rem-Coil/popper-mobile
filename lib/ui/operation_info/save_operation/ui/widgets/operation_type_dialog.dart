import 'package:flutter/cupertino.dart';

class OperationTypeDialog extends StatelessWidget {
  const OperationTypeDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Выберите тип операции'),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          onPressed: () => Navigator.pop(context, 'Проверка'),
          child: const Text('Проверка'),
        ),
        CupertinoDialogAction(
          onPressed: () => Navigator.pop(context, 'Приёмка'),
          child: const Text('Приёмка'),
        )
      ],
    );
  }
}
