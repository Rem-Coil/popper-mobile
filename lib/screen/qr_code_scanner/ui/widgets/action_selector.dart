import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:popper_mobile/models/action/action.dart';

class ActionSelector extends StatelessWidget {
  final ActionType? currentAction;
  final ValueChanged<ActionType?> onPressed;

  const ActionSelector({
    Key? key,
    required this.currentAction,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<ActionType>(
      value: currentAction,
      dropdownColor: Theme.of(context).primaryColor,
      icon: const Icon(
        Icons.keyboard_arrow_down,
        color: Colors.white,
      ),
      iconSize: 24,
      underline: SizedBox(),
      hint: Text('Выбирете действие', style: TextStyle(color: Colors.white)),
      onChanged: onPressed,
      items: ActionType.values.map((e) {
        return DropdownMenuItem<ActionType>(
          value: e,
          child: Text(
            describeEnum(e),
            style: TextStyle(color: Colors.white),
          ),
        );
      }).toList(),
    );
  }
}
