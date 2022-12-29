import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/domain/models/bobbin/bobbin.dart';
import 'package:popper_mobile/domain/models/history/type_history.dart';
import 'package:popper_mobile/domain/usecase/operations/operation_history_usecase.dart';

part 'event.dart';

part 'state.dart';

@injectable
class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc(this._historyUsecase) : super(const LoadHistoryState()) {
    on<GetHistory>(onGettingHistory);
    on<ShowHistory>(onShowingHistory);
  }

  final BobbinHistoryUsecase _historyUsecase;

  Future<void> onGettingHistory(GetHistory event, Emitter emit) async {
    emit(const LoadHistoryState());
    final operations = await _historyUsecase(event.bobbin);
    emit(operations.fold(
      (f) => FailureHistoryState(f),
      (o) => SuccessHistoryState(o.map((e) => PanelItem(e)).toList()),
    ));
  }

  Future<void> onShowingHistory(ShowHistory event, Emitter emit) async {
    final s = state as SuccessHistoryState;
    emit(s.changeExpandedState(event.index));
  }
}

class PanelItem {
  PanelItem(this.history) : isExpanded = false;

  final TypeHistory history;
  bool isExpanded;

  void expand() {
    isExpanded = !isExpanded;
  }
}
