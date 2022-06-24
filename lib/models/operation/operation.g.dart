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
      isSuccessful: fields[5] == null ? true : fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, OperationLocal obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.bobbin)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.time)
      ..writeByte(5)
      ..write(obj.isSuccessful);
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
      isSuccessful: json['successful'] as bool,
    );

Map<String, dynamic> _$OperationRemoteToJson(OperationRemote instance) =>
    <String, dynamic>{
      'id': instance.id,
      'operator_id': instance.userId,
      'bobbin_id': OperationRemote._bobbinToJson(instance.bobbin),
      'action_type': _$OperationTypeEnumMap[instance.type],
      'done_time': OperationRemote._dateToJson(instance.time),
      'successful': instance.isSuccessful,
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

FullOperation _$FullOperationFromJson(Map<String, dynamic> json) =>
    FullOperation(
      bobbinId: json['bobbinId'] as int,
      bobbinNumber: json['bobbin_number'] as String,
      firstName: json['firstname'] as String,
      secondName: json['second_name'] as String,
      surname: json['surname'] as String,
      type: $enumDecode(_$OperationTypeEnumMap, json['action_type']),
      time: FullOperation._dateFromJson(json['done_time'] as String),
      isSuccessful: json['successful'] as bool,
    );

Map<String, dynamic> _$FullOperationToJson(FullOperation instance) =>
    <String, dynamic>{
      'bobbinId': instance.bobbinId,
      'bobbin_number': instance.bobbinNumber,
      'firstname': instance.firstName,
      'second_name': instance.secondName,
      'surname': instance.surname,
      'action_type': _$OperationTypeEnumMap[instance.type],
      'done_time': FullOperation._dateToJson(instance.time),
      'successful': instance.isSuccessful,
    };
