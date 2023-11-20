import 'package:hive/hive.dart';
import 'package:popper_mobile/core/data/cache.dart';

@HiveType(typeId: 24)
class LocalBatch implements Cacheable<String> {
  LocalBatch({
    required this.id,
    required this.number,
    required this.kitId,
  });


  @HiveField(0)
  final int id;
  @HiveField(1)
  final int number;
  @HiveField(2)
  final int kitId;


  @override
  // TODO: implement key
  String get key => throw UnimplementedError();
}
