part of 'bloc.dart';

@immutable
abstract class OperationsEvent {}

class InitialEvent implements OperationsEvent {
  const InitialEvent();
}

class _UpdateEvent implements OperationsEvent {
  const _UpdateEvent();
}
