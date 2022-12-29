import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/utils/date_utils.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';
import 'package:popper_mobile/domain/repository/operations_repository.dart';
import 'package:popper_mobile/domain/usecase/operations/operations_usecase.dart';

part 'event.dart';

part 'state.dart';

@injectable
class OperationsBloc extends Bloc<OperationsEvent, OperationsState> {
  OperationsBloc(
    this._getAllOperations,
    this._operationsRepository,
  ) : super(const LoadingOperationsState()) {
    on<InitialEvent>(_onInitial);
    on<_UpdateEvent>(_onUpdate);
  }

  final OperationsRepository _operationsRepository;

  final GetAllOperationsUsecase _getAllOperations;

  void _onCacheChange() => add(const _UpdateEvent());

  Future<void> _onInitial(InitialEvent event, Emitter emit) async {
    await _operationsRepository.unsubscribe(_onCacheChange);
    await _operationsRepository.subscribe(_onCacheChange);

    add(const _UpdateEvent());
  }

  Future<void> _onUpdate(_UpdateEvent event, Emitter emit) async {
    emit(const LoadingOperationsState());
    final operations = await _getAllOperations.getAll();
    emit(OperationsLoadedState(operations));
  }
}
