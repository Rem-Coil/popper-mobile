part of 'auth_bloc.dart';


@immutable
abstract class AuthEvent {}

class ChangeUser extends AuthEvent {
  final User? user;

  ChangeUser(this.user);
}

class LoadSavedUser extends AuthEvent {}

class LogOut extends AuthEvent {}
