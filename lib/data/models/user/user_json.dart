import 'package:json_annotation/json_annotation.dart';

part 'user_json.g.dart';

@JsonSerializable()
class UserJson {
  const UserJson({
    required this.id,
    required this.firstName,
    required this.secondName,
    required this.phone,
    required this.role,
    required this.password,
    required this.isActive,
  });

  final int id;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String secondName;
  final String phone;
  final String role;
  final String password;
  @JsonKey(name: 'active')
  final bool isActive;

  factory UserJson.fromJson(Map<String, dynamic> json) =>
      _$UserJsonFromJson(json);

  Map<String, dynamic> toJson() => _$UserJsonToJson(this);
}
