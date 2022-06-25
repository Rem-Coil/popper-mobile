import 'package:json_annotation/json_annotation.dart';

enum UserRole {
  @JsonValue('operator')
  operator,
  @JsonValue('quality_engineer')
  qualityEngineer,
}

extension LocalizedUserRole on UserRole {
  String get localizedRole {
    switch (this) {
      case UserRole.operator:
        return 'Оператор';
      case UserRole.qualityEngineer:
        return 'ИТР';
    }
  }
}
