import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/domain/models/bobbin/bobbin.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';
import 'package:popper_mobile/domain/repository/bobbins_repository.dart';
import 'package:popper_mobile/domain/repository/operations_repository.dart';

part 'event.dart';

part 'state.dart';

@injectable
class OperationTasksBloc
    extends Bloc<OperationTasksEvent, OperationTasksState> {
  OperationTasksBloc(this._bobbinsRepository, this._operationsRepository)
      : super(const InitialState()) {
    on<DefectBobbinEvent>(_onDefectBobbin);
    on<DeleteOperationEvent>(_onDeleteOperation);
  }

  final BobbinsRepository _bobbinsRepository;
  final OperationsRepository _operationsRepository;

  Future<void> _onDefectBobbin(
    DefectBobbinEvent event,
    Emitter emit,
  ) async {
    emit(const TaskStartState());
    final result = await _bobbinsRepository.defectBobbin(event.bobbin);
    emit(result.fold(
      (f) => TaskFailedState(f),
      (_) => const TaskEndState(),
    ));
  }

  Future<void> _onDeleteOperation(
    DeleteOperationEvent event,
    Emitter emit,
  ) async {
    emit(const TaskStartState());
    final result = await _operationsRepository.delete(event.operation);
    emit(result.fold(
      (f) => TaskFailedState(f),
      (_) => const TaskEndState(),
    ));
  }
}
