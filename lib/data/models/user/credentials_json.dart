import 'package:json_annotation/json_annotation.dart';

part 'credentials_json.g.dart';

@JsonSerializable(createFactory: false)
class CredentialsJson {
  const CredentialsJson({required this.phone, required this.password});

  final String phone;
  final String password;

  Map<String, dynamic> toJson() => _$CredentialsJsonToJson(this);
}
