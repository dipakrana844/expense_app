import 'package:hive_flutter/hive_flutter.dart';

import '../models/income_model.dart';

class IncomeModelAdapter extends TypeAdapter<IncomeModel> {
  @override
  final int typeId = 7;

  @override
  IncomeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return IncomeModel(
      id: fields[0] as String,
      amount: fields[1] as double,
      source: fields[2] as String,
      date: fields[3] as DateTime,
      note: fields[4] as String?,
      createdAt: fields[5] as DateTime,
      updatedAt: fields[6] as DateTime?,
      metadata: fields[7] as Map<String, dynamic>?,
    );
  }

  @override
  void write(BinaryWriter writer, IncomeModel obj) {
    writer.writeByte(8);
    writer.writeByte(0);
    writer.writeString(obj.id);
    writer.writeByte(1);
    writer.writeDouble(obj.amount);
    writer.writeByte(2);
    writer.writeString(obj.source);
    writer.writeByte(3);
    writer.write(obj.date);
    writer.writeByte(4);
    writer.write(obj.note);
    writer.writeByte(5);
    writer.write(obj.createdAt);
    writer.writeByte(6);
    writer.write(obj.updatedAt);
    writer.writeByte(7);
    writer.write(obj.metadata);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IncomeModelAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
