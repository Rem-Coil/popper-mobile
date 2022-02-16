part of 'bloc.dart';

@immutable
abstract class OperationsListState {
  final OperationStatus status;

  OperationsListState(this.status);
}

class LoadingState extends OperationsListState {
  LoadingState(OperationStatus status) : super(status);
}

class ActionsList extends OperationsListState {
  final List<Operation> operations;

  ActionsList(this.operations, OperationStatus status) : super(status);
}

class ErrorState extends OperationsListState {
  final Failure failure;

  ErrorState(this.failure, OperationStatus status) : super(status);
}
