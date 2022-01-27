import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/data/auth_repository.dart';
import 'package:popper_mobile/screen/auth/bloc/auth_bloc.dart';
import 'package:popper_mobile/screen/auth/bloc/auth_event.dart';
import 'package:popper_mobile/screen/login/bloc/login_event.dart';
import 'package:popper_mobile/screen/login/bloc/login_state.dart';

@singleton
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _repository;
  final AuthBloc _authBloc;

  LoginBloc(this._repository, this._authBloc) : super(LoginState.initial()) {
    on<OnDataEntered>(onDataEntered);
  }

  Future<void> onDataEntered(
    OnDataEntered event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginState.load());
    final serverAnswer = await _repository.singIn(event.credentials);

    final newState = serverAnswer.fold(
      (failure) => LoginState.error(failure),
      (user) {
        _authBloc.add(ChangeUser(user));
        return LoginState.authorized(user);
      },
    );
    emit(newState);
  }
}
