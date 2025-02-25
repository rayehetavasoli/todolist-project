// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskEnumAdapter extends TypeAdapter<TaskEnum> {
  @override
  final int typeId = 6;

  @override
  TaskEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TaskEnum.banking;
      case 1:
        return TaskEnum.working;
      case 2:
        return TaskEnum.focusing;
      case 3:
        return TaskEnum.commuting;
      case 4:
        return TaskEnum.dating;
      case 5:
        return TaskEnum.training;
      default:
        return TaskEnum.banking;
    }
  }

  @override
  void write(BinaryWriter writer, TaskEnum obj) {
    switch (obj) {
      case TaskEnum.banking:
        writer.writeByte(0);
        break;
      case TaskEnum.working:
        writer.writeByte(1);
        break;
      case TaskEnum.focusing:
        writer.writeByte(2);
        break;
      case TaskEnum.commuting:
        writer.writeByte(3);
        break;
      case TaskEnum.dating:
        writer.writeByte(4);
        break;
      case TaskEnum.training:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
