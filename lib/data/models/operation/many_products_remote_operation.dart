import 'package:json_annotation/json_annotation.dart';
import 'package:popper_mobile/core/utils/date_utils.dart';

part 'many_products_remote_operation.g.dart';

class ManyProductsRemoteOperation {
  const ManyProductsRemoteOperation({
    required this.id,
    required this.time,
    required this.userId,
    required this.productsId,
  });

  final int id;
  @JsonKey(name: 'employee_id')
  final int userId;
  @JsonKey(name: 'products_id')
  final List<int> productsId;
  @JsonKey(name: 'done_time', fromJson: _dateFromJson)
  final DateTime time;

  static DateTime _dateFromJson(String date) =>
      Formatters.operation.parse(date);
}

@JsonSerializable(createToJson: false)
class ManyProductsRemoteAcceptanceOperation extends ManyProductsRemoteOperation {
  const ManyProductsRemoteAcceptanceOperation({
    required super.id,
    required super.userId,
    required super.productsId,
    required super.time,
  });

  factory ManyProductsRemoteAcceptanceOperation.fromJson(Map<String, dynamic> json) =>
      _$ManyProductsRemoteAcceptanceOperationFromJson(json);
}

class ManyProductsRemoteOperationWithType extends ManyProductsRemoteOperation {
  const ManyProductsRemoteOperationWithType({
    required super.id,
    required super.time,
    required super.userId,
    required super.productsId,
    required this.operationId,
  });

  @JsonKey(name: 'operation_type')
  final int operationId;
}

@JsonSerializable(createToJson: false)
class ManyProductsRemoteOperatorOperation extends ManyProductsRemoteOperationWithType {
  const ManyProductsRemoteOperatorOperation({
    required super.id,
    required super.operationId,
    required super.userId,
    required super.productsId,
    required super.time,
    required this.isRepair,
  });

  @JsonKey(name: 'repair')
  final bool isRepair;

  factory ManyProductsRemoteOperatorOperation.fromJson(Map<String, dynamic> json) =>
      _$ManyProductsRemoteOperatorOperationFromJson(json);
}

@JsonSerializable(createToJson: false)
class ManyProductsRemoteCheckOperation extends ManyProductsRemoteOperationWithType {
  const ManyProductsRemoteCheckOperation({
    required super.id,
    required super.operationId,
    required super.userId,
    required super.productsId,
    required super.time,
    required this.isSuccessful,
    required this.checkType,
    required this.comment,
    required this.isNeedRepair,
  });

  @JsonKey(name: 'successful')
  final bool isSuccessful;
  @JsonKey(name: 'need_repair')
  final bool isNeedRepair;
  @JsonKey(name: 'control_type')
  final String checkType;
  @JsonKey(name: 'comment')
  final String? comment;

  factory ManyProductsRemoteCheckOperation.fromJson(Map<String, dynamic> json) =>
      _$ManyProductsRemoteCheckOperationFromJson(json);
}
