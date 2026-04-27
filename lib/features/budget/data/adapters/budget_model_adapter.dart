import 'package:hive_flutter/hive_flutter.dart';

import '../models/budget_model.dart';

class BudgetModelAdapter extends TypeAdapter<BudgetModel> {
  @override
  final int typeId = 15;

  @override
  BudgetModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return BudgetModel(
      amount: fields[0] as double,
      currency: fields[1] as String,
      isActive: fields[2] as bool,
      createdAt: fields[3] as DateTime?,
      updatedAt: fields[4] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, BudgetModel obj) {
    writer.writeByte(5);
    writer.writeByte(0);
    writer.writeDouble(obj.amount);
    writer.writeByte(1);
    writer.writeString(obj.currency);
    writer.writeByte(2);
    writer.writeBool(obj.isActive);
    writer.writeByte(3);
    writer.write(obj.createdAt);
    writer.writeByte(4);
    writer.write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BudgetModelAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
