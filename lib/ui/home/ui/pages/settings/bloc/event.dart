part of 'bloc.dart';

@immutable
abstract class SynchronizationEvent {}

class StartSynchronizationEvent implements SynchronizationEvent {
  const StartSynchronizationEvent();
}
