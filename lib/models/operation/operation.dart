import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:popper_mobile/models/bobbin/bobbin.dart';
import 'package:popper_mobile/models/operation/operation_type.dart';

part 'operation.g.dart';
part 'operation_local.dart';
part 'operation_remote.dart';

final formatter = DateFormat('yyyy-MM-ddTHH:mm:ss');

@immutable
class Operation {
  static const defaultId = -1;

  final int id;
  final int userId;
  final Bobbin bobbin;
  final OperationType? type;
  final DateTime time;

  Operation({
    required this.id,
    required this.userId,
    required this.bobbin,
    required this.type,
    required this.time,
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
    );
  }

  Operation copyWithId(Operation operation) {
    return Operation(
      id: operation.id,
      userId: userId,
      bobbin: bobbin,
      type: type,
      time: time,
    );
  }

  Operation changeType(OperationType? type) {
    return Operation(
      id: this.id,
      userId: this.userId,
      bobbin: this.bobbin,
      type: type,
      time: this.time,
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
    );
  }

  OperationRemote toRemote() {
    return OperationRemote(
      id: id,
      userId: userId,
      bobbin: bobbin,
      type: type!,
      time: time,
    );
  }

  bool isEqualWithoutId(Operation other) {
    return this.bobbin.id == other.bobbin.id &&
        this.type == other.type &&
        this.time == other.time;
  }
}
