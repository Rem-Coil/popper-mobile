// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Action _$ActionFromJson(Map<String, dynamic> json) => Action(
      id: json['id'] as int,
      userId: json['operator_id'] as int,
      bobbinId: json['bobbin_id'] as int,
      type: $enumDecode(_$ActionTypeEnumMap, json['action_type']),
      time: Action._dateFromJson(json['done_time'] as String),
    );

Map<String, dynamic> _$ActionToJson(Action instance) => <String, dynamic>{
      'id': instance.id,
      'operator_id': instance.userId,
      'bobbin_id': instance.bobbinId,
      'action_type': _$ActionTypeEnumMap[instance.type],
      'done_time': Action._dateToJson(instance.time),
    };

const _$ActionTypeEnumMap = {
  ActionType.winding: 'winding',
  ActionType.output: 'output',
  ActionType.isolation: 'isolation',
  ActionType.molding: 'molding',
  ActionType.crimping: 'crimping',
  ActionType.quality: 'quality',
  ActionType.testing: 'testing',
};
