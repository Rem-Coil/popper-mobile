enum OperationType {
  winding,
  output,
  isolation,
  molding,
  crimping,
  quality,
  testing
}

extension LocalizeOperationType on OperationType {
  String get localizedName {
    switch (this) {
      case OperationType.winding:
        return 'Намотка';
      case OperationType.output:
        return 'Вывод';
      case OperationType.isolation:
        return 'Изолировка';
      case OperationType.molding:
        return 'Формовка';
      case OperationType.crimping:
        return 'Опрессовка';
      case OperationType.quality:
        return 'ОТК';
      case OperationType.testing:
        return 'Испытания';
    }
  }
}
