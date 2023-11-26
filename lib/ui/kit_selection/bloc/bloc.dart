import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/domain/models/kit/batch.dart';
import 'package:popper_mobile/domain/entities/full_kit_info.dart';
import 'package:popper_mobile/domain/usecase/kits/get_full_kit_info_usecase.dart';

part 'event.dart';

part 'state.dart';

@injectable
class KitSelectionBloc extends Bloc<KitSelectionEvent, KitSelectionState> {
  KitSelectionBloc(this._getFullKitInfoUsecase) : super(const LoadKitState()) {
    on<_Initialize>(_onInitialize);
    on<UpdateBatchSelection>(_onUpdateBatchSelection);
    on<UpdateKitSelection>(_onUpdateKitSelection);

    add(const _Initialize());
  }

  final GetFullKitInfoUsecase _getFullKitInfoUsecase;
  final List<FullKitInfo> kits = [];
  final List<Batch> selected = [];

  Future<void> _onInitialize(_Initialize event, Emitter emit) async {
    final kitInfo = await _getFullKitInfoUsecase();

    emit(kitInfo.fold(
          (f) => FailureKitSelectionState(f),
          (k) {
        kits.addAll(k);
        return SaveKitSelectionState(kitList: k, selectedBatches: selected);
      },
    ));
  }

  FutureOr<void> _onUpdateBatchSelection(UpdateBatchSelection event,
      Emitter<KitSelectionState> emit,) {
    if (selected.contains(event.batch)) {
      selected.remove(event.batch);
    } else {
      selected.add(event.batch);
    }
    emit(SaveKitSelectionState(kitList: kits, selectedBatches: selected));
  }

  FutureOr<void> _onUpdateKitSelection(UpdateKitSelection event,
      Emitter<KitSelectionState> emit,) {
    if (event.selected == true) {
      selected.addAll(event.kit.batches);
    } else if (event.selected == false) {
      /// часть партии уже была выбрана
      selected.removeWhere((b) => event.kit.kit.id == b.kitId);
      selected.addAll(event.kit.batches);
    } else {
      selected.removeWhere((b) => event.kit.kit.id == b.kitId);
    }
    emit(SaveKitSelectionState(kitList: kits, selectedBatches: selected));
  }
}
