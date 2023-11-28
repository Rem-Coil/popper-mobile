part of 'bloc.dart';

abstract class KitSelectionEvent {}

class _Initialize implements KitSelectionEvent {
  const _Initialize();
}

class UpdateBatchSelection implements KitSelectionEvent {
  UpdateBatchSelection({
    required this.batch,
  });

  final Batch batch;
}

class UpdateKitSelection implements KitSelectionEvent {
  UpdateKitSelection({
    required this.kit,
    required this.selected,
  });

  final FullKitInfo kit;
  final bool? selected;
}

class UpdateDeletedBatches implements KitSelectionEvent{
  const UpdateDeletedBatches({required this.batchesToDelete});

  final List<Batch> batchesToDelete;
}
