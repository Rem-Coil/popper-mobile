import 'package:popper_mobile/domain/models/user/role.dart';
import 'package:popper_mobile/domain/models/user/user.dart';

class UserIdentity extends User {
  const UserIdentity({
    required super.id,
    required super.firstName,
    required super.surname,
    required super.secondName,
    required this.phone,
    required this.role,
  });

  final String phone;
  final Role role;
}
