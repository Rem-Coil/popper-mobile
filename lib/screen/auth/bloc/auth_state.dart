import 'package:flutter/foundation.dart';
import 'package:popper_mobile/core/bloc/status.dart';
import 'package:popper_mobile/models/auth/user.dart';

@immutable
class AuthState {
  final Status status;
  final User? user;

  AuthState._(this.user, this.status);

  factory AuthState.initial() {
   return AuthState._(null, Status.initial);
  }

  AuthState loading() {
    return AuthState._(user, Status.load);
  }

  AuthState setUser(User? user) {
    return AuthState._(user, Status.success);
  }
}