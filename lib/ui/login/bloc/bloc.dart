import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/domain/models/user/credentials.dart';
import 'package:popper_mobile/domain/repository/auth_repository.dart';

part 'event.dart';
part 'state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _repository;

  LoginBloc(this._repository) : super(LoginState.initial()) {
    on<OnDataEntered>(onDataEntered);
  }

  Future<void> onDataEntered(
    OnDataEntered event,
    Emitter emit,
  ) async {
    emit(LoginState.load());
    final serverAnswer = await _repository.singIn(event.credentials);

    emit(serverAnswer.fold(
      (failure) => LoginState.error(failure),
      (_) => LoginState.authorized(),
    ));
  }
}
