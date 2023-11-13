import 'package:flutter/foundation.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';
import 'package:popper_mobile/domain/models/operation/operation_type.dart';

@immutable
abstract class OperationWithType extends Operation {
  const OperationWithType({
    required super.id,
    required super.user,
    required super.product,
    required this.type,
    required super.time,
    required super.status,
  });

  final OperationType? type;

  Operation setType(OperationType? type) => copy(type: type);

  @override
  Operation copy({
    int? id,
    OperationType? type,
    OperationStatus? status,
  });

  @override
  String? get typeName => type?.name;

  @override
  bool get savable => type != null;
}
