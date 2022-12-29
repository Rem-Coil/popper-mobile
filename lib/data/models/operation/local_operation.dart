import 'package:hive_flutter/hive_flutter.dart';

part 'local_operation.g.dart';

@HiveType(typeId: 2)
enum EntityType {
  @HiveField(0)
  batch,
  @HiveField(1)
  bobbin,
}

@HiveType(typeId: 1)
enum LocalOperationType {
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

abstract class LocalOperation {
  const LocalOperation({
    required this.entityType,
    required this.entityId,
    required this.type,
    required this.time,
    required this.isSuccessful,
  });

  @HiveField(0)
  final EntityType entityType;
  @HiveField(1)
  final int entityId;
  @HiveField(2)
  final LocalOperationType type;
  @HiveField(3)
  final DateTime time;
  @HiveField(4)
  final bool isSuccessful;
}
