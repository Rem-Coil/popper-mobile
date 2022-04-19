part of 'bloc.dart';

@immutable
class LoginState {
  final User? user;
  final bool isLoad;
  final Failure? errorMessage;

  const LoginState._(this.user, this.isLoad, this.errorMessage);

  factory LoginState.initial() => const LoginState._(null, false, null);

  factory LoginState.load() => const LoginState._(null, true, null);

  factory LoginState.authorized(User user) => LoginState._(user, false, null);

  factory LoginState.error(Failure failure) =>
      LoginState._(null, false, failure);
}
