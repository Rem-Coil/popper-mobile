import 'package:flutter/cupertino.dart';
import 'package:popper_mobile/domain/models/operation/operation_type.dart';

class SelectOperationDialog extends StatelessWidget {
  const SelectOperationDialog({
    Key? key,
    required this.types,
  }) : super(key: key);

  final List<ActionType> types;

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: const Text('Выбрать операцию'),
      actions: types.map<CupertinoActionSheetAction>((o) {
        return CupertinoActionSheetAction(
          child: Text(o.name),
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
