import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/models/operation/operation.dart';
import 'package:popper_mobile/screen/operations_sync/models/synchronization_status.dart';

class OperationWithStatus {
  final Operation operation;
  final SynchronizationStatus status;
  final Failure? failure;

  OperationWithStatus({
    required this.operation,
    required this.status,
    required this.failure,
  });

  factory OperationWithStatus.waiting(Operation operation) {
    return OperationWithStatus(
      operation: operation,
      status: SynchronizationStatus.wait,
      failure: null,
    );
  }

  factory OperationWithStatus.loading(Operation operation) {
    return OperationWithStatus(
      operation: operation,
      status: SynchronizationStatus.load,
      failure: null,
    );
  }

  factory OperationWithStatus.success(Operation operation) {
    return OperationWithStatus(
      operation: operation,
      status: SynchronizationStatus.success,
      failure: null,
    );
  }

  factory OperationWithStatus.error(Operation operation, Failure failure) {
    return OperationWithStatus(
      operation: operation,
      status: SynchronizationStatus.error,
      failure: failure,
    );
  }
}
