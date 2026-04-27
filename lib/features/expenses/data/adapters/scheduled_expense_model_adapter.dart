import 'package:hive_flutter/hive_flutter.dart';

import '../models/scheduled_expense_model.dart';

class ScheduledExpenseModelAdapter extends TypeAdapter<ScheduledExpenseModel> {
  @override
  final int typeId = 1;

  @override
  ScheduledExpenseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return ScheduledExpenseModel(
      id: fields[0] as String,
      amount: fields[1] as double,
      category: fields[2] as String,
      dayOfMonth: fields[3] as int,
      nextRunDate: fields[4] as DateTime,
      note: fields[5] as String?,
      isActive: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ScheduledExpenseModel obj) {
    writer.writeByte(7);
    writer.writeByte(0);
    writer.writeString(obj.id);
    writer.writeByte(1);
    writer.writeDouble(obj.amount);
    writer.writeByte(2);
    writer.writeString(obj.category);
    writer.writeByte(3);
    writer.writeInt(obj.dayOfMonth);
    writer.writeByte(4);
    writer.write(obj.nextRunDate);
    writer.writeByte(5);
    writer.write(obj.note);
    writer.writeByte(6);
    writer.writeBool(obj.isActive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScheduledExpenseModelAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
