import 'package:hive_flutter/hive_flutter.dart';
import 'package:popper_mobile/data/cache/core/cache.dart';
import 'package:popper_mobile/data/models/operation/local_operation.dart';

part 'completed_operation.g.dart';

@HiveType(typeId: 11)
class CompletedOperation extends LocalOperation implements Cacheable<int> {
  const CompletedOperation({
    required this.id,
    required super.entityType,
    required super.entityId,
    required super.type,
    required super.time,
    required super.isSuccessful,
  });

  @HiveField(10)
  final int id;

  @override
  int get key => id;
}
