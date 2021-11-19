import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:popper_mobile/models/action/action_type.dart';
import 'package:popper_mobile/models/action/local_action.dart';

part 'action.g.dart';

final formatter = DateFormat('yyyy-MM-ddTHH:mm:ss');

@immutable
@JsonSerializable()
class Action {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'operator_id')
  final int userId;
  @JsonKey(name: 'bobbin_id')
  final int bobbinId;
  @JsonKey(name: 'action_type')
  final ActionType type;
  @JsonKey(name: 'done_time', fromJson: _dateFromJson, toJson: _dateToJson)
  final DateTime time;

  Action({
    required this.id,
    required this.userId,
    required this.bobbinId,
    required this.type,
    required this.time,
  });

  factory Action.fromQr({
    required int userId,
    required int bobbinId,
    required ActionType type,
  }) {
    return Action(
      id: 0,
      userId: userId,
      bobbinId: bobbinId,
      type: type,
      time: DateTime.now(),
    );
  }

  factory Action.fromJson(Map<String, dynamic> json) => _$ActionFromJson(json);

  Map<String, dynamic> toJson() => _$ActionToJson(this);

  static DateTime _dateFromJson(String date) => formatter.parse(date);

  static String _dateToJson(DateTime time) => formatter.format(time);

  LocalAction toLocalAction(bool isSuccess) {
    return LocalAction(
      id: id,
      userId: userId,
      bobbinId: bobbinId,
      type: type,
      time: time,
      isSynchronized: isSuccess,
    );
  }
}
