import 'package:json_annotation/json_annotation.dart';
import 'package:popper_mobile/domain/models/kit/kit.dart';

part 'remote_kit.g.dart';

@JsonSerializable(createToJson: false)
class RemoteKit extends Kit {
  const RemoteKit({
    required this.id,
    required this.number,
    required this.specificationId,
    required this.acceptancePercentage,
    required this.batchesQuantity,
    required this.batchesSize,
  }) : super(
          id: id,
          number: number,
          acceptancePercentage: acceptancePercentage,
          batchesQuantity: batchesQuantity,
          batchesSize: batchesSize,
          specificationId: specificationId,
        );

  @override
  final int id;
  @override
  @JsonKey(name: 'kit_number')
  final String number;
  @override
  @JsonKey(name: 'specification_id')
  final int specificationId;
  @override
  @JsonKey(name: 'acceptance_percentage')
  final int acceptancePercentage;
  @override
  @JsonKey(name: 'batches_quantity')
  final int batchesQuantity;
  @override
  @JsonKey(name: 'batch_size')
  final int batchesSize;

  factory RemoteKit.fromJson(Map<String, dynamic> json) =>
      _$RemoteKitFromJson(json);
}
