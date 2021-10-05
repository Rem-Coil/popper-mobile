import 'package:flutter/foundation.dart';

@immutable
class LoginEvent {}

class OnDataEntered extends LoginEvent {
  final String phone;
  final String password;

  OnDataEntered({required this.phone, required this.password});
}
