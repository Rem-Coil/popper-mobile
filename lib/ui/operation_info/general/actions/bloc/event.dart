part of 'bloc.dart';

@immutable
abstract class OperationTasksEvent {}

class DefectBobbinEvent implements OperationTasksEvent {
  const DefectBobbinEvent(this.productInfo);

  final ProductInfo productInfo;
}

class DeleteOperationEvent implements OperationTasksEvent {
  const DeleteOperationEvent(this.operation);

  final Operation operation;
}
