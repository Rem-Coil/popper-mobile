part of 'bloc.dart';

@immutable
abstract class SynchronizationState {}

class SynchronizationInitialState implements SynchronizationState {
  const SynchronizationInitialState();
}

class SynchronizationStartState implements SynchronizationState {
  const SynchronizationStartState();
}

class SynchronizationFailedState implements SynchronizationState {
  const SynchronizationFailedState(this.failure);

  final Failure failure;
}

class SynchronizationEndState implements SynchronizationState {
  const SynchronizationEndState();
}
