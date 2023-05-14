import 'package:json_annotation/json_annotation.dart';

part 'remote_product.g.dart';

@JsonSerializable(createToJson: false)
class RemoteProduct {
  const RemoteProduct({
    required this.id,
    required this.batchId,
    required this.number,
    required this.isActive,
  });

  final int id;
  @JsonKey(name: 'batch_id')
  final int batchId;
  @JsonKey(name: 'product_number')
  final int number;
  @JsonKey(name: 'active')
  final bool isActive;

  factory RemoteProduct.fromJson(Map<String, dynamic> json) =>
      _$RemoteProductFromJson(json);
}
