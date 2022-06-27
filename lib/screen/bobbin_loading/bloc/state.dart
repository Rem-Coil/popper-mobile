part of 'bloc.dart';

class BobbinState {}

class BobbinLoadingState implements BobbinState {}

class BobbinSuccessState implements BobbinState {
  final Operation operation;

  const BobbinSuccessState(this.operation);
}
