import 'package:flutter/material.dart';
import 'package:popper_mobile/core/utils/typedefs.dart';
import 'package:popper_mobile/models/operation/operation.dart';
import 'package:popper_mobile/screen/home/ui/pages/operations/ui/operation_item.dart';

class OperationsList extends StatelessWidget {
  final List<Operation> operations;
  final OperationCallback? onTap;

  const OperationsList({
    Key? key,
    required this.operations,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 16),
      child: ListView.separated(
        separatorBuilder: (context, _) => const Divider(color: Colors.grey),
        itemCount: operations.length,
        itemBuilder: (context, i) {
          return OperationItem(
            operation: operations[i],
            onTap: onTap,
          );
        },
      ),
    );
  }
}
