import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popper_mobile/screen/scanned_info/ui/widgets/scanned_info_text.dart';
import 'package:popper_mobile/widgets/dialogs/warning_dialog.dart';

class ScannedInfoWarning extends StatelessWidget {
  final String text;

  const ScannedInfoWarning(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCupertinoDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return WarningDialog(
              title: 'Данные о катушке не были загружены',
              message: 'Произошла ошибка загрзки информации о катушке. '
                  'Проверьте подключение к интернету или повторите позже',
            );
          },
        );
      },
      child: Row(
        children: [
          ScannedInfoText(text),
          SizedBox(width: 5),
          Icon(Icons.warning_rounded, color: Colors.red),
        ],
      ),
    );
  }
}
