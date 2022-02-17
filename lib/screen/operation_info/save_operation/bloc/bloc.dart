import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/bloc/status.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/domain/repository/operations_repository.dart';
import 'package:popper_mobile/models/operation/operation.dart';
import 'package:popper_mobile/models/operation/operation_type.dart';

part 'event.dart';
part 'state.dart';

@injectable
class OperationSaveBloc extends Bloc<OperationSaveEvent, OperationSaveState> {
  final OperationsRepository _repository;

  OperationSaveBloc(@factoryParam Operation? operation, this._repository)
      : super(SelectTypeState.initial(operation!)) {
    on<ChangeOperation>(onChangeOperation);
    on<Initialize>(onInitialize);
    on<SaveOperation>(onSaveOperation);
    on<CacheOperation>(onCacheOperation);

    add(Initialize());
  }

  Future<void> onInitialize(Initialize event, Emitter emit) async {
    final lastOperation = await _repository.getLastOperationType();
    add(ChangeOperation(lastOperation));
  }

  Future<void> onChangeOperation(ChangeOperation event, Emitter emit) async {
    final currentState = state as SelectTypeState;
    emit(currentState.changeType(event.operationType));
  }

  Future<void> onSaveOperation(SaveOperation event, Emitter emit) async {
    emit(state.startSave());
    final currentState = state as SaveProcessState;
    final result = await _repository.saveOperation(state.operation);
    emit(result.fold(
      (f) => currentState.error(f),
      (_) => currentState.success(),
    ));
  }

  Future<void> onCacheOperation(CacheOperation event, Emitter emit) async {
    emit(state.startCache());
    final currentState = state as CacheProcessState;
    final result = await _repository.cacheOperation(currentState.operation);

    emit(result.fold(
      (_) => currentState.error(),
      (_) => currentState.success(),
    ));
  }
}
