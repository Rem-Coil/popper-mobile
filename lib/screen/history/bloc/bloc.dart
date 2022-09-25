import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/domain/repository/operations_repository.dart';
import 'package:popper_mobile/domain/usecase/operations/operation_history_usecase.dart';
import 'package:popper_mobile/models/bobbin/bobbin.dart';
import 'package:popper_mobile/models/operation/expansion_panel_item.dart';

part 'event.dart';

part 'state.dart';

@injectable
class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final OperationsRepository _operationsRepository;
  final OperationHistoryUsecase _usecase;

  HistoryBloc(
      @factoryParam Bobbin? bobbin, this._operationsRepository, this._usecase)
      : super(const LoadHistoryState()) {
    on<GetHistory>(onGettingHistory);
    on<ShowHistory>(onShowingHistory);
  }

  Future<void> onGettingHistory(GetHistory event, Emitter emit) async {
    emit(const LoadHistoryState());
    final operations = await _operationsRepository.getAll(event.bobbin);
    emit(operations.fold(
      (f) => FailureHistoryState(f),
      (operationsList) => SuccessHistoryState(_usecase(operationsList)),
    ));
  }

  Future<void> onShowingHistory(ShowHistory event, Emitter emit) async {
    final s = state as SuccessHistoryState;
    emit(s.changeExtendedState(event.index));
  }
}
