import 'package:json_annotation/json_annotation.dart';
import 'package:popper_mobile/data/models/operation_type/remote_operation_type.dart';

part 'remote_specification.g.dart';

@JsonSerializable(createToJson: false)
class RemoteSpecification {
  const RemoteSpecification({
    required this.id,
    required this.productType,
    required this.operationTypes,
  });

  final int id;
  @JsonKey(name: 'product_type')
  final String productType;
  @JsonKey(name: 'operation_types')
  final List<RemoteOperationType> operationTypes;

  factory RemoteSpecification.fromJson(Map<String, dynamic> json) =>
      _$RemoteSpecificationFromJson(json);
}