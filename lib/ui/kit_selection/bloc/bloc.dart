import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/domain/models/kit/batch.dart';
import 'package:popper_mobile/domain/models/kit/full_kit_info.dart';

part 'event.dart';

part 'state.dart';

@injectable
class KitSelectionBloc extends Bloc<KitSelectionEvent, KitSelectionState> {
  KitSelectionBloc() : super(const LoadKitState()) {
    on<_Initialize>(_onInitialize);
    on<UpdateBatchSelection>(_onUpdateBatchSelection);
    on<UpdateKitSelection>(_onUpdateKitSelection);

    add(const _Initialize());
  }

  final List<FullKitInfo> kits = [];
  final List<Batch> selected = [
    Batch(batchNumber: 1, id: 1, kitId: 0),
    Batch(batchNumber: 2, id: 2, kitId: 0),
    Batch(batchNumber: 3, id: 3, kitId: 0),
  ];

  Future<void> _onInitialize(_Initialize event, Emitter emit) async {
    for (int j = 0; j < 3; j++) {
      List<Batch> list = [];
      for (int i = 1; i < 6; i++) {
        list.add(Batch(batchNumber: (j * 5) + i, id: (j * 5) + i, kitId: j));
      }
      kits.add(FullKitInfo(kitId: j, kitName: 'Kit $j', batches: list));
    }

    emit(SaveKitSelectionState(kitList: kits, selectedBatches: selected));
  }

  FutureOr<void> _onUpdateBatchSelection(
    UpdateBatchSelection event,
    Emitter<KitSelectionState> emit,
  ) {
    if (selected.contains(event.batch)) {
      selected.remove(event.batch);
    } else {
      selected.add(event.batch);
    }
    emit(SaveKitSelectionState(kitList: kits, selectedBatches: selected));
  }

  FutureOr<void> _onUpdateKitSelection(
      UpdateKitSelection event,
    Emitter<KitSelectionState> emit,
  ) {
    if (event.selected == true) {
      selected.addAll(event.kit.batches);
    } else if (event.selected == false) { // часть партии уже была выбрана
      selected.removeWhere((b) => event.kit.kitId == b.kitId);
      selected.addAll(event.kit.batches);
    } else {
      selected.removeWhere((b) => event.kit.kitId == b.kitId);
    }
    emit(SaveKitSelectionState(kitList: kits, selectedBatches: selected));
  }
}
