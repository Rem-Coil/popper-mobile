import 'package:flutter/foundation.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';
import 'package:popper_mobile/domain/models/operation/action_type.dart';
import 'operation_with_type.dart';

@immutable
class OperatorOperation extends OperationWithType {
  const OperatorOperation({
    required super.id,
    required super.user,
    required super.product,
    required super.type,
    required super.time,
    required super.status,
    required this.isRepair,
  });

  const OperatorOperation.create({
    required super.user,
    required super.product,
    required super.type,
    required super.time,
  })  : isRepair = false,
        super(id: Operation.defaultId, status: OperationStatus.draft);

  final bool isRepair;

  @override
  Operation copy({
    int? id,
    ActionType? type,
    OperationStatus? status,
    bool? isRepair,
  }) {
    return OperatorOperation(
      id: id ?? this.id,
      user: user,
      product: product,
      type: type ?? this.type,
      time: time,
      status: status ?? this.status,
      isRepair: isRepair ?? this.isRepair,
    );
  }
}
