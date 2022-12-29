import 'package:json_annotation/json_annotation.dart';

part 'token.g.dart';

@JsonSerializable(createToJson: false)
class Token {
  const Token({required this.token});

  final String token;

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);
}
