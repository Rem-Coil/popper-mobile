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
