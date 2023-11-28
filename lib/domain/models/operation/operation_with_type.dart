import 'package:flutter/foundation.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';
import 'package:popper_mobile/domain/models/operation/action_type.dart';

@immutable
abstract class OperationWithType extends Operation {
  const OperationWithType({
    required super.id,
    required super.user,
    required super.products,
    required this.type,
    required super.time,
    required super.status,
  });

  final ActionType? type;

  Operation setType(ActionType? type) => copy(type: type);

  @override
  Operation copy({
    int? id,
    ActionType? type,
    OperationStatus? status,
  });

  @override
  String? get typeName => type?.name;

  @override
  bool get savable => type != null;
}
