import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bobbin.g.dart';

part 'bobbin_local.dart';

part 'bobbin_remote.dart';

const _defaultBatch = -1;
const _defaultBobbinNumber = 'unknown';

@immutable
class Bobbin {
  final int id;
  final int batchId;
  final String bobbinNumber;

  bool get isUnknown =>
      batchId == _defaultBatch && bobbinNumber == _defaultBobbinNumber;

  const Bobbin({
    required this.id,
    required this.batchId,
    required this.bobbinNumber,
  });

  factory Bobbin.unknown(int id) {
    return Bobbin(
      id: id,
      batchId: _defaultBatch,
      bobbinNumber: _defaultBobbinNumber,
    );
  }

  BobbinLocal toLocal() {
    return BobbinLocal(
      bobbinNumber: bobbinNumber,
      id: id,
      batchId: batchId,
    );
  }

  BobbinRemote toRemote() {
    return BobbinRemote(
      id: id,
      batchId: batchId,
      bobbinNumber: bobbinNumber,
    );
  }
}
