import 'package:json_annotation/json_annotation.dart';

part 'remote_batch.g.dart';

@JsonSerializable(createToJson: false)
class RemoteBatch {
  const RemoteBatch({
    required this.id,
    required this.number,
    required this.kitId,
  });

  final int id;
  @JsonKey(name: 'batch_number')
  final int number;
  @JsonKey(name: 'kit_id')
  final int kitId;

  factory RemoteBatch.fromJson(Map<String, dynamic> json) =>
      _$RemoteBatchFromJson(json);
}
