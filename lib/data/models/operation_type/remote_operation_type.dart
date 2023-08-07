import 'package:json_annotation/json_annotation.dart';

part 'remote_operation_type.g.dart';

@JsonSerializable(createToJson: false)
class RemoteOperationType {
  const RemoteOperationType({
    required this.id,
    required this.name,
    required this.sequenceNumber,
    required this.specificationId,
  });

  final int id;
  @JsonKey(name: 'type')
  final String name;
  @JsonKey(name: 'sequence_number')
  final int sequenceNumber;
  @JsonKey(name: 'specification_id')
  final int specificationId;

  factory RemoteOperationType.fromJson(Map<String, dynamic> json) =>
      _$RemoteOperationTypeFromJson(json);
}
