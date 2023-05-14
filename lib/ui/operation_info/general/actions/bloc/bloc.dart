import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';
import 'package:popper_mobile/domain/models/product/product_info.dart';
import 'package:popper_mobile/domain/repository/products_repository.dart';
import 'package:popper_mobile/domain/usecase/operations/delete_operation_usecase.dart';

part 'event.dart';
part 'state.dart';

@injectable
class OperationTasksBloc
    extends Bloc<OperationTasksEvent, OperationTasksState> {
  OperationTasksBloc(
    this._productsRepository,
    this._deleteOperation,
  ) : super(const InitialState()) {
    on<DefectBobbinEvent>(_onDefectBobbin);
    on<DeleteOperationEvent>(_onDeleteOperation);
  }

  final ProductsRepository _productsRepository;
  final DeleteOperationUseCase _deleteOperation;

  Future<void> _onDefectBobbin(
    DefectBobbinEvent event,
    Emitter emit,
  ) async {
    emit(const TaskStartState());
    final result =
        await _productsRepository.deactivateProduct(event.productInfo.id);
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
    final result = await _deleteOperation(event.operation);
    emit(result.fold(
      (f) => TaskFailedState(f),
      (_) => const TaskEndState(),
    ));
  }
}
