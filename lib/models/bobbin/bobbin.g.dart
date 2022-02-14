// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bobbin.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BobbinLocalAdapter extends TypeAdapter<BobbinLocal> {
  @override
  final int typeId = 2;

  @override
  BobbinLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BobbinLocal(
      bobbinNumber: fields[2] as String,
      id: fields[0] as int,
      taskId: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, BobbinLocal obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.taskId)
      ..writeByte(2)
      ..write(obj.bobbinNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BobbinLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BobbinRemote _$BobbinRemoteFromJson(Map<String, dynamic> json) => BobbinRemote(
      id: json['id'] as int,
      taskId: json['task_id'] as int,
      bobbinNumber: json['bobbin_number'] as String,
    );
