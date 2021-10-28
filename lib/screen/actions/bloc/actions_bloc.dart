import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/screen/actions/bloc/actions_event.dart';
import 'package:popper_mobile/screen/actions/bloc/actions_state.dart';

class ActionsBloc extends Bloc<ActionsEvent, ActionsState> {
  ActionsBloc() : super(ActionsState.initial());
}