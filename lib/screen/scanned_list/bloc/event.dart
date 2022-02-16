part of 'bloc.dart';

@immutable
class OperationsListEvent {}

class LoadOperations extends OperationsListEvent {
  final OperationStatus status;

  LoadOperations(this.status);
}
