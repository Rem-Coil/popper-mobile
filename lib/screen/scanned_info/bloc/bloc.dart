import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:popper_mobile/core/bloc/status.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/data/repository/operations_repository.dart';
import 'package:popper_mobile/models/operation/operation.dart';
import 'package:popper_mobile/models/operation/operation_type.dart';

part 'event.dart';

part 'state.dart';

@injectable
class OperationSaveBloc extends Bloc<OperationSaveEvent, OperationSaveState> {
  final OperationRepository _operationsRepository;

  OperationSaveBloc(
    @factoryParam Operation? operation,
    this._operationsRepository,
  ) : super(SelectTypeState.initial(operation!)) {
    on<ChangeOperation>(onChangeOperation);
    on<Initialize>(onInitialize);
    on<SaveOperation>(onSaveOperation);
    on<CacheOperation>(onCacheOperation);

    add(Initialize());
  }

  Future<void> onInitialize(Initialize event, Emitter emit) async {
    if (!state.isOperationSaved) {
      final lastOperation = await _operationsRepository.getLastOperationType();
      add(ChangeOperation(lastOperation));
    }
  }

  Future<void> onChangeOperation(ChangeOperation event, Emitter emit) async {
    final currentState = state as SelectTypeState;
    emit(currentState.changeType(event.operationType));
  }

  Future<void> onSaveOperation(SaveOperation event, Emitter emit) async {
    emit(ProcessSaveState.load(state.operation));
    final currentState = state as ProcessSaveState;

    late Either<Failure, void> result;
    if (state.isOperationSaved) {
      result = await _operationsRepository.updateOperation(state.operation);
    } else {
      result = await _operationsRepository.saveOperation(state.operation);
    }

    emit(result.fold(
      (f) => currentState.error(f),
      (_) => currentState.success(),
    ));
  }

  Future<void> onCacheOperation(CacheOperation event, Emitter emit) async {
    emit(SaveInCacheState.load(state.operation));
    final currentState = state as SaveInCacheState;
    final result =
        await _operationsRepository.cacheOperation(currentState.operation);

    emit(result.fold(
      (_) => currentState.error(),
      (_) => currentState.success(),
    ));
  }
}
