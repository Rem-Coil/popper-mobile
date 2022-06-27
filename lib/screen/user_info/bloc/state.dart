part of 'bloc.dart';

class UserInfoState {}

class UserInfoLoadingState implements UserInfoState {
  UserInfoLoadingState();
}

class UserInfoSuccessState implements UserInfoState {
  final User user;

  UserInfoSuccessState(this.user);
}

class LogOutState extends UserInfoSuccessState {
  LogOutState(UserInfoSuccessState successState) : super(successState.user);
}
