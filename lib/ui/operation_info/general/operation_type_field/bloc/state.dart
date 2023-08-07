part of 'bloc.dart';

@immutable
abstract class LoadTypesState {}

class NotLoadedState implements LoadTypesState {
  const NotLoadedState();
}

class LoadingState implements LoadTypesState {
  const LoadingState();
}

class LoadingFailureState implements LoadTypesState {
  const LoadingFailureState(this.failure);

  final Failure failure;
}

class TypesLoadedState implements LoadTypesState {
  const TypesLoadedState(this.types);

  final List<OperationType> types;
}