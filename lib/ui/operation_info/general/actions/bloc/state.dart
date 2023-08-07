part of 'bloc.dart';

@immutable
abstract class OperationTasksState {}

class InitialState implements OperationTasksState {
  const InitialState();
}

class TaskStartState implements OperationTasksState {
  const TaskStartState();
}

class TaskFailedState implements OperationTasksState {
  const TaskFailedState(this.failure);

  final Failure failure;
}

class TaskEndState implements OperationTasksState {
  const TaskEndState();
}
