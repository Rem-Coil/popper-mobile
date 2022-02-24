import 'package:flutter/material.dart';
import 'package:popper_mobile/screen/operations_sync/models/operation_with_status.dart';
import 'package:popper_mobile/screen/operations_sync/models/synchronization_status.dart';
import 'package:popper_mobile/widgets/circular_loader.dart';
import 'package:popper_mobile/widgets/operation_widget.dart';

class SynchronizationOperation extends StatelessWidget {
  final OperationWithStatus operation;

  const SynchronizationOperation({
    Key? key,
    required this.operation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OperationWidget(
      trailing: Container(
        width: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Text(
                _subtitle,
                textAlign: TextAlign.end,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 8),
            _icon,
          ],
        ),
      ),
      operation: operation.operation,
      onTap: null,
    );
  }

  String get _subtitle {
    switch (operation.status) {
      case SynchronizationStatus.wait:
        return 'В очереди';
      case SynchronizationStatus.load:
        return 'Синхронизация';
      case SynchronizationStatus.success:
        return 'Успешно';
      case SynchronizationStatus.error:
        return operation.failure!.message;
    }
  }

  Widget get _icon {
    switch (operation.status) {
      case SynchronizationStatus.wait:
        return Icon(Icons.file_upload_outlined, color: Colors.grey);
      case SynchronizationStatus.load:
        return CircularLoader(size: 20, strokeWidth: 2);
      case SynchronizationStatus.success:
        return Icon(Icons.done, color: Colors.green);
      case SynchronizationStatus.error:
        return Icon(Icons.error, color: Colors.red);
    }
  }
}
