part of 'bloc.dart';

@immutable
abstract class SavedOperationsState {}

class LoadingState extends SavedOperationsState {}

class OperationsLoaded extends SavedOperationsState {
  final List<Operation> operations;

  OperationsLoaded(this.operations) : super();
}

class ErrorState extends SavedOperationsState {
  final Failure failure;

  ErrorState(this.failure) : super();
}
