import 'package:hive_flutter/hive_flutter.dart';
import 'package:popper_mobile/core/data/cache.dart';

part 'local_product.g.dart';

@HiveType(typeId: 19)
class LocalProduct implements Cacheable<int> {
  const LocalProduct({
    required this.id,
    required this.kitNumber,
    required this.batchNumber,
    required this.productNumber,
    required this.specificationId,
    required this.isActive,
  });

  @HiveField(0)
  final String? kitNumber;
  @HiveField(1)
  final int id;
  @HiveField(2)
  final int? batchNumber;
  @HiveField(3)
  final int? productNumber;
  @HiveField(4)
  final int specificationId;
  @HiveField(5)
  final bool isActive;

  @override
  int get key => id;
}
