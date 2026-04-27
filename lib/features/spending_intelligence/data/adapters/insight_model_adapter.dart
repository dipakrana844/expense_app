import 'package:hive_flutter/hive_flutter.dart';

import '../models/insight_model.dart';

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
      metadata: fields[7] as Map<String, dynamic>?,
    );
  }

  @override
  void write(BinaryWriter writer, InsightModel obj) {
    writer.writeByte(8);
    writer.writeByte(0);
    writer.writeString(obj.id);
    writer.writeByte(1);
    writer.writeString(obj.type);
    writer.writeByte(2);
    writer.writeString(obj.severity);
    writer.writeByte(3);
    writer.writeString(obj.title);
    writer.writeByte(4);
    writer.writeString(obj.message);
    writer.writeByte(5);
    writer.write(obj.createdDate);
    writer.writeByte(6);
    writer.writeBool(obj.isRead);
    writer.writeByte(7);
    writer.write(obj.metadata);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InsightModelAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
