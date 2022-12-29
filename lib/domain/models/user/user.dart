import 'package:popper_mobile/domain/models/user/role.dart';

class User {
  const User({
    required this.id,
    required this.firstName,
    required this.surname,
    required this.secondName,
    required this.phone,
    required this.role,
  });

  final int id;
  final String firstName;
  final String surname;
  final String secondName;
  final String phone;
  final Role role;

  String get fullName => '$secondName $firstName';
}
