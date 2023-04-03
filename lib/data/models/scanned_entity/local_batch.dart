import 'package:hive_flutter/hive_flutter.dart';
import 'package:popper_mobile/data/models/scanned_entity/local_scanned_entity.dart';

part 'local_batch.g.dart';

@HiveType(typeId: 13)
class LocalBatch extends LocalScannedEntity {
  const LocalBatch({
    required super.id,
    required this.taskId,
    required this.number,
  });

  @HiveField(10)
  final int taskId;
  @HiveField(11)
  final String number;
}
