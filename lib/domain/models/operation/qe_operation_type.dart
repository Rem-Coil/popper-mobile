enum QeOperationType {
  acceptance,
  check
}

extension LocalizedTypeOfOperation on QeOperationType {
  String get localizedOperationType {
    switch (this) {
      case QeOperationType.acceptance:
        return 'Приёмка';
      case QeOperationType.check:
        return 'Проверка';
    }
  }
}
