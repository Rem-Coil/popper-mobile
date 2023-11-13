import 'package:flutter/foundation.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';

@immutable
class AcceptanceOperation extends Operation {
  const AcceptanceOperation({
    required super.id,
    required super.user,
    required super.product,
    required super.time,
    required super.status,
  });

  const AcceptanceOperation.create({
    required super.user,
    required super.product,
    required super.time,
  }) :
        super(
        id: Operation.defaultId,
        status: OperationStatus.draft,
      );

  @override
  Operation copy({
    int? id,
    OperationStatus? status,
  }) {

    return AcceptanceOperation(
      id: id ?? this.id,
      user: user,
      product: product,
      time: time,
      status: status ?? this.status,
    );
  }

  @override
  bool get savable => true;

  @override
  String? get typeName => 'Приёмка';
}
