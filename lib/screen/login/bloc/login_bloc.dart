import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/screen/login/bloc/login_event.dart';
import 'package:popper_mobile/screen/login/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState.initial()) {
    on<OnDataEntered>(onDataEntered);
  }

  Future<void> onDataEntered(
    OnDataEntered event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginState.load());
    await Future.delayed(Duration(seconds: 1));
    emit(LoginState.authorized('Ilia Rodionov'));
  }
}
