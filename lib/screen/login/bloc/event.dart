part of 'bloc.dart';

@immutable
class LoginEvent {}

class OnDataEntered extends LoginEvent {
  final String phone;
  final String password;

  OnDataEntered({required this.phone, required this.password});

  Credentials get credentials => Credentials(phone: phone, password: password);
}
