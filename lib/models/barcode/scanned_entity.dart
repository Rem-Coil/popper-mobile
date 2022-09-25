import 'package:flutter/foundation.dart';
import 'package:popper_mobile/core/exception/no_such_entity_type.dart';

part 'entity_type.dart';

@immutable
class ScannedEntity {
  final EntityType type;
  final int id;

  const ScannedEntity._(this.type, this.id);

  factory ScannedEntity.fromString(String? barcode) {
    if (barcode == null) {
      throw Exception('Barcode is null');
    }

    final data = barcode.split(':');
    final type = data[0].toEntityType();
    final id = int.parse(data[1]);
    return ScannedEntity._(type, id);
  }

  String get name => '${type.simpleName} $id';
}
