import 'package:flutter/material.dart';
import 'package:popper_mobile/ui/operation_info/general/fields/value_info_text.dart';

class CheckBoxButton extends StatelessWidget {
  const CheckBoxButton({
    super.key,
    required this.label,
    required this.value,
    required this.onChange,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChange;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: value,
            onChanged: (v) => v != null ? onChange(v) : null,
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () => onChange(!value),
          child: ValueInfoText(label),
        ),
      ],
    );
  }
}
