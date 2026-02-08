// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_spend_state.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

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
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.todaySpent)
      ..writeByte(1)
      ..write(obj.dailyLimit)
      ..writeByte(2)
      ..write(obj.remaining)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.lastUpdated);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailySpendStateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SpendStatusAdapter extends TypeAdapter<SpendStatus> {
  @override
  final int typeId = 6;

  @override
  SpendStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SpendStatus.safe;
      case 1:
        return SpendStatus.caution;
      case 2:
        return SpendStatus.exceeded;
      default:
        return SpendStatus.safe;
    }
  }

  @override
  void write(BinaryWriter writer, SpendStatus obj) {
    switch (obj) {
      case SpendStatus.safe:
        writer.writeByte(0);
        break;
      case SpendStatus.caution:
        writer.writeByte(1);
        break;
      case SpendStatus.exceeded:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpendStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
