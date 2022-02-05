import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:popper_mobile/data/actions_repository.dart';
import 'package:popper_mobile/models/action/action_type.dart';
import 'package:popper_mobile/models/bobbin/bobbin.dart';

part 'state.dart';

part 'event.dart';

@injectable
class SaveActionBloc extends Bloc<SaveActionEvent, SaveActionState> {
  final ActionsRepository _actionsRepository;

  SaveActionBloc(@factoryParam Bobbin? bobbin, this._actionsRepository)
      : super(SaveActionState.initial(bobbin!)) {
    on<OnActionChanged>(onActionChanged);
    on<Initialize>(onInitialize);
    add(Initialize());
  }

  Future<void> onInitialize(Initialize event, Emitter emit) async {
    final lastAction = await _actionsRepository.getLastActionType();
    add(OnActionChanged(lastAction));
  }

  void onActionChanged(OnActionChanged event, Emitter emit) {
    emit(state.changeAction(event.action));
  }
}
