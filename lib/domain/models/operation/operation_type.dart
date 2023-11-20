enum OperationType {
  acceptance,
  check,
  operation
}

extension LocalizedTypeOfOperation on OperationType {
  String get localizedOperationType {
    switch (this) {
      case OperationType.acceptance:
        return 'Приёмка';
      case OperationType.check:
        return 'Проверка';
      case OperationType.operation:
        return 'Обычная операция';
    }
  }
}
