import 'package:hive_flutter/hive_flutter.dart';

part 'operation_type.g.dart';

@HiveType(typeId: 1)
enum OperationType {
  @HiveField(0)
  winding,
  @HiveField(1)
  output,
  @HiveField(2)
  isolation,
  @HiveField(3)
  molding,
  @HiveField(4)
  crimping,
  @HiveField(5)
  quality,
  @HiveField(6)
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
