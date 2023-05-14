import 'package:flutter/material.dart';
import 'package:popper_mobile/core/widgets/widget_with_warning.dart';
import 'package:popper_mobile/ui/operation_info/general/fields/value_info_text.dart';

class BobbinDefectedWarning extends StatelessWidget {
  const BobbinDefectedWarning(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return WidgetWithWarning(
      warningTitle: 'Данная катушка забракована',
      warningMessage: 'Данная катушка забракована. '
          'По ней нельзя сохранять операции',
      child: ValueInfoText(text),
    );
  }
}
