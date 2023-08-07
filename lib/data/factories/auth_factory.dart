import 'package:popper_mobile/data/models/user/credentials_json.dart';
import 'package:popper_mobile/data/models/user/user_json.dart';
import 'package:popper_mobile/domain/models/user/credentials.dart';
import 'package:popper_mobile/domain/models/user/role.dart';
import 'package:popper_mobile/domain/models/user/user_identity.dart';

class AuthFactory {
  static CredentialsJson mapCredentials(Credentials credentials) {
    return CredentialsJson(
      phone: credentials.phone,
      password: credentials.password,
    );
  }

  static UserJson mapUser(UserIdentity user, String password) {
    final role = user.role == Role.operator ? 'OPERATOR' : 'QUALITY_ENGINEER';
    return UserJson(
      id: user.id,
      firstName: user.firstName,
      secondName: user.secondName,
      phone: user.phone,
      password: password,
      role: role,
      isActive: true,
    );
  }
}
