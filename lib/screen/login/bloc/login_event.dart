part of 'login_bloc.dart';

@immutable
class LoginEvent {}

class OnDataEntered extends LoginEvent {
  final String phone;
  final String password;

  OnDataEntered({required this.phone, required this.password});

  UserCredentials get credentials =>
      UserCredentials(phone: phone, password: password);
}
