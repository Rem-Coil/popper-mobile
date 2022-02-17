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
class OperationUpdateBloc
    extends Bloc<OperationUpdateEvent, OperationUpdateState> {
  final OperationsRepository _repository;

  OperationUpdateBloc(@factoryParam Operation? operation, this._repository)
      : super(SelectTypeState.initial(operation!)) {
    on<ChangeOperation>(onChangeOperation);
    on<UpdateOperation>(onSaveOperation);
  }

  Future<void> onChangeOperation(ChangeOperation event, Emitter emit) async {
    final currentState = state as SelectTypeState;
    emit(currentState.changeType(event.operationType));
  }

  Future<void> onSaveOperation(UpdateOperation event, Emitter emit) async {
    emit(state.update());
    final currentState = state as UpdateProcessState;
    final result = await _repository.updateOperation(state.operation);

    emit(result.fold(
      (f) => currentState.error(f),
      (_) => currentState.success(),
    ));
  }
}
