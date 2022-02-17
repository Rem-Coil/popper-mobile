part of 'bloc.dart';

@immutable
abstract class OperationUpdateEvent {}

class Initialize extends OperationUpdateEvent {}

class ChangeOperation extends OperationUpdateEvent {
  final OperationType? operationType;

  ChangeOperation(this.operationType);
}

class UpdateOperation extends OperationUpdateEvent {}
