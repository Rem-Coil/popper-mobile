part of 'action.dart';

@JsonSerializable()
class ActionRemote extends Action {
  @JsonKey(name: 'id')
  @override
  final int id;
  @JsonKey(name: 'operator_id')
  @override
  final int userId;
  @JsonKey(name: 'bobbin_id', fromJson: _bobbinFromJson, toJson: _bobbinToJson)
  @override
  final Bobbin bobbin;
  @JsonKey(name: 'action_type')
  @override
  final ActionType type;
  @JsonKey(name: 'done_time', fromJson: _dateFromJson, toJson: _dateToJson)
  @override
  final DateTime time;

  ActionRemote({
    required this.id,
    required this.userId,
    required this.bobbin,
    required this.type,
    required this.time,
  }) : super(
          id: id,
          userId: userId,
          bobbin: bobbin,
          type: type,
          time: time,
        );

  factory ActionRemote.fromJson(Map<String, dynamic> json) =>
      _$ActionRemoteFromJson(json);

  Map<String, dynamic> toJson() => _$ActionRemoteToJson(this);

  static DateTime _dateFromJson(String date) => formatter.parse(date);

  static Bobbin _bobbinFromJson(int id) => Bobbin.unknown(id);

  static String _dateToJson(DateTime time) => formatter.format(time);

  static int _bobbinToJson(Bobbin bobbin) => bobbin.id;
}
