part of 'bloc.dart';

@immutable
class CachedOperationsState {
  final Status status;
  final Failure? mainFailure;
  final Failure? deleteFailure;
  final List<Operation> operations;

  CachedOperationsState({
    required this.status,
    required this.mainFailure,
    required this.operations,
    required this.deleteFailure,
  });

  factory CachedOperationsState.initial() {
    return CachedOperationsState(
      status: Status.initial,
      mainFailure: null,
      deleteFailure: null,
      operations: [],
    );
  }

  CachedOperationsState load() {
    return CachedOperationsState(
      status: Status.load,
      mainFailure: mainFailure,
      deleteFailure: null,
      operations: operations,
    );
  }

  CachedOperationsState operationsLoaded(List<Operation> operations) {
    return CachedOperationsState(
      status: Status.success,
      mainFailure: null,
      deleteFailure: null,
      operations: operations,
    );
  }

  CachedOperationsState loadError(Failure failure) {
    return CachedOperationsState(
      status: Status.error,
      mainFailure: failure,
      deleteFailure: null,
      operations: operations,
    );
  }

  CachedOperationsState deleteError(Failure failure) {
    return CachedOperationsState(
      status: Status.error,
      mainFailure: null,
      deleteFailure: failure,
      operations: operations,
    );
  }
}
