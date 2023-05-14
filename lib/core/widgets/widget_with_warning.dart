import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popper_mobile/core/widgets/dialogs/warning_dialog.dart';

class WidgetWithWarning extends StatelessWidget {
  const WidgetWithWarning({
    Key? key,
    required this.child,
    required this.warningTitle,
    this.warningMessage,
  }) : super(key: key);

  final Widget child;
  final String warningTitle;
  final String? warningMessage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCupertinoDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return WarningDialog(
              title: warningTitle,
              message: warningMessage,
            );
          },
        );
      },
      child: Row(
        children: [
          child,
          const SizedBox(width: 5),
          const Icon(Icons.warning_rounded, color: Colors.red),
        ],
      ),
    );
  }
}
