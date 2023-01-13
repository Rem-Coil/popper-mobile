import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popper_mobile/ui/operation_info/general/widgets/fields/value_info_text.dart';
import 'package:popper_mobile/core/widgets/widget_with_warning.dart';

class EntityInfoNotLoadedWarning extends StatelessWidget {
  const EntityInfoNotLoadedWarning(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return WidgetWithWarning(
      warningTitle: 'Данные не были загружены',
      warningMessage: 'Произошла ошибка загрзки подробной информации. '
          'Проверьте подключение к интернету или повторите позже',
      child: ValueInfoText(text),
    );
  }
}
