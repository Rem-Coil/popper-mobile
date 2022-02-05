import 'package:hive_flutter/hive_flutter.dart';

part 'action_type.g.dart';

@HiveType(typeId: 1)
enum ActionType {
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

extension LocalizeActionType on ActionType {
  String getLocalizedName() {
    switch (this) {
      case ActionType.winding:
        return 'Обмотка';
      case ActionType.output:
        return 'Изолировка выводов';
      case ActionType.isolation:
        return 'Изоляция';
      case ActionType.molding:
        return 'Формовка';
      case ActionType.crimping:
        return 'Опрессовка';
      case ActionType.quality:
        return 'ОТК';
      case ActionType.testing:
        return 'Испытания';
    }
  }
}
