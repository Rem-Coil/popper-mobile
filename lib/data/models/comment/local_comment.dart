import 'package:hive_flutter/hive_flutter.dart';
import 'package:popper_mobile/data/cache/core/cache.dart';

part 'local_comment.g.dart';

@HiveType(typeId: 15)
class LocalComment implements Cacheable<String> {
  const LocalComment({
    required this.operationId,
    required this.comment,
  });

  @HiveField(1)
  final String operationId;
  @HiveField(11)
  final String comment;

  @override
  String get key => operationId;
}
