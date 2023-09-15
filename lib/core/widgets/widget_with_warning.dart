import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popper_mobile/core/widgets/dialogs/warning_dialog.dart';

class WidgetWithWarning extends StatelessWidget {
  const WidgetWithWarning({
    Key? key,
    required this.child,
    this.warningTitle,
    this.warningMessage,
  }) : super(key: key);

  final Widget child;
  final String? warningTitle;
  final String? warningMessage;

  Widget get _label {
    return Row(
      children: [
        Expanded(child: child),
        const SizedBox(width: 5),
        const Icon(Icons.warning_rounded, color: Colors.red),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (warningTitle != null) {
      return GestureDetector(
        onTap: () {
          showCupertinoDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return WarningDialog(
                title: warningTitle!,
                message: warningMessage,
              );
            },
          );
        },
        child: _label,
      );
    }

    return _label;
  }
}
