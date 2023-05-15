import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/domain/models/history/history.dart';
import 'package:popper_mobile/domain/models/product/product_info.dart';
import 'package:popper_mobile/domain/usecase/history/get_history_by_product_usecase.dart';

part 'event.dart';

part 'state.dart';

@injectable
class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc(this._getHistory) : super(const LoadHistoryState()) {
    on<GetHistory>(onGettingHistory);
  }

  final GetHistoryByProductUsecase _getHistory;

  Future<void> onGettingHistory(GetHistory event, Emitter emit) async {
    emit(const LoadHistoryState());
    final operations = await _getHistory(event.product.id);
    emit(operations.fold(
      (f) => FailureHistoryState(f),
      (h) => SuccessHistoryState(h),
    ));
  }
}
