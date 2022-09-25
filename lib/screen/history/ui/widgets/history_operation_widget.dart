import 'package:flutter/material.dart';
import 'package:popper_mobile/core/utils/date_utils.dart';
import 'package:popper_mobile/models/operation/operation.dart';

class HistoryOperationWidget extends StatelessWidget {
  final FullOperation operation;

  const HistoryOperationWidget({
    Key? key,
    required this.operation,
  }) : super(key: key);

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
            child: ListTile(
              title: Text(operation.operatorName),
              subtitle: Text(operation.time.formatted),
            ),
          ),
        ],
      ),
    );
  }
}
