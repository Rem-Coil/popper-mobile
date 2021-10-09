import 'package:jwt_decoder/jwt_decoder.dart';

class User {
  static const testUser = User._(1, "Ilia", "Rodionov", "Alexeevich");
  
  final int id;
  final String firstname;
  final String surname;
  final String secondName;

  const User._(this.id, this.firstname, this.surname, this.secondName);

  factory User.fromToken(String token) {
    final jwtData = JwtDecoder.decode(token);
    return User._(
      0,
      jwtData['firstname'],
      jwtData['surname'],
      jwtData['second_name'],
    );
  }
}