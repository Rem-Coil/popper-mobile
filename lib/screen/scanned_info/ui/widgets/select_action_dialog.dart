import 'package:flutter/cupertino.dart';
import 'package:popper_mobile/models/action/action_type.dart';

class SelectActionDialog extends StatelessWidget {
  const SelectActionDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: const Text('Выбрать операцию'),
      actions: ActionType.values.map<CupertinoActionSheetAction>((a) {
        return CupertinoActionSheetAction(
          child: Text(a.getLocalizedName()),
          onPressed: () {
            Navigator.pop(context, a);
          },
        );
      }).toList(),
      cancelButton: CupertinoActionSheetAction(
        child: const Text('Отмена'),
        onPressed: () {
          Navigator.pop(context, null);
        },
      ),
    );
  }
}
