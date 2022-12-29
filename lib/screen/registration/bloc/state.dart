part of 'bloc.dart';

@immutable
class RegistrationState {
  final Role role;

  const RegistrationState(this.role);
}

class TryRegister extends RegistrationState {
  TryRegister(RegistrationState state) : super(state.role);
}

class RegistrationFailed extends RegistrationState {
  final Failure failure;

  RegistrationFailed(RegistrationState state, this.failure) : super(state.role);
}

class RegistrationSuccessful extends RegistrationState {
  RegistrationSuccessful(RegistrationState state) : super(state.role);
}
