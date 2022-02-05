import 'package:jwt_decoder/jwt_decoder.dart';

class User {
  static const testUser = User._(1, "Ilia", "Rodionov", "Alexeevich");
  
  final int id;
  final String firstName;
  final String surname;
  final String secondName;

  const User._(this.id, this.firstName, this.surname, this.secondName);

  String get fullName => '$secondName $firstName';

  factory User.fromToken(String token) {
    final jwtData = JwtDecoder.decode(token);
    return User._(
      jwtData['id'],
      jwtData['first_name'],
      jwtData['surname'],
      jwtData['second_name'],
    );
  }
}