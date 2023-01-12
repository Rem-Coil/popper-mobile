import 'package:flutter/material.dart';
import 'package:popper_mobile/domain/models/user/role.dart';

class SelectRoleButton extends StatelessWidget {
  const SelectRoleButton({
    super.key,
    required this.current,
    required this.onChanged,
  });

  final Role current;

  final ValueChanged<Role?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: current,
      underline: const SizedBox.shrink(),
      isExpanded: true,
      alignment: Alignment.centerRight,
      onChanged: (Role? role) => onChanged(role),
      items: Role.values
          .map<DropdownMenuItem<Role>>(
            (value) => DropdownMenuItem(
              value: value,
              child: Text(
                value.localizedRole,
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
