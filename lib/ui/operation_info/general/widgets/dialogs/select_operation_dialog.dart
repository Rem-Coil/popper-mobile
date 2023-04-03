import 'package:flutter/cupertino.dart';
import 'package:popper_mobile/domain/models/operation/operation_type.dart';

class SelectOperationDialog extends StatelessWidget {
  const SelectOperationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: const Text('Выбрать операцию'),
      actions: OperationType.values.map<CupertinoActionSheetAction>((o) {
        return CupertinoActionSheetAction(
          child: Text(o.localizedName),
          onPressed: () {
            Navigator.pop(context, o);
          },
        );
      }).toList(),
      cancelButton: CupertinoActionSheetAction(
        child: const Text('Отмена'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
