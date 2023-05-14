import 'package:flutter/foundation.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';
import 'package:popper_mobile/domain/models/operation/operation_type.dart';

enum CheckType { testing, otk }

@immutable
class CheckOperation extends Operation {
  const CheckOperation({
    required super.id,
    required super.user,
    required super.product,
    required super.type,
    required super.time,
    required super.status,
    required this.comment,
    required this.isSuccessful,
    required this.checkType,
  });

  const CheckOperation.create({
    required super.user,
    required super.product,
    required super.time,
  })  : comment = null,
        checkType = CheckType.otk,
        isSuccessful = true,
        super(
          id: Operation.defaultId,
          type: null,
          status: OperationStatus.draft,
        );

  final String? comment;
  final bool isSuccessful;
  final CheckType checkType;

  @override
  Operation copy({
    int? id,
    OperationType? type,
    OperationStatus? status,
    String? comment,
    bool? isSuccessful,
    CheckType? checkType,
  }) {
    return CheckOperation(
      id: id ?? this.id,
      user: user,
      product: product,
      type: type ?? this.type,
      time: time,
      status: status ?? this.status,
      comment: comment ?? this.comment,
      isSuccessful: isSuccessful ?? this.isSuccessful,
      checkType: checkType ?? this.checkType,
    );
  }
}
