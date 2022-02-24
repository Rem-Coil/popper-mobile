import 'package:flutter/material.dart';
import 'package:popper_mobile/models/operation/operation.dart';
import 'package:popper_mobile/screen/operations_sync/models/synchronization_status.dart';
import 'package:popper_mobile/widgets/circular_loader.dart';
import 'package:popper_mobile/widgets/operation_widget.dart';

class SynchronizationOperation extends StatelessWidget {
  final Operation operation;
  final SynchronizationStatus status;

  const SynchronizationOperation({
    Key? key,
    required this.operation,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OperationWidget(
      trailing: _icon,
      operation: operation,
      onTap: null,
    );
  }

  String get _subtitle {
    switch (status) {
      case SynchronizationStatus.wait:
        return 'Wait';
      case SynchronizationStatus.load:
        return 'Load';
      case SynchronizationStatus.success:
        return 'Success';
      case SynchronizationStatus.error:
        return 'Error';
    }
  }

  Widget get _icon {
    switch (status) {
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
