import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';
import 'package:popper_mobile/domain/models/operation/operation_type.dart';
import 'package:popper_mobile/domain/models/operation/scanned_entity.dart';
import 'package:popper_mobile/domain/repository/operations_repository.dart';
import 'package:popper_mobile/domain/usecase/operations/create_operation_usecase.dart';

part 'event.dart';
part 'state.dart';

@injectable
class OperationSaveBloc extends Bloc<OperationSaveEvent, OperationSaveState> {
  final CreateOperationUseCase _createOperation;
  final OperationsRepository _operationsRepository;

  OperationSaveBloc(
    @factoryParam ScannedEntity? e,
    this._createOperation,
    this._operationsRepository,
  ) : super(FetchInfoState(e!)) {
    on<_Initialize>(_onInitialize);

    on<ChangeOperation>(_onChangeOperation);

    on<SaveOperation>(_onSaveOperation);
    on<CacheOperation>(_onCacheOperation);

    add(_Initialize());
  }

  Future<void> _onInitialize(_Initialize event, Emitter emit) async {
    final entity = (state as FetchInfoState).entity;
    final operation = await _createOperation(entity);
    emit(SelectTypeState(operation: operation));
  }

  Future<void> _onChangeOperation(ChangeOperation event, Emitter emit) async {
    final operation = (state as WithOperationState).operation;
    final newOperation = operation.setType(event.operationType);
    emit(SelectTypeState(operation: newOperation));
  }

  Future<void> _onSaveOperation(SaveOperation event, Emitter emit) async {
    final operation = (state as WithOperationState).operation;
    emit(SaveProcessState(operation: operation));

    final result = await _operationsRepository.save(operation);

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

    final result = await _operationsRepository.cache(operation);

    emit(result.fold(
      (f) => FailedState(f),
      (_) => const SuccessState('Операция успешно сохранена в кеш'),
    ));
  }
}
