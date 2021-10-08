import 'package:json_annotation/json_annotation.dart';

part 'user_credentials.g.dart';

@JsonSerializable()
class UserCredentials {
  final String phone;
  final String password;

  UserCredentials({required this.phone, required this.password});

  factory UserCredentials.fromJson(Map<String, dynamic> json) =>
      _$UserCredentialsFromJson(json);

  Map<String, dynamic> toJson() => _$UserCredentialsToJson(this);
}
