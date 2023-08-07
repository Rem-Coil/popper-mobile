import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/utils/date_utils.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';
import 'package:popper_mobile/domain/usecase/operations/get_all_operations_usecase.dart';

part 'event.dart';

part 'state.dart';

@injectable
class OperationsBloc extends Bloc<OperationsEvent, OperationsState> {
  OperationsBloc(
    this._getAllOperations,
  ) : super(const LoadingOperationsState()) {
    on<UpdateEvent>(_onUpdate);
  }

  final GetAllOperationsUsecase _getAllOperations;

  Future<void> _onUpdate(UpdateEvent event, Emitter emit) async {
    emit(const LoadingOperationsState());
    final operations = await _getAllOperations();
    emit(OperationsLoadedState(operations));
  }
}
