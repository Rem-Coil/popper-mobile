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

  factory SaveKitSelectionState.withDeletedBatches(
      List<FullKitInfo> kitList, List<Batch> selectedBatches) {
    final kitListCopy = List<FullKitInfo>.from(kitList);
    final selectedBatchesCopy = List<Batch>.from(selectedBatches);

    final allServerBatches = kitListCopy.expand((kit) => kit.batches);
    final onlyCachedBatches = selectedBatchesCopy
        .where((cachedBatch) => !allServerBatches.contains(cachedBatch))
        .toList();

    final deleted =
        FullKitInfo(kit: const Kit.deleted(), batches: onlyCachedBatches);

    return SaveKitSelectionState(
      kitList: kitList,
      selectedBatches: selectedBatches,
      deletedBatches: deleted,
    );
  }
}

class FailureKitSelectionState implements KitSelectionState {
  final Failure failure;

  FailureKitSelectionState(this.failure);
}
