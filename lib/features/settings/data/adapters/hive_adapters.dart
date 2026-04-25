import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/entities/app_settings_entity.dart';

/// Hive Type Adapters for Domain Enums
///
/// These adapters allow domain enums to be stored in Hive without
/// duplicating enum definitions in the data layer.

/// Adapter for InsightFrequency enum
class InsightFrequencyAdapter extends TypeAdapter<InsightFrequency> {
  @override
  final int typeId = 12;

  @override
  InsightFrequency read(BinaryReader reader) {
    final index = reader.readByte();
    switch (index) {
      case 0:
        return InsightFrequency.daily;
      case 1:
        return InsightFrequency.weekly;
      case 2:
        return InsightFrequency.monthly;
      default:
        throw ArgumentError('Invalid InsightFrequency index: $index');
    }
  }

  @override
  void write(BinaryWriter writer, InsightFrequency obj) {
    switch (obj) {
      case InsightFrequency.daily:
        writer.writeByte(0);
        break;
      case InsightFrequency.weekly:
        writer.writeByte(1);
        break;
      case InsightFrequency.monthly:
        writer.writeByte(2);
        break;
    }
  }
}

/// Adapter for AutoLockTimer enum
class AutoLockTimerAdapter extends TypeAdapter<AutoLockTimer> {
  @override
  final int typeId = 13;

  @override
  AutoLockTimer read(BinaryReader reader) {
    final index = reader.readByte();
    switch (index) {
      case 0:
        return AutoLockTimer.immediate;
      case 1:
        return AutoLockTimer.thirtySeconds;
      case 2:
        return AutoLockTimer.oneMinute;
      case 3:
        return AutoLockTimer.fiveMinutes;
      default:
        throw ArgumentError('Invalid AutoLockTimer index: $index');
    }
  }

  @override
  void write(BinaryWriter writer, AutoLockTimer obj) {
    switch (obj) {
      case AutoLockTimer.immediate:
        writer.writeByte(0);
        break;
      case AutoLockTimer.thirtySeconds:
        writer.writeByte(1);
        break;
      case AutoLockTimer.oneMinute:
        writer.writeByte(2);
        break;
      case AutoLockTimer.fiveMinutes:
        writer.writeByte(3);
        break;
    }
  }
}
