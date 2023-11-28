import 'package:json_annotation/json_annotation.dart';
import 'package:popper_mobile/core/utils/date_utils.dart';

part 'many_products_remote_operation_body.g.dart';

class ManyProductsRemoteOperationBody {
  const ManyProductsRemoteOperationBody({
    required this.time,
    required this.productsId,
  });

  @JsonKey(name: 'products_id')
  final List<int> productsId;
  @JsonKey(name: 'done_time', toJson: _dateToJson)
  final DateTime time;

  static String _dateToJson(DateTime time) => Formatters.operation.format(time);
}

@JsonSerializable(createFactory: false)
class ManyProductsRemoteAcceptanceOperationBody extends ManyProductsRemoteOperationBody {
  const ManyProductsRemoteAcceptanceOperationBody({
    required super.time,
    required super.productsId,
  });

  Map<String, dynamic> toJson() =>
      _$ManyProductsRemoteAcceptanceOperationBodyToJson(this);
}

class ManyProductsRemoteOperationWithTypeBody
    extends ManyProductsRemoteOperationBody {
  const ManyProductsRemoteOperationWithTypeBody({
    required super.productsId,
    required super.time,
    required this.operationId,
  });

  @JsonKey(name: 'operation_type')
  final int operationId;
}

@JsonSerializable(createFactory: false)
class ManyProductsRemoteOperatorOperationBody
    extends ManyProductsRemoteOperationWithTypeBody {
  const ManyProductsRemoteOperatorOperationBody({
    required super.operationId,
    required super.productsId,
    required super.time,
    required this.isRepair,
  });

  @JsonKey(name: 'repair')
  final bool isRepair;

  Map<String, dynamic> toJson() =>
      _$ManyProductsRemoteOperatorOperationBodyToJson(this);
}

@JsonSerializable(createFactory: false)
class ManyProductsRemoteCheckOperationBody
    extends ManyProductsRemoteOperationWithTypeBody {
  const ManyProductsRemoteCheckOperationBody({
    required super.operationId,
    required super.productsId,
    required super.time,
    required this.isSuccessful,
    required this.isNeedRepair,
    required this.controlType,
    required this.comment,
  });

  @JsonKey(name: 'successful')
  final bool isSuccessful;
  @JsonKey(name: 'need_repair')
  final bool isNeedRepair;
  @JsonKey(name: 'control_type')
  final String controlType;
  @JsonKey(name: 'comment')
  final String? comment;

  Map<String, dynamic> toJson() =>
      _$ManyProductsRemoteCheckOperationBodyToJson(this);
}
