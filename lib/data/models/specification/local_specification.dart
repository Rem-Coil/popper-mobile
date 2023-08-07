import 'package:hive_flutter/hive_flutter.dart';
import 'package:popper_mobile/core/data/cache.dart';
import 'package:popper_mobile/data/models/operation_type/local_operation_type.dart';

part 'local_specification.g.dart';

@HiveType(typeId: 21)
class LocalSpecification implements Cacheable<int> {
  const LocalSpecification({
    required this.id,
    required this.productType,
    required this.operationTypes,
  });

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String productType;
  @HiveField(2)
  final List<LocalOperationType> operationTypes;

  @override
  int get key => id;
}
