part of 'bloc.dart';

@immutable
class RegistrationState {
  final User? user;
  final bool isLoad;
  final Failure? errorMessage;

  const RegistrationState._(this.user, this.isLoad, this.errorMessage);

  factory RegistrationState.initial() => const RegistrationState._(null, false, null);

  factory RegistrationState.load() => const RegistrationState._(null, true, null);

  factory RegistrationState.authorized(User user) =>
      RegistrationState._(user, false, null);

  factory RegistrationState.error(Failure failure) =>
      RegistrationState._(null, false, failure);
}
