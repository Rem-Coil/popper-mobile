import 'package:json_annotation/json_annotation.dart';
import 'package:popper_mobile/models/auth/user_role.dart';

part 'user_remote.g.dart';

@JsonSerializable(createFactory: false)
class UserRemote {
  final int id;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'surname')
  final String surname;
  @JsonKey(name: 'second_name')
  final String secondName;
  final String phone;
  final String password;
  final bool active;
  final UserRole role;

  UserRemote({
    required this.id,
    required this.firstName,
    required this.surname,
    required this.secondName,
    required this.phone,
    required this.password,
    this.active = true,
    required this.role,
  });

  Map<String, dynamic> toJson() => _$UserRemoteToJson(this);
}
