import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popper_mobile/screen/operation_info/general/widgets/value_info_text.dart';
import 'package:popper_mobile/widgets/dialogs/warning_dialog.dart';

class ValueInfoWarning extends StatelessWidget {
  final String text;

  const ValueInfoWarning(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCupertinoDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return const WarningDialog(
              title: 'Данные о катушке не были загружены',
              message: 'Произошла ошибка загрзки информации о катушке. '
                  'Проверьте подключение к интернету или повторите позже',
            );
          },
        );
      },
      child: Row(
        children: [
          ValueInfoText(text),
          const SizedBox(width: 5),
          const Icon(Icons.warning_rounded, color: Colors.red),
        ],
      ),
    );
  }
}
