part of 'bloc.dart';

@immutable
abstract class OperationUpdateState {
  final Operation operation;
  final OperationType lastType;

  bool get isCanSave =>
      this is SelectTypeState &&
      operation.type != null &&
      operation.type != lastType;

  const OperationUpdateState._(
      {required this.operation, required this.lastType});

  OperationUpdateState update() {
    return UpdateProcessState.load(this);
  }
}

class SelectTypeState extends OperationUpdateState {
  const SelectTypeState._({
    required Operation operation,
    required OperationType type,
  }) : super._(operation: operation, lastType: type);

  factory SelectTypeState.initial(Operation operation) {
    return SelectTypeState._(operation: operation, type: operation.type!);
  }

  SelectTypeState changeType(OperationType? type) {
    return SelectTypeState._(
      operation: operation.changeType(type),
      type: lastType,
    );
  }
}

class UpdateProcessState extends OperationUpdateState {
  final Status status;
  final Failure? failure;

  const UpdateProcessState._({
    required Operation operation,
    required OperationType type,
    required this.status,
    required this.failure,
  }) : super._(operation: operation, lastType: type);

  UpdateProcessState _copyWith({
    Status? status,
    Failure? failure,
  }) {
    return UpdateProcessState._(
      operation: operation,
      type: lastType,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  factory UpdateProcessState.load(OperationUpdateState lastState) {
    return UpdateProcessState._(
      operation: lastState.operation,
      type: lastState.lastType,
      status: Status.load,
      failure: null,
    );
  }

  UpdateProcessState error(Failure failure) {
    return _copyWith(status: Status.error, failure: failure);
  }

  UpdateProcessState success() {
    return _copyWith(status: Status.success);
  }
}
