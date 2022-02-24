part of 'bloc.dart';

@immutable
class OperationSyncState {
  final List<OperationWithStatus> operations;

  OperationSyncState({required this.operations});

  factory OperationSyncState.initial(List<Operation> operations) {
    return OperationSyncState(
      operations: List.of(operations)
          .map((o) => OperationWithStatus.fromOperation(o))
          .toList(),
    );
  }
}
