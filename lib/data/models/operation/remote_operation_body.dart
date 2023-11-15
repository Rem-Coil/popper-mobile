import 'package:json_annotation/json_annotation.dart';
import 'package:popper_mobile/core/utils/date_utils.dart';

part 'remote_operation_body.g.dart';

class RemoteOperationBody {
  const RemoteOperationBody({
    required this.time,
    required this.productId,
  });

  @JsonKey(name: 'product_id')
  final int productId;
  @JsonKey(name: 'done_time', toJson: _dateToJson)
  final DateTime time;

  static String _dateToJson(DateTime time) => Formatters.operation.format(time);
}

@JsonSerializable(createFactory: false)
class RemoteAcceptanceOperationBody extends RemoteOperationBody {
  const RemoteAcceptanceOperationBody({
    required super.time,
    required this.productId,
  }) : super(productId: productId);

  @override
  @JsonKey(toJson: _productIdToJson, name: 'products_id')
  final int productId;

  Map<String, dynamic> toJson() => _$RemoteAcceptanceOperationBodyToJson(this);

  static List<int> _productIdToJson(int productId) {
    return [productId];
  }
}

class RemoteOperationWithTypeBody extends RemoteOperationBody {
  const RemoteOperationWithTypeBody({
    required super.productId,
    required super.time,
    required this.operationId,
  });

  @JsonKey(name: 'operation_type')
  final int operationId;
}

@JsonSerializable(createFactory: false)
class RemoteOperatorOperationBody extends RemoteOperationWithTypeBody {
  const RemoteOperatorOperationBody({
    required super.operationId,
    required super.productId,
    required super.time,
    required this.isRepair,
  });

  @JsonKey(name: 'repair')
  final bool isRepair;

  Map<String, dynamic> toJson() => _$RemoteOperatorOperationBodyToJson(this);
}

@JsonSerializable(createFactory: false)
class RemoteCheckOperationBody extends RemoteOperationWithTypeBody {
  const RemoteCheckOperationBody({
    required super.operationId,
    required super.productId,
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

  Map<String, dynamic> toJson() => _$RemoteCheckOperationBodyToJson(this);
}
