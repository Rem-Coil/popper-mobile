// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActionLocalAdapter extends TypeAdapter<ActionLocal> {
  @override
  final int typeId = 0;

  @override
  ActionLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ActionLocal(
      id: fields[0] as int?,
      userId: fields[1] as int,
      bobbinId: fields[2] as int,
      type: fields[3] as ActionType,
      time: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ActionLocal obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.bobbinId)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActionLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActionRemote _$ActionRemoteFromJson(Map<String, dynamic> json) => ActionRemote(
      id: json['id'] as int?,
      userId: json['operator_id'] as int,
      bobbinId: json['bobbin_id'] as int,
      type: $enumDecode(_$ActionTypeEnumMap, json['action_type']),
      time: ActionRemote._dateFromJson(json['done_time'] as String),
    );

Map<String, dynamic> _$ActionRemoteToJson(ActionRemote instance) =>
    <String, dynamic>{
      'id': instance.id,
      'operator_id': instance.userId,
      'bobbin_id': instance.bobbinId,
      'action_type': _$ActionTypeEnumMap[instance.type],
      'done_time': ActionRemote._dateToJson(instance.time),
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
