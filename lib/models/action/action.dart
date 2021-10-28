import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:popper_mobile/models/action/action_type.dart';
import 'package:popper_mobile/models/action/local_action.dart';

part 'action.g.dart';

@immutable
@JsonSerializable()
// TODO - вернуть формат json
class Action {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'operatorId')
  final int userId;
  @JsonKey(name: 'bobbinId')
  final int bobbinId;
  @JsonKey(name: 'actionType')
  final ActionType type;
  @JsonKey(name: 'doneTime')
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
