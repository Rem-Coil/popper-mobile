part of 'bloc.dart';

@immutable
class SplashState {}

class InitialState implements SplashState {
  const InitialState();
}

class BackgroundTaskState implements SplashState {
  const BackgroundTaskState(this.task);

  final String task;
}

class TasksEnd implements SplashState {
  const TasksEnd();
}
