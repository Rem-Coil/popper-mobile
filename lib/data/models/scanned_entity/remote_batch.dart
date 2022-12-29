import 'package:json_annotation/json_annotation.dart';

part 'remote_batch.g.dart';

@JsonSerializable()
class RemoteBatch {
  const RemoteBatch({
    required this.id,
    required this.taskId,
    required this.number,
  });

  final int id;
  @JsonKey(name: 'task_id')
  final int taskId;
  @JsonKey(name: 'batch_number')
  final String number;

  factory RemoteBatch.fromJson(Map<String, dynamic> json) =>
      _$RemoteBatchFromJson(json);
}
