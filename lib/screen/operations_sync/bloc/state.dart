part of 'bloc.dart';

@immutable
class OperationSyncState {
  final List<OperationWithStatus> operations;

  const OperationSyncState({required this.operations});

  bool get isSyncEnd {
    final statuses = operations.map((o) => o.status).toSet();
    return !statuses.contains(SynchronizationStatus.load) &&
        !statuses.contains(SynchronizationStatus.wait);
  }

  factory OperationSyncState.initial(List<Operation> operations) {
    return OperationSyncState(
      operations: List.of(operations)
          .map((o) => OperationWithStatus.waiting(o))
          .toList(),
    );
  }

  OperationSyncState copyWithOperation(
      int index, OperationWithStatus operation) {
    final updatedOperations = List.of(operations);
    updatedOperations[index] = operation;
    return OperationSyncState(operations: updatedOperations);
  }

  OperationSyncState operationLoad(int operationIndex) => copyWithOperation(
        operationIndex,
        OperationWithStatus.loading(operations[operationIndex].operation),
      );

  OperationSyncState operationSuccess(int operationIndex) => copyWithOperation(
        operationIndex,
        OperationWithStatus.success(operations[operationIndex].operation),
      );

  OperationSyncState operationError(int operationIndex, Failure failure) =>
      copyWithOperation(
        operationIndex,
        OperationWithStatus.error(
            operations[operationIndex].operation, failure),
      );
}
