import 'package:flutter/foundation.dart';
import 'package:popper_mobile/domain/models/operation/scanned_entity.dart';

const _defaultTaskId = -1;
const _defaultNumber = 'unknown';

@immutable
class Batch implements ScannedEntity {
  const Batch({
    required this.id,
    required this.taskId,
    required String number,
  }) : rawNumber = number;

  const Batch.unknown(this.id)
      : taskId = _defaultTaskId,
        rawNumber = _defaultNumber;

  @override
  final int id;
  final int taskId;
  final String rawNumber;

  @override
  String get number => !isLoaded ? 'Партия: $id' : rawNumber;

  @override
  bool get isLoaded => taskId != _defaultTaskId || rawNumber != _defaultNumber;

  @override
  String get type => 'Партия';

  @override
  bool get isActive => true;
}
