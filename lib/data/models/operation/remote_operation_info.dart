part of 'remote_operation.dart';

@JsonSerializable(createToJson: false)
class RemoteOperationInfo extends RemoteOperation {
  const RemoteOperationInfo({
    required super.id,
    required super.type,
    required super.time,
    required super.successful,
    required this.comment,
    required this.operatorId,
    required this.firstName,
    required this.secondName,
    required this.surname,
    required this.role,
  });

  @JsonKey(name: 'comment', )
  final String? comment;
  @JsonKey(name: 'operator_id')
  final int operatorId;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'second_name')
  final String secondName;
  @JsonKey(name: 'surname')
  final String surname;
  @JsonKey(name: 'role')
  final String role;

  factory RemoteOperationInfo.fromJson(Map<String, dynamic> json) =>
      _$RemoteOperationInfoFromJson(json);
}
