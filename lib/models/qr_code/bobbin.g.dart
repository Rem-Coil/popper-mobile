// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bobbin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bobbin _$BobbinFromJson(Map<String, dynamic> json) {
  return Bobbin(
    json['id'] as int,
    json['task_id'] as int,
    json['bobbin_number'] as String,
  );
}

Map<String, dynamic> _$BobbinToJson(Bobbin instance) => <String, dynamic>{
      'id': instance.id,
      'task_id': instance.taskId,
      'bobbin_number': instance.bobbinNumber,
    };
