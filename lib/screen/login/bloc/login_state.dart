import 'package:flutter/foundation.dart';
import 'package:popper_mobile/models/user.dart';

@immutable
class LoginState {
  final User? user;
  final bool isLoad;
  final String? errorMessage;

  LoginState._(this.user, this.isLoad, this.errorMessage);

  factory LoginState.initial() => LoginState._(null, false, null);

  factory LoginState.load() => LoginState._(null, true, null);

  factory LoginState.authorized(User user) => LoginState._(user, false, null);

  factory LoginState.error(String message) => LoginState._(null, false, message);
}