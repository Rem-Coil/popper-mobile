part of 'bloc.dart';

@immutable
class SavedOperationsState {
  final Status status;
  final Failure? mainFailure;
  final Failure? deleteFailure;
  final List<Operation> operations;

  SavedOperationsState({
    required this.status,
    required this.mainFailure,
    required this.operations,
    required this.deleteFailure,
  });

  factory SavedOperationsState.initial() {
    return SavedOperationsState(
      status: Status.initial,
      mainFailure: null,
      deleteFailure: null,
      operations: [],
    );
  }

  SavedOperationsState load() {
    return SavedOperationsState(
      status: Status.load,
      mainFailure: mainFailure,
      deleteFailure: null,
      operations: operations,
    );
  }

  SavedOperationsState operationsLoaded(List<Operation> operations) {
    return SavedOperationsState(
      status: Status.success,
      mainFailure: null,
      deleteFailure: null,
      operations: operations,
    );
  }

  SavedOperationsState loadError(Failure failure) {
    return SavedOperationsState(
      status: Status.error,
      mainFailure: failure,
      deleteFailure: null,
      operations: operations,
    );
  }

  SavedOperationsState deleteError(Failure failure) {
    return SavedOperationsState(
      status: Status.error,
      mainFailure: null,
      deleteFailure: failure,
      operations: operations,
    );
  }
}