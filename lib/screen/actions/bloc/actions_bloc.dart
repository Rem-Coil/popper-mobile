import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/data/actions_repository.dart';
import 'package:popper_mobile/screen/actions/bloc/actions_event.dart';
import 'package:popper_mobile/screen/actions/bloc/actions_state.dart';

@singleton
class ActionsBloc extends Bloc<ActionsEvent, ActionsState> {
  final ActionsRepository _actionsRepository;

  ActionsBloc(this._actionsRepository) : super(ActionsState.initial()) {
    on<UpdateListEvent>(onUpdateActions);
  }

  Future<void> onUpdateActions(
    UpdateListEvent event,
    Emitter<ActionsState> emit,
  ) async {
    final result = await _actionsRepository.getActions();
    emit(result.fold(
      (_) => ActionsState.error('message'),
      (actions) => ActionsState.withActions(actions),
    ));
  }
}
