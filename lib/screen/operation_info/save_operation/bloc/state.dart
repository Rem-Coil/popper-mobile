part of 'bloc.dart';

@immutable
abstract class OperationSaveState {
  final Operation operation;

  bool get isCanSave => this is SelectTypeState && operation.type != null;

  OperationSaveState._({required this.operation});

  OperationSaveState startSave() {
    return SaveProcessState.load(operation);
  }

  OperationSaveState startCache() {
    return CacheProcessState.load(operation);
  }
}

class SelectTypeState extends OperationSaveState {
  SelectTypeState._({required Operation operation})
      : super._(operation: operation);

  factory SelectTypeState.initial(Operation action) {
    return SelectTypeState._(operation: action);
  }

  SelectTypeState changeType(OperationType? type) {
    return SelectTypeState._(operation: operation.changeType(type));
  }
}

class SaveProcessState extends OperationSaveState {
  final Status status;
  final Failure? failure;

  bool get isSaveError =>
      failure is NoInternetFailure || failure is ServerFailure;

  SaveProcessState._({
    required Operation operation,
    required this.status,
    required this.failure,
  }) : super._(operation: operation);

  SaveProcessState _copyWith({
    Status? status,
    Failure? failure,
  }) {
    return SaveProcessState._(
      operation: operation,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  factory SaveProcessState.load(Operation operation) {
    return SaveProcessState._(
      operation: operation,
      status: Status.load,
      failure: null,
    );
  }

  SaveProcessState error(Failure failure) {
    return _copyWith(status: Status.error, failure: failure);
  }

  SaveProcessState success() {
    return _copyWith(status: Status.success);
  }
}

class CacheProcessState extends OperationSaveState {
  final Status status;

  CacheProcessState._({
    required Operation operation,
    required this.status,
  }) : super._(operation: operation);

  CacheProcessState _copyWith({
    Status? status,
  }) {
    return CacheProcessState._(
      operation: operation,
      status: status ?? this.status,
    );
  }

  factory CacheProcessState.load(Operation operation) {
    return CacheProcessState._(operation: operation, status: Status.load);
  }

  CacheProcessState error() {
    return _copyWith(status: Status.error);
  }

  CacheProcessState success() {
    return _copyWith(status: Status.success);
  }
}
