import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/data/auth_repository.dart';
import 'package:popper_mobile/screen/login/bloc/login_event.dart';
import 'package:popper_mobile/screen/login/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final _repository = AuthRepository();

  LoginBloc() : super(LoginState.initial()) {
    on<OnDataEntered>(onDataEntered);
  }

  Future<void> onDataEntered(
    OnDataEntered event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginState.load());
    final user = await _repository.singIn(event.credentials);

    emit(user.fold(
      (failure) => LoginState.error(failure.message),
      (token) => LoginState.authorized('Authorized ${token.token}'),
    ));
  }
}
