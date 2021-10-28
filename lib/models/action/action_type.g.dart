// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActionTypeAdapter extends TypeAdapter<ActionType> {
  @override
  final int typeId = 1;

  @override
  ActionType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ActionType.winding;
      case 1:
        return ActionType.output;
      case 2:
        return ActionType.isolation;
      case 3:
        return ActionType.molding;
      case 4:
        return ActionType.crimping;
      case 5:
        return ActionType.quality;
      case 6:
        return ActionType.testing;
      default:
        return ActionType.winding;
    }
  }

  @override
  void write(BinaryWriter writer, ActionType obj) {
    switch (obj) {
      case ActionType.winding:
        writer.writeByte(0);
        break;
      case ActionType.output:
        writer.writeByte(1);
        break;
      case ActionType.isolation:
        writer.writeByte(2);
        break;
      case ActionType.molding:
        writer.writeByte(3);
        break;
      case ActionType.crimping:
        writer.writeByte(4);
        break;
      case ActionType.quality:
        writer.writeByte(5);
        break;
      case ActionType.testing:
        writer.writeByte(6);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActionTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
