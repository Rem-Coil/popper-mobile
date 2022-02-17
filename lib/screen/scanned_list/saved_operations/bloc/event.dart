part of 'bloc.dart';

@immutable
class SavedOperationsEvent {}

class LoadOperations extends SavedOperationsEvent {}

class DeleteOperation extends SavedOperationsEvent {
  final Operation operation;

  DeleteOperation(this.operation);
}
