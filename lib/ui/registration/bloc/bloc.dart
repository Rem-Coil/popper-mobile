import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/domain/models/user/role.dart';
import 'package:popper_mobile/domain/models/user/user_identity.dart';
import 'package:popper_mobile/domain/repository/auth_repository.dart';

part 'event.dart';
part 'state.dart';

@injectable
class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final AuthRepository _authRepository;

  RegistrationBloc(this._authRepository)
      : super(const RegistrationState(Role.operator)) {
    on<OnDataEntered>(onDataEntered);
    on<ChangeUserRole>(onChangeUserRole);
  }

  Future<void> onDataEntered(
    OnDataEntered event,
    Emitter emit,
  ) async {
    emit(TryRegister(state));
    final user = _toModel(state.role, event);
    final serverAnswer = await _authRepository.singUp(user, event.password);

    emit(serverAnswer.fold(
      (failure) => RegistrationFailed(state, failure),
      (_) => RegistrationSuccessful(state),
    ));
  }

  void onChangeUserRole(ChangeUserRole event, Emitter emit) {
    if (event.role == null) return;
    emit(RegistrationState(event.role!));
  }

  UserIdentity _toModel(Role role, OnDataEntered event) {
    return UserIdentity(
      id: -1,
      firstName: event.firstName,
      surname: event.surname,
      secondName: event.secondName,
      phone: event.phone,
      role: role,
    );
  }
}
