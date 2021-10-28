// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_action.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalActionAdapter extends TypeAdapter<LocalAction> {
  @override
  final int typeId = 0;

  @override
  LocalAction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalAction(
      id: fields[0] as int,
      userId: fields[1] as int,
      bobbinId: fields[2] as int,
      type: fields[3] as ActionType,
      time: fields[4] as DateTime,
      isSynchronized: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, LocalAction obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.bobbinId)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.time)
      ..writeByte(5)
      ..write(obj.isSynchronized);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalActionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
