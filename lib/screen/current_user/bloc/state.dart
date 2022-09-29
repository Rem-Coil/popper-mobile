part of 'bloc.dart';

abstract class CurrentUserState {}

class UnknownUserState implements CurrentUserState {
  const UnknownUserState();
}

class WithUserState implements CurrentUserState {
  const WithUserState(this.user);

  final User user;
}

class UserNotSetState implements CurrentUserState {
  const UserNotSetState();
}
