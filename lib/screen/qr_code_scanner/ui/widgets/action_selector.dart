import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:popper_mobile/models/action/action_type.dart';

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
      dropdownColor: Colors.white,
      icon: const Icon(
        Icons.keyboard_arrow_down,
        color: Colors.black,
      ),
      iconSize: 24,
      underline: SizedBox(),
      alignment: AlignmentDirectional.centerEnd,
      hint: Text('...', style: TextStyle(color: Colors.black)),
      onChanged: onPressed,
      items: ActionType.values.map((e) {
        return DropdownMenuItem<ActionType>(
          value: e,
          child: Text(
            e.getLocalizedName(),
            style: TextStyle(color: Colors.black),
          ),
        );
      }).toList(),
    );
  }
}
