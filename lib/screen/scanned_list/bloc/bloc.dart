import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/data/cache/operations_cache.dart';
import 'package:popper_mobile/models/operation/operation.dart';
import 'package:popper_mobile/screen/scanned_list/models/operation_status.dart';

part 'event.dart';

part 'state.dart';

@injectable
class OperationListBloc extends Bloc<OperationsListEvent, OperationsListState> {
  final OperationsCache _operationsCache;

  OperationListBloc(
      @factoryParam OperationStatus? status, this._operationsCache)
      : super(LoadingState(status!)) {
    on<LoadOperations>(onLoadActions);
  }

  Future<void> onLoadActions(LoadOperations event, Emitter emit) async {
    emit(LoadingState(state.status));
    try {
      final operations = state.status == OperationStatus.saved
          ? await _operationsCache.getSavedOperation()
          : await _operationsCache.getCachedOperation();

      operations.sort((a, b) => a.time.compareTo(b.time));
      final sortedOperations = operations.reversed.toList();
      emit(ActionsList(sortedOperations, state.status));
    } catch (e) {
      emit(ErrorState(CacheFailure(), state.status));
    }
  }
}
