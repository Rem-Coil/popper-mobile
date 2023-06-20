import 'package:json_annotation/json_annotation.dart';
import 'package:popper_mobile/core/utils/date_utils.dart';

part 'remote_operation.g.dart';

class RemoteOperation {
  const RemoteOperation({
    required this.id,
    required this.operationId,
    required this.time,
    required this.userId,
    required this.productId,
  });

  final int id;
  @JsonKey(name: 'operation_type')
  final int operationId;
  @JsonKey(name: 'employee_id')
  final int userId;
  @JsonKey(name: 'product_id')
  final int productId;
  @JsonKey(name: 'done_time', fromJson: _dateFromJson)
  final DateTime time;

  static DateTime _dateFromJson(String date) =>
      Formatters.operation.parse(date);
}

@JsonSerializable(createToJson: false)
class RemoteOperatorOperation extends RemoteOperation {
  const RemoteOperatorOperation({
    required super.id,
    required super.operationId,
    required super.userId,
    required super.productId,
    required super.time,
    required this.isRepair,
  });

  @JsonKey(name: 'repair')
  final bool isRepair;

  factory RemoteOperatorOperation.fromJson(Map<String, dynamic> json) =>
      _$RemoteOperatorOperationFromJson(json);
}

@JsonSerializable(createToJson: false)
class RemoteCheckOperation extends RemoteOperation {
  const RemoteCheckOperation({
    required super.id,
    required super.operationId,
    required super.userId,
    required super.productId,
    required super.time,
    required this.isSuccessful,
    required this.checkType,
    required this.comment,
  });

  @JsonKey(name: 'successful')
  final bool isSuccessful;
  @JsonKey(name: 'control_type')
  final String checkType;
  @JsonKey(name: 'comment')
  final String? comment;

  factory RemoteCheckOperation.fromJson(Map<String, dynamic> json) =>
      _$RemoteCheckOperationFromJson(json);
}
