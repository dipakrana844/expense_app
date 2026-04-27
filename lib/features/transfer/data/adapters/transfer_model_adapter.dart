import 'package:hive_flutter/hive_flutter.dart';

import '../models/transfer_model.dart';

class TransferModelAdapter extends TypeAdapter<TransferModel> {
  @override
  final int typeId = 4;

  @override
  TransferModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return TransferModel(
      id: fields[0] as String,
      amount: fields[1] as double,
      fromAccount: fields[2] as String,
      toAccount: fields[3] as String,
      date: fields[4] as DateTime,
      fee: fields[5] as double,
      note: fields[6] as String?,
      createdAt: fields[7] as DateTime,
      updatedAt: fields[8] as DateTime?,
      metadata: fields[9] as Map<String, dynamic>?,
    );
  }

  @override
  void write(BinaryWriter writer, TransferModel obj) {
    writer.writeByte(10);
    writer.writeByte(0);
    writer.writeString(obj.id);
    writer.writeByte(1);
    writer.writeDouble(obj.amount);
    writer.writeByte(2);
    writer.writeString(obj.fromAccount);
    writer.writeByte(3);
    writer.writeString(obj.toAccount);
    writer.writeByte(4);
    writer.write(obj.date);
    writer.writeByte(5);
    writer.writeDouble(obj.fee);
    writer.writeByte(6);
    writer.write(obj.note);
    writer.writeByte(7);
    writer.write(obj.createdAt);
    writer.writeByte(8);
    writer.write(obj.updatedAt);
    writer.writeByte(9);
    writer.write(obj.metadata);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransferModelAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
