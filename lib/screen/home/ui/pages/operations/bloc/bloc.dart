import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/utils/date_utils.dart';
import 'package:popper_mobile/domain/cache/operations_cache.dart';
import 'package:popper_mobile/domain/usecase/operations/get_all_operations_usecase.dart';
import 'package:popper_mobile/models/operation/operation.dart';

part 'event.dart';

part 'state.dart';

@injectable
class OperationsBloc extends Bloc<OperationsEvent, OperationsState> {
  OperationsBloc(this._operationsCache, this._getAllOperations)
      : super(const OperationsState.initial()) {
    on<InitialEvent>(_onInitial);
    on<_UpdateEvent>(_onUpdate);
  }

  final OperationsCache _operationsCache;

  final GetAllOperationsUsecase _getAllOperations;

  void _onCacheChange() => add(const _UpdateEvent());

  Future<void> _onInitial(InitialEvent event, Emitter emit) async {
    await _operationsCache.unsubscribeToCompletedOperations(_onCacheChange);
    await _operationsCache.unsubscribeToCachedOperations(_onCacheChange);

    await _operationsCache.subscribeToCompletedOperations(_onCacheChange);
    await _operationsCache.subscribeToCachedOperations(_onCacheChange);

    add(const _UpdateEvent());
  }

  Future<void> _onUpdate(_UpdateEvent event, Emitter emit) async {
    final operations = await _getAllOperations();
    emit(OperationsState.update(operations));
  }
}
