part of 'bloc.dart';

@immutable
class RegistrationEvent {}

class OnDataEntered extends RegistrationEvent {
  final String firstName;
  final String secondName;
  final String phone;
  final String password;

  OnDataEntered({
    required this.firstName,
    required this.secondName,
    required this.phone,
    required this.password,
  });
}

class ChangeUserRole extends RegistrationEvent {
  final Role? role;

  ChangeUserRole(this.role);
}

@immutable
abstract class CheckCodeEvent {}

class ValidateCodeEvent implements CheckCodeEvent {
  final String code;

  const ValidateCodeEvent(this.code);
}
