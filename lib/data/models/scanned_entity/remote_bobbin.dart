import 'package:json_annotation/json_annotation.dart';

part 'remote_bobbin.g.dart';

@JsonSerializable()
class RemoteBobbin {
  const RemoteBobbin({
    required this.id,
    required this.batchId,
    required this.number,
  });

  final int id;
  @JsonKey(name: 'batch_id')
  final int batchId;
  @JsonKey(name: 'bobbin_number')
  final String number;

  factory RemoteBobbin.fromJson(Map<String, dynamic> json) =>
      _$RemoteBobbinFromJson(json);
}
