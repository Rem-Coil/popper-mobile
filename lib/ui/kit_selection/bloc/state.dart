part of 'bloc.dart';

@immutable
abstract class KitSelectionState {}

class LoadKitState implements KitSelectionState {
  const LoadKitState();
}

class SaveKitSelectionState implements KitSelectionState {
  const SaveKitSelectionState({
    required this.kitList,
    required this.selectedBatches,
    required this.deletedBatches,
  });

  final List<FullKitInfo> kitList;
  final List<Batch> selectedBatches;
  final FullKitInfo deletedBatches;
}

class FailureKitSelectionState implements KitSelectionState {
  final Failure failure;

  FailureKitSelectionState(this.failure);
}

class DeletedKitSelectedState implements KitSelectionState {
  const DeletedKitSelectedState();
}
