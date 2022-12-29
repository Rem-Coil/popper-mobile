part of 'bloc.dart';

@immutable
abstract class OperationSaveState {}

class FetchInfoState implements OperationSaveState {
  const FetchInfoState(this.entity);

  final ScannedEntity entity;
}

abstract class WithOperationState implements OperationSaveState {
  const WithOperationState({required this.operation});

  final Operation operation;

  bool get isCanSave => operation.type != null;
}

class SelectTypeState extends WithOperationState {
  const SelectTypeState({required super.operation});
}

class SaveProcessState extends WithOperationState {
  const SaveProcessState({required super.operation});
}

class CanCacheState extends WithOperationState {
  const CanCacheState({required super.operation});
}

class CacheProcessState extends WithOperationState {
  const CacheProcessState({required super.operation});
}

class FailedState implements OperationSaveState {
  const FailedState(this.failure);

  final Failure failure;
}

class SuccessState implements OperationSaveState {
  const SuccessState(this.message);

  final String message;
}
