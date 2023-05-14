import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/domain/usecase/synchronization/synchronization_usecase.dart';

part 'event.dart';
part 'state.dart';

@injectable
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc(
    this._synchronization,
  ) : super(const InitialState()) {
    on<TrySync>(onTrySync);
  }

  final SynchronizationUseCase _synchronization;

  Future<void> onTrySync(
    TrySync event,
    Emitter<SplashState> emit,
  ) async {
    emit(const BackgroundTaskState('Синхронизируем операции'));
    await _synchronization();
    emit(const TasksEnd());
  }
}
