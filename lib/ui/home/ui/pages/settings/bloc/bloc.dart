import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/domain/usecase/synchronization/synchronization_usecase.dart';

part 'event.dart';

part 'state.dart';

@injectable
class SynchronizationBloc
    extends Bloc<SynchronizationEvent, SynchronizationState> {
  SynchronizationBloc(
    this._synchronization,
  ) : super(const SynchronizationInitialState()) {
    on<StartSynchronizationEvent>(_onStartSynchronization);
  }

  final SynchronizationUseCase _synchronization;

  Future<void> _onStartSynchronization(
    StartSynchronizationEvent event,
    Emitter emit,
  ) async {
    emit(const SynchronizationStartState());
    await _synchronization();
    emit(const SynchronizationEndState());
  }
}
