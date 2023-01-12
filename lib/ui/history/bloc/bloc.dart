import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/domain/models/bobbin/bobbin.dart';
import 'package:popper_mobile/domain/models/history/bobbin_history.dart';
import 'package:popper_mobile/domain/usecase/operations/operation_history_usecase.dart';

part 'event.dart';
part 'state.dart';

@injectable
class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc(this._historyUsecase) : super(const LoadHistoryState()) {
    on<GetHistory>(onGettingHistory);
  }

  final BobbinHistoryUsecase _historyUsecase;

  Future<void> onGettingHistory(GetHistory event, Emitter emit) async {
    emit(const LoadHistoryState());
    final operations = await _historyUsecase(event.bobbin);
    emit(operations.fold(
      (f) => FailureHistoryState(f),
      (h) => SuccessHistoryState(h),
    ));
  }
}
