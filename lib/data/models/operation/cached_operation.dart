import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:popper_mobile/data/models/operation/local_operation.dart';

part 'cached_operation.g.dart';

final formatter = DateFormat('yyyy-MM-ddTHH:mm:ss');

@HiveType(typeId: 12)
class CachedOperation extends LocalOperation<String> {
  const CachedOperation({
    required super.entityType,
    required super.entityId,
    required super.type,
    required super.time,
    required super.isSuccessful,
  });

  @override
  String get key =>
      '${entityType.name} $entityId ${type.name} ${formatter.format(time)}';
}
