import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/data/repository/batches_reposiotory.dart';
import 'package:popper_mobile/domain/models/kit/batch.dart';
import 'package:popper_mobile/domain/entities/full_kit_info.dart';
import 'package:popper_mobile/domain/models/kit/kit.dart';
import 'package:popper_mobile/domain/usecase/kits/get_full_kit_info_usecase.dart';

part 'event.dart';

part 'state.dart';

@injectable
class KitSelectionBloc extends Bloc<KitSelectionEvent, KitSelectionState> {
  KitSelectionBloc(this._getFullKitInfoUsecase, this._batchesRepository)
      : super(const LoadKitState()) {
    on<_Initialize>(_onInitialize);
    on<UpdateBatchSelection>(_onUpdateBatchSelection);
    on<UpdateKitSelection>(_onUpdateKitSelection);
    on<UpdateDeletedBatches>(_onUpdateDeletedBatches);

    add(const _Initialize());
  }

  final GetFullKitInfoUsecase _getFullKitInfoUsecase;
  final BatchesRepository _batchesRepository;
  final List<FullKitInfo> kits = [];
  final List<Batch> selected = [];
  final FullKitInfo deletedFromServer = FullKitInfo(
    kit: const Kit.deleted(),
    batches: [],
  );

  Future<void> _onInitialize(_Initialize event, Emitter emit) async {
    final cachedBatches = await _batchesRepository.getAllSaved();
    selected.addAll(cachedBatches);
    final kitInfo = await _getFullKitInfoUsecase();

    emit(kitInfo.fold(
      (f) => FailureKitSelectionState(f),
      (k) {
        kits.addAll(k);
        final allServerBatches = kits.expand((kit) => kit.batches);
        deletedFromServer.batches.addAll(selected.where((cachedBatch) =>
            allServerBatches
                .every((serverBatch) => serverBatch != cachedBatch)));
        return SaveKitSelectionState(
          kitList: kits,
          selectedBatches: selected,
          deletedBatches: deletedFromServer,
        );
      },
    ));
  }

  FutureOr<void> _onUpdateBatchSelection(
    UpdateBatchSelection event,
    Emitter<KitSelectionState> emit,
  ) {
    if (selected.contains(event.batch)) {
      selected.remove(event.batch);
      _batchesRepository.delete(event.batch);
    } else {
      selected.add(event.batch);
      _batchesRepository.cache(event.batch);
    }
    emit(SaveKitSelectionState(
      kitList: kits,
      selectedBatches: selected,
      deletedBatches: deletedFromServer,
    ));
  }

  FutureOr<void> _onUpdateKitSelection(
    UpdateKitSelection event,
    Emitter<KitSelectionState> emit,
  ) {
    if (event.selected == true) {
      selected.addAll(event.kit.batches);
      _batchesRepository.cacheAll(event.kit.batches);
    } else if (event.selected == false) {
      /// часть партии уже была выбрана
      selected.removeWhere((b) => event.kit.kit.id == b.kitId);
      selected.addAll(event.kit.batches);
      _batchesRepository.cacheAll(event.kit.batches);
    } else {
      _batchesRepository.deleteAll(
          selected.where((b) => event.kit.kit.id == b.kitId).toList());
      selected.removeWhere((b) => event.kit.kit.id == b.kitId);
    }
    emit(SaveKitSelectionState(
      kitList: kits,
      selectedBatches: selected,
      deletedBatches: deletedFromServer,
    ));
  }

  FutureOr<void> _onUpdateDeletedBatches(
    UpdateDeletedBatches event,
    Emitter<KitSelectionState> emit,
  ) async {
    final list = List<Batch>.from(event.batchesToDelete);     //TODO: Сомнительно но иначе не работает
    deletedFromServer.batches.removeWhere(
        (deletedBatch) => event.batchesToDelete.contains(deletedBatch));
    await _batchesRepository.deleteAll(list);
    selected.removeWhere((b) => list.contains(b));
    emit(SaveKitSelectionState(
      kitList: kits,
      selectedBatches: selected,
      deletedBatches: deletedFromServer,
    ));
  }
}
