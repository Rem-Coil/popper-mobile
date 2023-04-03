import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/domain/repository/operations_repository.dart';

part 'event.dart';

part 'state.dart';

@injectable
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc(
    this._repository,
  ) : super(const InitialState()) {
    on<TrySync>(onTrySync);
  }

  final OperationsRepository _repository;

  Future<void> onTrySync(
    TrySync event,
    Emitter<SplashState> emit,
  ) async {
    emit(const BackgroundTaskState('Синхронизируем операции'));
    await _repository.syncOperations();
    emit(const TasksEnd());
  }
}
