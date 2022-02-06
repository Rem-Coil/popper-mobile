part of 'action.dart';

@JsonSerializable()
class ActionRemote extends Action {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'operator_id')
  final int userId;
  @JsonKey(name: 'bobbin_id')
  final int bobbinId;
  @JsonKey(name: 'action_type')
  final ActionType type;
  @JsonKey(name: 'done_time', fromJson: _dateFromJson, toJson: _dateToJson)
  final DateTime time;

  ActionRemote({
    required this.id,
    required this.userId,
    required this.bobbinId,
    required this.type,
    required this.time,
  }) : super(
          id: id,
          userId: userId,
          bobbinId: bobbinId,
          type: type,
          time: time,
        );

  factory ActionRemote.fromAction(Action action) {
    return ActionRemote(
      id: action.id,
      userId: action.userId,
      bobbinId: action.bobbinId,
      type: action.type,
      time: action.time,
    );
  }

  factory ActionRemote.fromJson(Map<String, dynamic> json) =>
      _$ActionRemoteFromJson(json);

  Map<String, dynamic> toJson() => _$ActionRemoteToJson(this);

  static DateTime _dateFromJson(String date) => formatter.parse(date);

  static String _dateToJson(DateTime time) => formatter.format(time);
}
