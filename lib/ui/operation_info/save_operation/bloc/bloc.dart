import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/domain/models/operation/modify_event.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';
import 'package:popper_mobile/domain/models/product/product_code_data.dart';
import 'package:popper_mobile/domain/usecase/operations/cache_operation_usecase.dart';
import 'package:popper_mobile/domain/usecase/operations/create_operation_usecase.dart';
import 'package:popper_mobile/domain/usecase/operations/modify_operation_usecase.dart';
import 'package:popper_mobile/domain/usecase/operations/save_operation_usecase.dart';

part 'event.dart';

part 'state.dart';

@injectable
class OperationSaveBloc extends Bloc<OperationSaveEvent, OperationSaveState> {
  OperationSaveBloc(
    @factoryParam ProductCodeData? data,
    this._createOperation,
    this._saveOperation,
    this._cacheOperation,
    this._modifyOperation,
  ) : super(const FetchInfoState()) {
    _productData = data!;

    on<_Initialize>(_onInitialize);

    on<ModifyOperationEvent>(_onChangeOperation);
    on<ChooseOperationEvent>(_onChooseOperationEvent);

    on<SaveOperation>(_onSaveOperation);
    on<CacheOperation>(_onCacheOperation);

    add(const _Initialize());
  }

  late final ProductCodeData _productData;

  final CreateOperationUseCase _createOperation;
  final SaveOperationUsecase _saveOperation;
  final CacheOperationUsecase _cacheOperation;
  final ModifyOperationUsecase _modifyOperation;

  Future<void> _onInitialize(_Initialize event, Emitter emit) async {
    final operation = await _createOperation(_productData);
    operation.fold(
      (_) => emit(const ChooseOperationState()),
      (operation) => emit(ModifyOperationState(operation: operation)),
    );
  }

  Future<void> _onChangeOperation(
    ModifyOperationEvent event,
    Emitter emit,
  ) async {
    final operation = (state as WithOperationState).operation;
    final modifiedOperation = _modifyOperation(operation, event.event);
    emit(ModifyOperationState(operation: modifiedOperation));
  }

  Future<void> _onSaveOperation(SaveOperation event, Emitter emit) async {
    final operation = (state as WithOperationState).operation;
    emit(SaveProcessState(operation: operation));

    final result = await _saveOperation(operation);

    emit(result.fold(
      (f) => f.isNetworkFailure
          ? CanCacheState(operation: operation)
          : FailedState(f),
      (_) => const SuccessState('Операция успешно сохранена'),
    ));
  }

  Future<void> _onCacheOperation(CacheOperation event, Emitter emit) async {
    final operation = (state as WithOperationState).operation;
    emit(CacheProcessState(operation: operation));

    final result = await _cacheOperation(operation);

    emit(result.fold(
      (f) => FailedState(f),
      (_) => const SuccessState('Операция успешно сохранена в кеш'),
    ));
  }

  Future<void> _onChooseOperationEvent(
    ChooseOperationEvent event,
    Emitter<OperationSaveState> emit,
  ) async {
    final operation = await _createOperation(_productData, operationType: '');
    operation.fold(
      (_) => emit(const ChooseOperationState()),
      (operation) => emit(ModifyOperationState(operation: operation)),
    );
  }
}
