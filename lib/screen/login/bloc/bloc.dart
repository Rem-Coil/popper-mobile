import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/domain/repository/auth_repository.dart';
import 'package:popper_mobile/models/auth/user.dart';
import 'package:popper_mobile/models/auth/user_credentials.dart';
import 'package:popper_mobile/screen/auth/bloc/auth_bloc.dart';

part 'event.dart';

part 'state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _repository;
  final AuthBloc _authBloc;

  LoginBloc(this._repository, this._authBloc) : super(LoginState.initial()) {
    on<OnDataEntered>(onDataEntered);
  }

  Future<void> onDataEntered(
    OnDataEntered event,
    Emitter emit,
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
