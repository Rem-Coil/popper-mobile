import 'package:flutter/cupertino.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';
import 'package:popper_mobile/domain/models/operation/operation_type.dart';
import 'package:popper_mobile/domain/models/operation/scanned_entity.dart';
import 'package:popper_mobile/domain/models/user/user.dart';

@immutable
class OperationWithComment extends Operation {
  const OperationWithComment({
    required super.id,
    required super.user,
    required super.item,
    required super.type,
    required super.time,
    required super.status,
    required super.isSuccessful,
    required this.comment,
  });

  const OperationWithComment.create({
    required User user,
    required ScannedEntity item,
    required OperationType? type,
    required DateTime time,
    required bool isSuccessful,
  })  : comment = null,
        super.create(
          user: user,
          item: item,
          type: type,
          time: time,
          isSuccessful: isSuccessful,
        );

  final String? comment;

  Operation setComment(String? comment) => copy(comment: comment);

  @override
  Operation copy({
    int? id,
    User? user,
    ScannedEntity? item,
    OperationType? type,
    DateTime? time,
    OperationStatus? status,
    bool? isSuccessful,
    String? comment,
  }) {
    return OperationWithComment(
      id: id ?? this.id,
      user: user ?? this.user,
      item: item ?? this.item,
      type: type ?? this.type,
      time: time ?? this.time,
      status: status ?? this.status,
      isSuccessful: isSuccessful ?? this.isSuccessful,
      comment: comment ?? this.comment,
    );
  }
}
