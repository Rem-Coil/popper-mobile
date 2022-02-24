import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/domain/repository/operations_repository.dart';
import 'package:popper_mobile/models/operation/operation.dart';
import 'package:popper_mobile/screen/operations_sync/models/operation_with_status.dart';
import 'package:popper_mobile/screen/operations_sync/models/synchronization_status.dart';

part 'event.dart';

part 'state.dart';

@injectable
class OperationSyncBloc extends Bloc<OperationSyncEvent, OperationSyncState> {
  final OperationsRepository _operationsRepository;

  OperationSyncBloc(
    @factoryParam List<Operation>? operations,
    this._operationsRepository,
  ) : super(OperationSyncState.initial(operations!)) {
    on<NextOperation>(onNextOperation);
  }

  Future<void> onNextOperation(NextOperation event, Emitter emit) async {
    final index = event.operationIndex;
    if (index >= state.operations.length) return;

    emit(state.operationLoad(index));
    final operation = state.operations[index].operation;
    final result = await _operationsRepository.syncOperation(operation);
    emit(result.fold(
      (f) => state.operationError(index, f),
      (_) => state.operationSuccess(index),
    ));
    add(NextOperation(index));
  }
}
