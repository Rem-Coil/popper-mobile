part of 'bloc.dart';

@immutable
class LoginState {
  final bool isAuthenticated;
  final bool isLoad;
  final Failure? errorMessage;

  const LoginState._(this.isAuthenticated, this.isLoad, this.errorMessage);

  factory LoginState.initial() => const LoginState._(false, false, null);

  factory LoginState.load() => const LoginState._(false, true, null);

  factory LoginState.authorized() => const LoginState._(true, false, null);

  factory LoginState.error(Failure failure) =>
      LoginState._(false, false, failure);
}
