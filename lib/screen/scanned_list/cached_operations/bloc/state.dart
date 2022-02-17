part of 'bloc.dart';

@immutable
abstract class CachedOperationsState {}

class LoadingState extends CachedOperationsState {}

class OperationsLoaded extends CachedOperationsState {
  final List<Operation> operations;

  OperationsLoaded(this.operations) : super();
}

class ErrorState extends CachedOperationsState {
  final Failure failure;

  ErrorState(this.failure) : super();
}
