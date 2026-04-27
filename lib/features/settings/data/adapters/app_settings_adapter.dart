import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_expense_tracker/features/settings/domain/entities/app_settings_entity.dart';

import '../models/app_settings.dart';

class AppSettingsAdapter extends TypeAdapter<AppSettings> {
  @override
  final int typeId = 11;

  @override
  AppSettings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return AppSettings(
      defaultCurrency: fields[0] as String,
      defaultExpenseCategory: fields[1] as String,
      enableQuickExpense: fields[2] as bool,
      enableGroceryOCR: fields[3] as bool,
      saveLastStoreName: fields[4] as bool,
      showFrequentItemSuggestions: fields[5] as bool,
      clearGrocerySessionOnExit: fields[6] as bool,
      confirmBeforeGrocerySubmit: fields[7] as bool,
      enableSpendingIntelligence: fields[8] as bool,
      insightFrequency: fields[9] as InsightFrequency,
      enableAppLock: fields[10] as bool,
      autoLockTimer: fields[11] as AutoLockTimer,
      requireAuthOnLaunch: fields[12] as bool,
      lastExportDate: fields[13] as DateTime?,
      storageUsageBytes: fields[14] as int?,
      createdAt: fields[15] as DateTime?,
      lastModified: fields[16] as DateTime?,
      version: fields[17] as int,
    );
  }

  @override
  void write(BinaryWriter writer, AppSettings obj) {
    writer.writeByte(18);
    writer.writeByte(0);
    writer.writeString(obj.defaultCurrency);
    writer.writeByte(1);
    writer.writeString(obj.defaultExpenseCategory);
    writer.writeByte(2);
    writer.writeBool(obj.enableQuickExpense);
    writer.writeByte(3);
    writer.writeBool(obj.enableGroceryOCR);
    writer.writeByte(4);
    writer.writeBool(obj.saveLastStoreName);
    writer.writeByte(5);
    writer.writeBool(obj.showFrequentItemSuggestions);
    writer.writeByte(6);
    writer.writeBool(obj.clearGrocerySessionOnExit);
    writer.writeByte(7);
    writer.writeBool(obj.confirmBeforeGrocerySubmit);
    writer.writeByte(8);
    writer.writeBool(obj.enableSpendingIntelligence);
    writer.writeByte(9);
    writer.write(obj.insightFrequency);
    writer.writeByte(10);
    writer.writeBool(obj.enableAppLock);
    writer.writeByte(11);
    writer.write(obj.autoLockTimer);
    writer.writeByte(12);
    writer.writeBool(obj.requireAuthOnLaunch);
    writer.writeByte(13);
    writer.write(obj.lastExportDate);
    writer.writeByte(14);
    writer.write(obj.storageUsageBytes);
    writer.writeByte(15);
    writer.write(obj.createdAt);
    writer.writeByte(16);
    writer.write(obj.lastModified);
    writer.writeByte(17);
    writer.writeInt(obj.version);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppSettingsAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
