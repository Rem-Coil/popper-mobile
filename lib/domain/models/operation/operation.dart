import 'package:flutter/foundation.dart';
import 'package:popper_mobile/domain/models/operation/operation_type.dart';
import 'package:popper_mobile/domain/models/operation/scanned_entity.dart';
import 'package:popper_mobile/domain/models/user/user.dart';

const _defaultId = -1;

enum OperationStatus { draft, sync, notSync, updated }

@immutable
class Operation {
  const Operation({
    required this.id,
    required this.user,
    required this.item,
    required this.type,
    required this.time,
    required this.status,
    required this.isSuccessful,
  });

  const Operation.create({
    required this.user,
    required this.item,
    required this.type,
    required this.time,
    required this.isSuccessful,
  })  : id = _defaultId,
        status = OperationStatus.draft;

  final int id;
  final User user;
  final ScannedEntity item;
  final OperationType? type;
  final DateTime time;
  final OperationStatus status;
  final bool isSuccessful;

  Operation setId(int id) => copy(id: id, status: OperationStatus.sync);

  Operation setType(OperationType? type) => copy(type: type);

  Operation setStatus(OperationStatus status) => copy(status: status);

  @protected
  Operation copy({
    int? id,
    User? user,
    ScannedEntity? item,
    OperationType? type,
    DateTime? time,
    OperationStatus? status,
    bool? isSuccessful,
  }) {
    return Operation(
      id: id ?? this.id,
      user: user ?? this.user,
      item: item ?? this.item,
      type: type ?? this.type,
      time: time ?? this.time,
      status: status ?? this.status,
      isSuccessful: isSuccessful ?? this.isSuccessful,
    );
  }
}
