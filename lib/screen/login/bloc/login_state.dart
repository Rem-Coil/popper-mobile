import 'dart:ffi';

import 'package:flutter/foundation.dart';

@immutable
class LoginState {
  final String? user;
  final bool isLoad;
  final String? errorMessage;

  LoginState._(this.user, this.isLoad, this.errorMessage);

  factory LoginState.initial() => LoginState._(null, false, null);

  factory LoginState.load() => LoginState._(null, true, null);

  factory LoginState.authorized(String user) => LoginState._(user, false, null);

  factory LoginState.error(String message) => LoginState._(null, false, message);
}