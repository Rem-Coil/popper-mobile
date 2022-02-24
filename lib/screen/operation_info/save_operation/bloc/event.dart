part of 'bloc.dart';

@immutable
abstract class OperationSaveEvent {}

class Initialize extends OperationSaveEvent {}

class ChangeOperation extends OperationSaveEvent {
  final OperationType? operationType;

  ChangeOperation(this.operationType);
}

class SaveOperation extends OperationSaveEvent {}

class RejectOperation extends OperationSaveEvent {}

class SuccessOperation extends OperationSaveEvent {}

class CacheOperation extends OperationSaveEvent {}
