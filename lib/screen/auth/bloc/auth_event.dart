import 'package:flutter/foundation.dart';
import 'package:popper_mobile/models/auth/user.dart';

@immutable
abstract class AuthEvent {}

class ChangeUser extends AuthEvent {
  final User? user;

  ChangeUser(this.user);
}

class LoadSavedUser extends AuthEvent {}
