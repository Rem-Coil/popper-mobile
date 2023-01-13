import 'package:hive_flutter/hive_flutter.dart';
import 'package:popper_mobile/data/models/scanned_entity/local_scanned_entity.dart';

part 'local_bobbin.g.dart';

@HiveType(typeId: 14)
class LocalBobbin extends LocalScannedEntity {
  const LocalBobbin({
    required super.id,
    required this.batchId,
    required this.number,
    required this.active,
  });

  @HiveField(10)
  final int batchId;
  @HiveField(11)
  final String number;
  @HiveField(12, defaultValue: true)
  final bool active;
}
