import 'package:flutter/cupertino.dart';
import 'package:popper_mobile/domain/models/operation/qe_operation_type.dart';

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
          onPressed: () => Navigator.pop(context, QeOperationType.check),
          child: Text(QeOperationType.check.localizedOperationType),
        ),
        CupertinoDialogAction(
          onPressed: () => Navigator.pop(context, QeOperationType.acceptance),
          child: Text(QeOperationType.acceptance.localizedOperationType),
        )
      ],
    );
  }
}
