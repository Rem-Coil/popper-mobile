part of 'bloc.dart';

@immutable
abstract class OperationTasksEvent {}

class DefectBobbinEvent implements OperationTasksEvent {
  const DefectBobbinEvent(this.id);

  final int id;
}

class DeleteOperationEvent implements OperationTasksEvent {
  const DeleteOperationEvent(this.operation);

  final Operation operation;
}
