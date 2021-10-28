import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

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
  // TODO - вернуть время
  @JsonKey(name: 'doneTime')
  final String time;

  Action({
    this.id = 0,
    required this.userId,
    required this.bobbinId,
    required this.type,
    this.time = '',
  });

  factory Action.fromJson(Map<String, dynamic> json) => _$ActionFromJson(json);

  Map<String, dynamic> toJson() => _$ActionToJson(this);
}

enum ActionType {
  winding,
  output,
  isolation,
  molding,
  crimping,
  quality,
  testing
}
