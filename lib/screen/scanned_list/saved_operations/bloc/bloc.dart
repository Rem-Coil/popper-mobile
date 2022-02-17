import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/bloc/status.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/domain/cache/operations_cache.dart';
import 'package:popper_mobile/domain/repository/operations_repository.dart';
import 'package:popper_mobile/models/operation/operation.dart';

part 'event.dart';
part 'state.dart';

@injectable
class SavedOperationsBloc
    extends Bloc<SavedOperationsEvent, SavedOperationsState> {
  final OperationsCache _operationsCache;
  final OperationsRepository _operationsRepository;

  SavedOperationsBloc(
    this._operationsCache,
    this._operationsRepository,
  ) : super(SavedOperationsState.initial()) {
    on<LoadOperations>(onLoadActions);
    on<DeleteOperation>(onDeleteOperation);
  }

  Future<void> onLoadActions(LoadOperations event, Emitter emit) async {
    emit(state.load());
    try {
      final operations = await _operationsCache.getSavedOperation();

      operations.sort((a, b) => a.time.compareTo(b.time));
      final sortedOperations = operations.reversed.toList();

      emit(state.operationsLoaded(sortedOperations));
    } catch (e) {
      emit(state.loadError(CacheFailure()));
    }
  }

  Future<void> onDeleteOperation(DeleteOperation event, Emitter emit) async {
    emit(state.load());
    final operation = event.operation;
    final result = await _operationsRepository.deleteSavedOperation(operation);
    emit(result.fold((f) => state.deleteError(f), (_) {
      final operations =
          List.of(state.operations).where((o) => o.id != operation.id).toList();
      return state.operationsLoaded(operations);
    }));
  }
}
