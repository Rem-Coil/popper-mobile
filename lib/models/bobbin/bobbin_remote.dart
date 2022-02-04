part of 'bobbin.dart';

@JsonSerializable(createToJson: false)
class BobbinRemoteModel extends Bobbin {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'task_id')
  final int taskId;
  @JsonKey(name: 'bobbin_number')
  final String bobbinNumber;

  BobbinRemoteModel({
    required this.id,
    required this.taskId,
    required this.bobbinNumber,
  }) : super(id: id, taskId: taskId, bobbinNumber: bobbinNumber);

  factory BobbinRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$BobbinRemoteModelFromJson(json);
}
