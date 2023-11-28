import 'package:flutter/foundation.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';
import 'package:popper_mobile/domain/models/operation/action_type.dart';
import 'operation_with_type.dart';

enum CheckType { testing, otk }

@immutable
class CheckOperation extends OperationWithType {
  const CheckOperation({
    required super.id,
    required super.user,
    required super.products,
    required super.type,
    required super.time,
    required super.status,
    required this.comment,
    required this.isSuccessful,
    required this.checkType,
    required this.isNeedRepair,
  }) : assert(!isSuccessful || !isNeedRepair);

  const CheckOperation.create({
    required super.user,
    required super.products,
    required super.time,
  })  : comment = null,
        checkType = CheckType.otk,
        isSuccessful = true,
        isNeedRepair = false,
        super(
          id: Operation.defaultId,
          type: null,
          status: OperationStatus.draft,
        );

  final String? comment;
  final bool isSuccessful;
  final bool isNeedRepair;
  final CheckType checkType;

  @override
  Operation copy({
    int? id,
    ActionType? type,
    OperationStatus? status,
    String? comment,
    bool? isSuccessful,
    bool? isNeedRepair,
    CheckType? checkType,
  }) {
    late final String? nullableComment;

    if (comment != null) {
      nullableComment = comment.isEmpty ? null : comment;
    } else {
      nullableComment = this.comment;
    }

    return CheckOperation(
      id: id ?? this.id,
      user: user,
      products: products,
      type: type ?? this.type,
      time: time,
      status: status ?? this.status,
      comment: nullableComment,
      isSuccessful: isSuccessful ?? this.isSuccessful,
      isNeedRepair: isNeedRepair ?? this.isNeedRepair,
      checkType: checkType ?? this.checkType,
    );
  }
}
