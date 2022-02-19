import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/domain/repository/auth_repository.dart';
import 'package:popper_mobile/models/auth/user.dart';
import 'package:popper_mobile/models/auth/user_remote.dart';
import 'package:popper_mobile/screen/auth/bloc/auth_bloc.dart';

part 'event.dart';

part 'state.dart';

@singleton
class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final AuthRepository _authRepository;
  final AuthBloc _authBloc;

  RegistrationBloc(this._authRepository, this._authBloc)
      : super(RegistrationState.initial()) {
    on<OnDataEntered>(onDataEntered);
  }

  Future<void> onDataEntered(
    OnDataEntered event,
    Emitter emit,
  ) async {
    emit(RegistrationState.load());
    final serverAnswer = await _authRepository.singUp(event.toModel);

    final newState = serverAnswer.fold(
      (failure) => RegistrationState.error(failure),
      (user) {
        _authBloc.add(ChangeUser(user));
        return RegistrationState.authorized(user);
      },
    );
    emit(newState);
  }
}
