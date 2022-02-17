import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/bloc/status.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/domain/cache/operations_cache.dart';
import 'package:popper_mobile/models/operation/operation.dart';

part 'event.dart';
part 'state.dart';

@injectable
class CachedOperationsBloc
    extends Bloc<CachedOperationsEvent, CachedOperationsState> {
  final OperationsCache _operationsCache;

  CachedOperationsBloc(this._operationsCache)
      : super(CachedOperationsState.initial()) {
    on<LoadOperations>(onLoadActions);
    on<DeleteOperation>(onDeleteCachedOperation);
  }

  Future<void> onLoadActions(LoadOperations event, Emitter emit) async {
    try {
      emit(state.load());
      final operations = await _operationsCache.getCachedOperation();

      operations.sort((a, b) => a.time.compareTo(b.time));
      final sortedOperations = operations.reversed.toList();

      emit(state.operationsLoaded(sortedOperations));
    } catch (e) {
      emit(state.loadError(CacheFailure()));
    }
  }

  Future<void> onDeleteCachedOperation(
    DeleteOperation event,
    Emitter emit,
  ) async {
    try {
      emit(state.load());
      final operation = event.operation;
      await _operationsCache.deleteCacheOperation(operation);
      final operations = List.of(state.operations)
          .where((o) => !operation.isEqualWithoutId(o))
          .toList();

      emit(state.operationsLoaded(operations));
    } catch (e) {
      emit(state.deleteError(CacheFailure()));
    }
  }
}
