import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bobbin.g.dart';

part 'bobbin_local.dart';

part 'bobbin_remote.dart';

const _defaultTaskId = -1;
const _defaultBobbinNumber = 'unknown';

@immutable
class Bobbin {
  final int id;
  final int taskId;
  final String bobbinNumber;

  bool get isUnknown =>
      taskId == _defaultTaskId && bobbinNumber == _defaultBobbinNumber;

  const Bobbin({
    required this.id,
    required this.taskId,
    required this.bobbinNumber,
  });

  factory Bobbin.unknown(int id) {
    return Bobbin(
      id: id,
      taskId: _defaultTaskId,
      bobbinNumber: _defaultBobbinNumber,
    );
  }

  BobbinLocal toLocal() {
    return BobbinLocal(
      bobbinNumber: bobbinNumber,
      id: id,
      taskId: taskId,
    );
  }

  BobbinRemote toRemote() {
    return BobbinRemote(
      id: id,
      taskId: taskId,
      bobbinNumber: bobbinNumber,
    );
  }
}
