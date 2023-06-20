import 'package:json_annotation/json_annotation.dart';
import 'package:popper_mobile/data/models/user/token.dart';
import 'package:popper_mobile/domain/models/user/role.dart';
import 'package:popper_mobile/domain/models/user/user.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:popper_mobile/domain/models/user/user_identity.dart';

class UserFactory {
  static const _roleKeys = {
    Role.operator: 'OPERATOR',
    Role.qualityEngineer: 'QUALITY_ENGINEER',
  };

  static User fromToken(Token model) {
    return fromString(model.token);
  }

  static UserIdentity fromString(String token) {
    final jwtData = JwtDecoder.decode(token);
    return UserIdentity(
      id: jwtData['id'],
      firstName: jwtData['first_name'],
      secondName: jwtData['last_name'],
      phone: jwtData['phone'],
      role: $enumDecode(_roleKeys, jwtData['role']),
    );
  }
}
