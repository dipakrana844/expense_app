import 'package:hive_flutter/hive_flutter.dart';

import '../models/daily_spend_state.dart';

class DailySpendStateAdapter extends TypeAdapter<DailySpendState> {
  @override
  final int typeId = 5;

  @override
  DailySpendState read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return DailySpendState(
      todaySpent: fields[0] as double,
      dailyLimit: fields[1] as double,
      remaining: fields[2] as double,
      status: fields[3] as SpendStatus,
      lastUpdated: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, DailySpendState obj) {
    writer.writeByte(5);
    writer.writeByte(0);
    writer.writeDouble(obj.todaySpent);
    writer.writeByte(1);
    writer.writeDouble(obj.dailyLimit);
    writer.writeByte(2);
    writer.writeDouble(obj.remaining);
    writer.writeByte(3);
    writer.write(obj.status);
    writer.writeByte(4);
    writer.write(obj.lastUpdated);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailySpendStateAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}

class SpendStatusAdapter extends TypeAdapter<SpendStatus> {
  @override
  final int typeId = 6;

  @override
  SpendStatus read(BinaryReader reader) {
    final index = reader.readByte();
    return SpendStatus.values[index];
  }

  @override
  void write(BinaryWriter writer, SpendStatus obj) {
    writer.writeByte(obj.index);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpendStatusAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
