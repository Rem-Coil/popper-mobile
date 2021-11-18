import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bobbin.g.dart';

@immutable
@JsonSerializable()
class Bobbin {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'task_id')
  final int taskId;
  @JsonKey(name: 'bobbin_number')
  final String bobbinNumber;

  Bobbin(this.id, this.taskId, this.bobbinNumber);

  factory Bobbin.fromJson(Map<String, dynamic> json) => _$BobbinFromJson(json);

  Map<String, dynamic> toJson() => _$BobbinToJson(this);
}