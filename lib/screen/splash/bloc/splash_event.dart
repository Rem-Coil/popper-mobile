import 'package:flutter/foundation.dart';
import 'package:popper_mobile/models/auth/user.dart';

@immutable
class SplashEvent {}

class Initialize extends SplashEvent {
  final User? user;

  Initialize(this.user);
}
