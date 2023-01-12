part of 'bloc.dart';

@immutable
abstract class DefectingState {}

class DefectingInitialState implements DefectingState {
  const DefectingInitialState();
}

class DefectingStartState implements DefectingState {
  const DefectingStartState();
}

class DefectingFailedState implements DefectingState {
  const DefectingFailedState(this.failure);

  final Failure failure;
}

class DefectingEndState implements DefectingState {
  const DefectingEndState();
}
