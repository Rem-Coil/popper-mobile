import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:popper_mobile/core/bloc/status.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/data/repository/actions_repository.dart';
import 'package:popper_mobile/models/action/action.dart';
import 'package:popper_mobile/models/action/action_type.dart';

part 'event.dart';
part 'state.dart';

@injectable
class SaveActionBloc extends Bloc<SaveActionEvent, SaveActionState> {
  final ActionsRepository _actionsRepository;

  SaveActionBloc(
    @factoryParam Action? action,
    this._actionsRepository,
  ) : super(SelectTypeState.initial(action!)) {
    on<OnActionChanged>(onActionChanged);
    on<Initialize>(onInitialize);
    on<OnSaveAction>(onSaveAction);
    on<OnSaveInCache>(onSaveInCache);

    add(Initialize());
  }

  Future<void> onInitialize(Initialize event, Emitter emit) async {
    if (!state.isActionSaved) {
      final lastAction = await _actionsRepository.getLastActionType();
      add(OnActionChanged(lastAction));
    }
  }

  Future<void> onActionChanged(OnActionChanged event, Emitter emit) async {
    final currentState = state as SelectTypeState;
    emit(currentState.changeType(event.action));
  }

  Future<void> onSaveAction(OnSaveAction event, Emitter emit) async {
    emit(ProcessSaveState.load(state.action));
    final currentState = state as ProcessSaveState;

    late Either<Failure, void> result;
    if (state.isActionSaved) {
      result = await _actionsRepository.updateAction(state.action);
    } else {
      result = await _actionsRepository.saveAction(state.action);
    }

    emit(result.fold(
      (f) => currentState.error(f),
      (_) => currentState.success(),
    ));
  }

  Future<void> onSaveInCache(OnSaveInCache event, Emitter emit) async {
    emit(SaveInCacheState.load(state.action));
    final currentState = state as SaveInCacheState;
    final result =
        await _actionsRepository.saveActionInCache(currentState.action);

    emit(result.fold(
      (_) => currentState.error(),
      (_) => currentState.success(),
    ));
  }
}
