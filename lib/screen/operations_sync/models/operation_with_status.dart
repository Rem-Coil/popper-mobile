import 'package:popper_mobile/models/operation/operation.dart';
import 'package:popper_mobile/screen/operations_sync/models/synchronization_status.dart';

class OperationWithStatus {
  final Operation operation;
  final SynchronizationStatus status;

  OperationWithStatus({required this.operation, required this.status});

  factory OperationWithStatus.fromOperation(Operation operation) {
    return OperationWithStatus(
      operation: operation,
      status: SynchronizationStatus.wait,
    );
  }
}
