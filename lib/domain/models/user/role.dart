enum Role {
  operator,
  qualityEngineer,
}

extension LocalizedUserRole on Role {
  String get localizedRole {
    switch (this) {
      case Role.operator:
        return 'Оператор';
      case Role.qualityEngineer:
        return 'ИТР';
    }
  }
}
