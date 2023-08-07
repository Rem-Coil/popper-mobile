part of 'bloc.dart';

@immutable
class LoginState {
  final bool isAuthenticated;
  final bool isLoad;
  final Failure? errorMessage;

  const LoginState._(this.isAuthenticated, this.isLoad, this.errorMessage);

  const LoginState.initial() : this._(false, false, null);

  const LoginState.load() : this._(false, true, null);

  const LoginState.authorized() : this._(true, false, null);

  const LoginState.error(Failure failure) : this._(false, false, failure);
}
