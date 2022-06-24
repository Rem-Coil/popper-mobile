import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:popper_mobile/models/bobbin/bobbin.dart';
import 'package:popper_mobile/models/operation/operation_type.dart';

part 'operation.g.dart';
part 'operation_local.dart';
part 'operation_remote.dart';
part 'full_operation.dart';

final formatter = DateFormat('yyyy-MM-ddTHH:mm:ss');

@immutable
class Operation {
  static const defaultId = -1;

  final int id;
  final int userId;
  final Bobbin bobbin;
  final OperationType? type;
  final DateTime time;
  final bool isSuccessful;

  const Operation({
    required this.id,
    required this.userId,
    required this.bobbin,
    required this.type,
    required this.time,
    required this.isSuccessful,
  });

  factory Operation.create({
    required int userId,
    required Bobbin bobbin,
    required DateTime date,
  }) {
    return Operation(
      id: defaultId,
      userId: userId,
      bobbin: bobbin,
      type: null,
      time: date,
      isSuccessful: true,
    );
  }

  Operation copyWithId(Operation operation) {
    return Operation(
      id: operation.id,
      userId: userId,
      bobbin: bobbin,
      type: type,
      time: time,
      isSuccessful: isSuccessful,
    );
  }

  Operation changeType(OperationType? type) {
    return Operation(
      id: id,
      userId: userId,
      bobbin: bobbin,
      type: type,
      time: time,
      isSuccessful: isSuccessful,
    );
  }

  Operation changeStatus(bool isSuccessful) {
    return Operation(
      id: id,
      userId: userId,
      bobbin: bobbin,
      type: type,
      time: time,
      isSuccessful: isSuccessful,
    );
  }

  OperationLocal toLocal() {
    final localBobbin = bobbin.toLocal();
    return OperationLocal(
      id: id,
      userId: userId,
      bobbin: localBobbin,
      type: type,
      time: time,
      isSuccessful: isSuccessful,
    );
  }

  OperationRemote toRemote() {
    return OperationRemote(
      id: id,
      userId: userId,
      bobbin: bobbin,
      type: type!,
      time: time,
      isSuccessful: isSuccessful,
    );
  }

  bool isEqualWithoutId(Operation other) {
    return bobbin.id == other.bobbin.id &&
        type == other.type &&
        time == other.time;
  }
}
