part of 'bobbin.dart';

@JsonSerializable(createToJson: false)
class BobbinRemote extends Bobbin {
  @override
  @JsonKey(name: 'id')
  final int id;
  @override
  @JsonKey(name: 'task_id')
  final int taskId;
  @override
  @JsonKey(name: 'bobbin_number')
  final String bobbinNumber;

  const BobbinRemote({
    required this.id,
    required this.taskId,
    required this.bobbinNumber,
  }) : super(id: id, taskId: taskId, bobbinNumber: bobbinNumber);

  factory BobbinRemote.fromJson(Map<String, dynamic> json) =>
      _$BobbinRemoteFromJson(json);
}
