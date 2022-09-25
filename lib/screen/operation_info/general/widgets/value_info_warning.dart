import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popper_mobile/screen/operation_info/general/widgets/value_info_text.dart';
import 'package:popper_mobile/widgets/widget_with_warning.dart';

class ValueInfoWarning extends StatelessWidget {
  final String text;

  const ValueInfoWarning(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WidgetWithWarning(
      warningTitle: 'Данные о катушке не были загружены',
      warningMessage: 'Произошла ошибка загрзки информации о катушке. '
          'Проверьте подключение к интернету или повторите позже',
      child: ValueInfoText(text),
    );
  }
}
