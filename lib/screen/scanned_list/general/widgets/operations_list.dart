import 'package:flutter/material.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/core/utils/typedefs.dart';
import 'package:popper_mobile/models/operation/operation.dart';
import 'package:popper_mobile/widgets/center_text_with_image.dart';
import 'package:popper_mobile/widgets/operation_widget.dart';

class OperationsList extends StatelessWidget {
  final Failure? failure;
  final List<Operation> operations;
  final OperationCallback onTap;
  final OperationCallback onDelete;

  const OperationsList({
    Key? key,
    required this.failure,
    required this.operations,
    required this.onTap,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (failure != null) {
      return CenterTextWithImage(
        image: 'assets/images/load_exception.png',
        title: failure!.message,
      );
    }

    if (operations.isEmpty) {
      return CenterTextWithImage(
        image: 'assets/images/worker.png',
        title: 'Тут пока ничего нет',
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: operations.length,
        itemBuilder: (context, i) {
          return OperationWidget(
            operation: operations[i],
            onTap: onTap,
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => onDelete(operations[i]),
            ),
          );
        },
      ),
    );
  }
}
