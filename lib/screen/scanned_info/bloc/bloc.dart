import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:popper_mobile/core/bloc/status.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/data/repository/actions_repository.dart';
import 'package:popper_mobile/data/repository/auth_repository.dart';
import 'package:popper_mobile/models/action/action.dart';
import 'package:popper_mobile/models/action/action_type.dart';
import 'package:popper_mobile/models/bobbin/bobbin.dart';

part 'event.dart';

part 'state.dart';

@injectable
class SaveActionBloc extends Bloc<SaveActionEvent, SaveActionState> {
  final ActionsRepository _actionsRepository;
  final AuthRepository _authRepository;

  SaveActionBloc(
    @factoryParam Bobbin? bobbin,
    this._actionsRepository,
    this._authRepository,
  ) : super(SaveActionState.initial(bobbin!)) {
    on<OnActionChanged>(onActionChanged);
    on<Initialize>(onInitialize);
    on<OnSaveAction>(onSaveAction);
    add(Initialize());
  }

  Future<void> onSaveAction(OnSaveAction event, Emitter emit) async {
    emit(state.load());
    final action = await _generateAction();
    final lastAction = await _actionsRepository.saveAction(action);
    lastAction.fold(
      (f) => emit(state.saveError(f)),
      (_) => emit(state.saveSuccessful()),
    );
  }

  Future<Action> _generateAction() async {
    final user = await _authRepository.getCurrentUser();
    return Action(
      id: -1,
      userId: user!.id,
      bobbinId: state.bobbin.id,
      type: state.action!,
      time: state.time,
    );
  }

  Future<void> onInitialize(Initialize event, Emitter emit) async {
    final lastAction = await _actionsRepository.getLastActionType();
    add(OnActionChanged(lastAction));
  }

  void onActionChanged(OnActionChanged event, Emitter emit) {
    emit(state.changeAction(event.action));
  }
}
