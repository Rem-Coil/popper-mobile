import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/domain/models/operation/operation_type.dart';
import 'package:popper_mobile/domain/repository/operations_types_repository.dart';

part 'event.dart';

part 'state.dart';

@injectable
class LoadTypesBloc extends Bloc<LoadTypesEvent, LoadTypesState> {
  LoadTypesBloc(
    this._typesRepository,
  ) : super(const NotLoadedState()) {
    on<LoadTypesEvent>(_onLoad);
  }

  final OperationTypesRepository _typesRepository;

  Future<void> _onLoad(LoadTypesEvent event, Emitter emit) async {
    emit(const LoadingState());
    final operations =
        await _typesRepository.getTypesBySpec(event.specificationId);
    emit(operations.fold(
      (f) => LoadingFailureState(f),
      (o) => TypesLoadedState(o),
    ));
  }
}
