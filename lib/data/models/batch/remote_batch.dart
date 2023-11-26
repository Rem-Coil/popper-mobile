import 'package:json_annotation/json_annotation.dart';
import 'package:popper_mobile/domain/models/kit/batch.dart';

part 'remote_batch.g.dart';

@JsonSerializable(createToJson: false)
class RemoteBatch extends Batch {
  const RemoteBatch({
    required this.id,
    required this.number,
    required this.kitId,
  }) : super(
          id: id,
          number: number,
          kitId: kitId,
        );

  @override
  final int id;
  @override
  @JsonKey(name: 'batch_number')
  final int number;
  @override
  @JsonKey(name: 'kit_id')
  final int kitId;

  factory RemoteBatch.fromJson(Map<String, dynamic> json) =>
      _$RemoteBatchFromJson(json);
}
