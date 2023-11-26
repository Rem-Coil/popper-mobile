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
  });

  final List<FullKitInfo> kitList;
  final List<Batch> selectedBatches;
}

class FailureKitSelectionState implements KitSelectionState {
  final Failure failure;

  FailureKitSelectionState(this.failure);
}
