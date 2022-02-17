part of 'bloc.dart';

@immutable
class CachedOperationsEvent {}

class LoadOperations extends CachedOperationsEvent {
  LoadOperations();
}

class DeleteOperation extends CachedOperationsEvent {
  final Operation operation;

  DeleteOperation(this.operation);
}
