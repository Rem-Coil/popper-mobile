import 'package:flutter/cupertino.dart';
import 'package:popper_mobile/domain/models/operation/operation_type.dart';

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
          onPressed: () => Navigator.pop(context, OperationType.check),
          child: Text(OperationType.check.localizedOperationType),
        ),
        CupertinoDialogAction(
          onPressed: () => Navigator.pop(context, OperationType.acceptance),
          child: Text(OperationType.acceptance.localizedOperationType),
        )
      ],
    );
  }
}
