import 'package:hive_flutter/hive_flutter.dart';
import 'package:popper_mobile/core/data/cache.dart';

part 'local_operation_type.g.dart';

@HiveType(typeId: 20)
class LocalOperationType implements Cacheable<int> {
  const LocalOperationType({
    required this.id,
    required this.name,
    required this.sequenceNumber,
    required this.specificationId,
  });

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final int sequenceNumber;
  @HiveField(3)
  final int specificationId;

  @override
  int get key => id;
}

@HiveType(typeId: 22)
class LocalSimpleOperationType implements Cacheable<int> {
  const LocalSimpleOperationType({
    required this.id,
    required this.name,
  });

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;

  @override
  int get key => id;
}