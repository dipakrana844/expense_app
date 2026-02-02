// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insight_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InsightModelAdapter extends TypeAdapter<InsightModel> {
  @override
  final int typeId = 2;

  @override
  InsightModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InsightModel(
      id: fields[0] as String,
      type: fields[1] as String,
      severity: fields[2] as String,
      title: fields[3] as String,
      message: fields[4] as String,
      createdDate: fields[5] as DateTime,
      isRead: fields[6] as bool,
      metadata: (fields[7] as Map?)?.cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, InsightModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.severity)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.message)
      ..writeByte(5)
      ..write(obj.createdDate)
      ..writeByte(6)
      ..write(obj.isRead)
      ..writeByte(7)
      ..write(obj.metadata);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InsightModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
