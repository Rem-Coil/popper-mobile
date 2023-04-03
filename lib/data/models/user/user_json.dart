import 'package:json_annotation/json_annotation.dart';

part 'user_json.g.dart';

@JsonSerializable(createFactory: false)
class UserJson {
  const UserJson({
    required this.id,
    required this.firstName,
    required this.surname,
    required this.secondName,
    required this.phone,
    required this.role,
    required this.password,
    required this.isActive,
  });

  final int id;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'surname')
  final String surname;
  @JsonKey(name: 'second_name')
  final String secondName;
  final String phone;
  final String role;
  final String password;
  @JsonKey(name: 'active')
  final bool isActive;

  Map<String, dynamic> toJson() => _$UserJsonToJson(this);
}
