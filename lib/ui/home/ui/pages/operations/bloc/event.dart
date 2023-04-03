part of 'bloc.dart';

@immutable
abstract class OperationsEvent {}

class UpdateEvent implements OperationsEvent {
  const UpdateEvent();
}
