import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'action.g.dart';

@immutable
@JsonSerializable()
class Action {
  @JsonKey(name: 'operator_id')
  final int userId;
  @JsonKey(name: 'bobbin_id')
  final int bobbinId;
  @JsonKey(name: 'action_type')
  final ActionType type;

  Action(this.userId, this.bobbinId, this.type);

  factory Action.fromJson(Map<String, dynamic> json) =>
      _$ActionFromJson(json);

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