import 'package:flutter/material.dart';
import 'package:popper_mobile/core/utils/date_utils.dart';
import 'package:popper_mobile/models/operation/operation.dart';

class HistoryOperationWidget extends StatelessWidget {
  final FullOperation operation;
  final FormattedDateTime formattedDate;

  HistoryOperationWidget({
    Key? key,
    required this.operation,
  })  : formattedDate = FormattedDateTime(operation.time),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 60,
            color: operation.isSuccessful ? Colors.green : Colors.red,
          ),
          Expanded(
            child: Card(
              color: Colors.white10,
              shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              borderOnForeground: true,
              elevation: 0,
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: ListTile(
                title: Text(operation.operatorName),
                subtitle: Text(formattedDate.formattedDate),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
