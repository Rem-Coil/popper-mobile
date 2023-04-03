part of 'bloc.dart';

class CurrentUserEvent {}

class LoadUserEvent implements CurrentUserEvent {
  const LoadUserEvent();
}

class LogOutEvent implements CurrentUserEvent {
  const LogOutEvent();
}
