import 'package:flutter/material.dart';
import 'package:popper_mobile/core/utils/context_utils.dart';
import 'package:popper_mobile/core/utils/date_utils.dart';
import 'package:popper_mobile/models/operation/operation.dart';
import 'package:popper_mobile/models/operation/operation_type.dart';
import 'package:popper_mobile/screen/scanned_info/ui/scanned_info_screen.dart';

class OperationWidget extends StatelessWidget {
  final Operation operation;
  final FormattedDateTime formattedDate;

  OperationWidget({Key? key, required this.operation})
      : formattedDate = FormattedDateTime(operation.time),
        super(key: key);

  String get typeName => operation.type?.localizedName ?? 'Unknown';

  String get bobbinName {
    if (operation.bobbin.isUnknown) return 'Катшука: ${operation.bobbin.id}';
    return operation.bobbin.bobbinNumber;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => context.push(ScannedInfoScreen.route, args: operation),
      trailing: Icon(Icons.delete),
      title: Text(bobbinName),
      isThreeLine: true,
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 4),
          Text(typeName),
          SizedBox(height: 2),
          Text(formattedDate.formattedDate),
        ],
      ),
    );
  }
}
