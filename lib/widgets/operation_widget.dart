import 'package:flutter/material.dart';
import 'package:popper_mobile/core/utils/date_utils.dart';
import 'package:popper_mobile/core/utils/typedefs.dart';
import 'package:popper_mobile/models/operation/operation.dart';
import 'package:popper_mobile/models/operation/operation_type.dart';

class OperationWidget extends StatelessWidget {
  final Operation operation;
  final FormattedDateTime formattedDate;
  final OperationCallback? onTap;
  final Widget trailing;

  OperationWidget({
    Key? key,
    required this.operation,
    required this.onTap,
    required this.trailing,
  })  : formattedDate = FormattedDateTime(operation.time),
        super(key: key);

  String get typeName => operation.type?.localizedName ?? 'Unknown';

  String get bobbinName {
    if (operation.bobbin.isUnknown) return 'Катшука: ${operation.bobbin.id}';
    return operation.bobbin.bobbinNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 90,
          color: operation.isSuccessful ? Colors.green : Colors.red,
        ),
        Expanded(
          child: Card(
            color: Colors.white10,
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            borderOnForeground: true,
            elevation: 0,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: ListTile(
              onTap: onTap != null ? () => onTap!(operation) : null,
              trailing: trailing,
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
            ),
          ),
        ),
      ],
    );
  }
}
