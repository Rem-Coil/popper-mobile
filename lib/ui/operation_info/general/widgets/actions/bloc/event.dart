part of 'bloc.dart';

@immutable
abstract class OperationTasksEvent {}

class DefectBobbinEvent implements OperationTasksEvent {
  const DefectBobbinEvent(this.bobbin);

  final Bobbin bobbin;
}

class DeleteOperationEvent implements OperationTasksEvent {
  const DeleteOperationEvent(this.operation);

  final Operation operation;
}
