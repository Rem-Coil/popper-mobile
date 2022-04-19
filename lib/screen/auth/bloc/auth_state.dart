part of 'auth_bloc.dart';

@immutable
class AuthState {
  final Status status;
  final User? user;

  const AuthState._(this.user, this.status);

  factory AuthState.initial() {
   return const AuthState._(null, Status.initial);
  }

  AuthState loading() {
    return AuthState._(user, Status.load);
  }

  AuthState setUser(User? user) {
    return AuthState._(user, Status.success);
  }
}