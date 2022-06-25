import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:popper_mobile/models/auth/user_role.dart';

class User {
  final int id;
  final String firstName;
  final String surname;
  final String secondName;
  final String phone;
  final UserRole role;

  const User(this.id, this.firstName, this.surname, this.secondName, this.phone,
      this.role);

  factory User.initial() {
    return const User(-1, '', '', '', '', UserRole.operator);
  }

  String get fullName => '$secondName $firstName';

  factory User.fromToken(String token) {
    final jwtData = JwtDecoder.decode(token);
    return User(
      jwtData['id'],
      jwtData['first_name'],
      jwtData['surname'],
      jwtData['second_name'],
      jwtData['phone'],
      // create(jwtData['role']),
      UserRole.operator, // TODO: использовать токен вместо заданного значения
    );
  }
}
