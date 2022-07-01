import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/domain/repository/auth_repository.dart';
import 'package:popper_mobile/models/auth/user.dart';
import 'package:popper_mobile/models/auth/user_role.dart';

part 'event.dart';
part 'state.dart';

@injectable
class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final AuthRepository _authRepository;

  RegistrationBloc(this._authRepository)
      : super(const RegistrationState(UserRole.operator)) {
    on<OnDataEntered>(onDataEntered);
    on<ChangeUserRole>(onChangeUserRole);
  }

  Future<void> onDataEntered(
    OnDataEntered event,
    Emitter emit,
  ) async {
    emit(TryRegister(state));
    final serverAnswer =
        await _authRepository.singUp(toModel(state.role, event));

    final newState = serverAnswer.fold(
      (failure) => RegistrationFailed(state, failure),
      (user) => RegistrationSuccessful(state),
    );
    emit(newState);
  }

  void onChangeUserRole(ChangeUserRole event, Emitter emit) {
    if (event.role == null) return;
    emit(RegistrationState(event.role!));
  }

  UserRemote toModel(UserRole role, OnDataEntered event) {
    return UserRemote(
      id: -1,
      firstName: event.firstName,
      surname: event.surname,
      secondName: event.secondName,
      phone: event.phone,
      password: event.password,
      role: role,
    );
  }
}
