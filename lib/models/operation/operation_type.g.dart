// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operation_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OperationTypeAdapter extends TypeAdapter<OperationType> {
  @override
  final int typeId = 1;

  @override
  OperationType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return OperationType.winding;
      case 1:
        return OperationType.output;
      case 2:
        return OperationType.isolation;
      case 3:
        return OperationType.molding;
      case 4:
        return OperationType.crimping;
      case 5:
        return OperationType.quality;
      case 6:
        return OperationType.testing;
      default:
        return OperationType.winding;
    }
  }

  @override
  void write(BinaryWriter writer, OperationType obj) {
    switch (obj) {
      case OperationType.winding:
        writer.writeByte(0);
        break;
      case OperationType.output:
        writer.writeByte(1);
        break;
      case OperationType.isolation:
        writer.writeByte(2);
        break;
      case OperationType.molding:
        writer.writeByte(3);
        break;
      case OperationType.crimping:
        writer.writeByte(4);
        break;
      case OperationType.quality:
        writer.writeByte(5);
        break;
      case OperationType.testing:
        writer.writeByte(6);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is OperationTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
