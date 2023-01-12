import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_operation.g.dart';

part 'remote_operation_info.dart';

enum RemoteOperationType {
  @JsonValue('winding')
  winding,
  @JsonValue('output')
  output,
  @JsonValue('isolation')
  isolation,
  @JsonValue('molding')
  molding,
  @JsonValue('crimping')
  crimping,
  @JsonValue('quality')
  quality,
  @JsonValue('testing')
  testing
}

final formatter = DateFormat('yyyy-MM-ddTHH:mm:ss');

class RemoteOperation {
  const RemoteOperation({
    required this.id,
    required this.type,
    required this.time,
    required this.successful,
  });

  final int id;
  @JsonKey(name: 'action_type', required: false)
  final RemoteOperationType type;
  @JsonKey(name: 'done_time', fromJson: _dateFromJson, toJson: _dateToJson)
  final DateTime time;
  final bool successful;

  static DateTime _dateFromJson(String date) => formatter.parse(date);

  static String _dateToJson(DateTime time) => formatter.format(time);
}

@JsonSerializable()
class RemoteBatchOperation extends RemoteOperation {
  const RemoteBatchOperation({
    required super.id,
    required this.batchId,
    required super.type,
    required super.time,
    required super.successful,
  });

  @JsonKey(name: 'batch_id')
  final int batchId;

  factory RemoteBatchOperation.fromJson(Map<String, dynamic> json) =>
      _$RemoteBatchOperationFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteBatchOperationToJson(this);
}

@JsonSerializable()
class RemoteBobbinOperation extends RemoteOperation {
  const RemoteBobbinOperation({
    required super.id,
    required this.bobbinId,
    required super.type,
    required super.time,
    required super.successful,
  });

  @JsonKey(name: 'bobbin_id')
  final int bobbinId;

  factory RemoteBobbinOperation.fromJson(Map<String, dynamic> json) =>
      _$RemoteBobbinOperationFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteBobbinOperationToJson(this);
}
