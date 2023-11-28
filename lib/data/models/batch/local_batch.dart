import 'package:hive_flutter/hive_flutter.dart';
import 'package:popper_mobile/core/data/cache.dart';
import 'package:popper_mobile/domain/models/kit/batch.dart';

part 'local_batch.g.dart';

@HiveType(typeId: 24)
class LocalBatch extends Batch implements Cacheable<String> {
  LocalBatch({
    required this.id,
    required this.number,
    required this.kitId,
  }) : super(id: id, number: number, kitId: kitId);

  @override
  @HiveField(0)
  final int id;
  @override
  @HiveField(1)
  final int number;
  @override
  @HiveField(2)
  final int kitId;

  @override
  String get key => '$id';

  factory LocalBatch.from(Batch batch) => LocalBatch(
        id: batch.id,
        number: batch.number,
        kitId: batch.kitId,
      );
}
