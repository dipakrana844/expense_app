// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smart_entry_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

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
      metadata: (fields[13] as Map).cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, SmartEntryModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.modeIndex)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.note)
      ..writeByte(5)
      ..write(obj.category)
      ..writeByte(6)
      ..write(obj.source)
      ..writeByte(7)
      ..write(obj.fromAccount)
      ..writeByte(8)
      ..write(obj.toAccount)
      ..writeByte(9)
      ..write(obj.transferFee)
      ..writeByte(10)
      ..write(obj.isRecurring)
      ..writeByte(11)
      ..write(obj.createdAt)
      ..writeByte(12)
      ..write(obj.updatedAt)
      ..writeByte(13)
      ..write(obj.metadata);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SmartEntryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
