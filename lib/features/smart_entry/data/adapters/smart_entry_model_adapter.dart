import 'package:hive_flutter/hive_flutter.dart';

import '../models/smart_entry_model.dart';

class SmartEntryModelAdapter extends TypeAdapter<SmartEntryModel> {
  @override
  final int typeId = 100;

  @override
  SmartEntryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return SmartEntryModel(
      id: fields[0] as String,
      modeIndex: fields[1] as int,
      amount: fields[2] as double,
      date: fields[3] as DateTime,
      note: fields[4] as String?,
      category: fields[5] as String?,
      source: fields[6] as String?,
      fromAccount: fields[7] as String?,
      toAccount: fields[8] as String?,
      transferFee: fields[9] as double?,
      isRecurring: fields[10] as bool,
      createdAt: fields[11] as DateTime,
      updatedAt: fields[12] as DateTime,
      metadata: fields[13] as Map<String, dynamic>,
    );
  }

  @override
  void write(BinaryWriter writer, SmartEntryModel obj) {
    writer.writeByte(14);
    writer.writeByte(0);
    writer.writeString(obj.id);
    writer.writeByte(1);
    writer.writeInt(obj.modeIndex);
    writer.writeByte(2);
    writer.writeDouble(obj.amount);
    writer.writeByte(3);
    writer.write(obj.date);
    writer.writeByte(4);
    writer.write(obj.note);
    writer.writeByte(5);
    writer.write(obj.category);
    writer.writeByte(6);
    writer.write(obj.source);
    writer.writeByte(7);
    writer.write(obj.fromAccount);
    writer.writeByte(8);
    writer.write(obj.toAccount);
    writer.writeByte(9);
    writer.write(obj.transferFee);
    writer.writeByte(10);
    writer.writeBool(obj.isRecurring);
    writer.writeByte(11);
    writer.write(obj.createdAt);
    writer.writeByte(12);
    writer.write(obj.updatedAt);
    writer.writeByte(13);
    writer.writeMap(obj.metadata);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SmartEntryModelAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
