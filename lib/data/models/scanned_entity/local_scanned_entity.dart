import 'package:hive_flutter/hive_flutter.dart';
import 'package:popper_mobile/data/cache/core/cache.dart';

abstract class LocalScannedEntity implements Cacheable<int> {
  const LocalScannedEntity({required this.id});

  @HiveField(0)
  final int id;

  @override
  int get key => id;
}
