import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/domain/repository/operations_repository.dart';

part 'event.dart';

part 'state.dart';

@injectable
class SynchronizationBloc
    extends Bloc<SynchronizationEvent, SynchronizationState> {
  SynchronizationBloc(
    this._repository,
  ) : super(const SynchronizationInitialState()) {
    on<StartSynchronizationEvent>(_onStartSynchronization);
  }

  final OperationsRepository _repository;

  Future<void> _onStartSynchronization(
    StartSynchronizationEvent event,
    Emitter emit,
  ) async {
    emit(const SynchronizationStartState());
    final result = await _repository.syncOperations();
    emit(result.fold(
      (f) => SynchronizationFailedState(f),
      (_) => const SynchronizationEndState(),
    ));
  }
}
