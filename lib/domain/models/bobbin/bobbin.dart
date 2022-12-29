import 'package:flutter/foundation.dart';
import 'package:popper_mobile/domain/models/operation/scanned_entity.dart';

const _defaultBatch = -1;
const _defaultNumber = 'unknown';

@immutable
class Bobbin implements ScannedEntity {
  const Bobbin({
    required this.id,
    required this.batchId,
    required String number,
  }) : rawNumber = number;

  const Bobbin.unknown(this.id)
      : batchId = _defaultBatch,
        rawNumber = _defaultNumber;

  @override
  final int id;
  final int batchId;
  final String rawNumber;

  @override
  String get number => !isLoaded ? 'Катшука: $id' : rawNumber;

  @override
  bool get isLoaded => batchId != _defaultBatch || rawNumber != _defaultNumber;

  @override
  String get type => 'Катушка';
}
