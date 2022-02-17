// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operation.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OperationLocalAdapter extends TypeAdapter<OperationLocal> {
  @override
  final int typeId = 3;

  @override
  OperationLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OperationLocal(
      id: fields[0] as int,
      userId: fields[1] as int,
      bobbin: fields[2] as BobbinLocal,
      type: fields[3] as OperationType?,
      time: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, OperationLocal obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.bobbin)
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
      other is OperationLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OperationRemote _$OperationRemoteFromJson(Map<String, dynamic> json) =>
    OperationRemote(
      id: json['id'] as int,
      userId: json['operator_id'] as int,
      bobbin: OperationRemote._bobbinFromJson(json['bobbin_id'] as int),
      type: $enumDecode(_$OperationTypeEnumMap, json['action_type']),
      time: OperationRemote._dateFromJson(json['done_time'] as String),
    );

Map<String, dynamic> _$OperationRemoteToJson(OperationRemote instance) =>
    <String, dynamic>{
      'id': instance.id,
      'operator_id': instance.userId,
      'bobbin_id': OperationRemote._bobbinToJson(instance.bobbin),
      'action_type': _$OperationTypeEnumMap[instance.type],
      'done_time': OperationRemote._dateToJson(instance.time),
    };

const _$OperationTypeEnumMap = {
  OperationType.winding: 'winding',
  OperationType.output: 'output',
  OperationType.isolation: 'isolation',
  OperationType.molding: 'molding',
  OperationType.crimping: 'crimping',
  OperationType.quality: 'quality',
  OperationType.testing: 'testing',
};
