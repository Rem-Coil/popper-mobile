import 'package:popper_mobile/core/exception/no_such_entity_type.dart';
import 'package:popper_mobile/domain/models/batch/batch.dart';
import 'package:popper_mobile/domain/models/bobbin/bobbin.dart';
import 'package:popper_mobile/domain/models/operation/scanned_entity.dart';

class ScannedEntityFactory {
  static ScannedEntity create(String? code) {
    if (code == null) {
      throw Exception('Barcode is null');
    }

    final data = code.split(':');
    final type = data[0];
    final id = int.parse(data[1]);

    switch (type) {
      case 'bobbin':
        return Bobbin.unknown(id);
      case 'batch':
        return Batch.unknown(id);
      default:
        throw const NoSuchEntityTypeException();
    }
  }
}
