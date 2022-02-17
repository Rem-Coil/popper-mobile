import 'package:flutter/material.dart';
import 'package:popper_mobile/core/utils/date_utils.dart';
import 'package:popper_mobile/models/operation/operation.dart';
import 'package:popper_mobile/models/operation/operation_type.dart';
import 'package:popper_mobile/screen/scanned_list/general/widgets/operations_list.dart';

class OperationWidget extends StatelessWidget {
  final Operation operation;
  final FormattedDateTime formattedDate;
  final OperationCallback onTap;
  final OperationCallback onDelete;

  OperationWidget({
    Key? key,
    required this.operation,
    required this.onTap,
    required this.onDelete,
  })  : formattedDate = FormattedDateTime(operation.time),
        super(key: key);

  String get typeName => operation.type?.localizedName ?? 'Unknown';

  String get bobbinName {
    if (operation.bobbin.isUnknown) return 'Катшука: ${operation.bobbin.id}';
    return operation.bobbin.bobbinNumber;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onTap(operation),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => onDelete(operation),
      ),
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
