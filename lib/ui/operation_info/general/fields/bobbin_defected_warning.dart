import 'package:flutter/material.dart';
import 'package:popper_mobile/core/widgets/widget_with_warning.dart';
import 'package:popper_mobile/ui/operation_info/general/fields/value_info_text.dart';

class ProductDefectedWarning extends StatelessWidget {
  const ProductDefectedWarning(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return WidgetWithWarning(
      warningTitle: 'Данное изделие забраковано',
      warningMessage: 'Данное изделие забраковано. '
          'По нему нельзя сохранять операции',
      child: ValueInfoText(text),
    );
  }
}
