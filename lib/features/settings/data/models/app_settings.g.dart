// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

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
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.defaultCurrency)
      ..writeByte(1)
      ..write(obj.defaultExpenseCategory)
      ..writeByte(2)
      ..write(obj.enableQuickExpense)
      ..writeByte(3)
      ..write(obj.enableGroceryOCR)
      ..writeByte(4)
      ..write(obj.saveLastStoreName)
      ..writeByte(5)
      ..write(obj.showFrequentItemSuggestions)
      ..writeByte(6)
      ..write(obj.clearGrocerySessionOnExit)
      ..writeByte(7)
      ..write(obj.confirmBeforeGrocerySubmit)
      ..writeByte(8)
      ..write(obj.enableSpendingIntelligence)
      ..writeByte(9)
      ..write(obj.insightFrequency)
      ..writeByte(10)
      ..write(obj.enableAppLock)
      ..writeByte(11)
      ..write(obj.autoLockTimer)
      ..writeByte(12)
      ..write(obj.requireAuthOnLaunch)
      ..writeByte(13)
      ..write(obj.lastExportDate)
      ..writeByte(14)
      ..write(obj.storageUsageBytes)
      ..writeByte(15)
      ..write(obj.createdAt)
      ..writeByte(16)
      ..write(obj.lastModified)
      ..writeByte(17)
      ..write(obj.version);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppSettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class InsightFrequencyAdapter extends TypeAdapter<InsightFrequency> {
  @override
  final int typeId = 12;

  @override
  InsightFrequency read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return InsightFrequency.daily;
      case 1:
        return InsightFrequency.weekly;
      case 2:
        return InsightFrequency.monthly;
      default:
        return InsightFrequency.daily;
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

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InsightFrequencyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AutoLockTimerAdapter extends TypeAdapter<AutoLockTimer> {
  @override
  final int typeId = 13;

  @override
  AutoLockTimer read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return AutoLockTimer.immediate;
      case 1:
        return AutoLockTimer.thirtySeconds;
      case 2:
        return AutoLockTimer.oneMinute;
      case 3:
        return AutoLockTimer.fiveMinutes;
      default:
        return AutoLockTimer.immediate;
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

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AutoLockTimerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppSettingsImpl _$$AppSettingsImplFromJson(Map<String, dynamic> json) =>
    _$AppSettingsImpl(
      defaultCurrency: json['defaultCurrency'] as String? ?? '₹',
      defaultExpenseCategory:
          json['defaultExpenseCategory'] as String? ?? 'Others',
      enableQuickExpense: json['enableQuickExpense'] as bool? ?? true,
      enableGroceryOCR: json['enableGroceryOCR'] as bool? ?? true,
      saveLastStoreName: json['saveLastStoreName'] as bool? ?? true,
      showFrequentItemSuggestions:
          json['showFrequentItemSuggestions'] as bool? ?? true,
      clearGrocerySessionOnExit:
          json['clearGrocerySessionOnExit'] as bool? ?? false,
      confirmBeforeGrocerySubmit:
          json['confirmBeforeGrocerySubmit'] as bool? ?? true,
      enableSpendingIntelligence:
          json['enableSpendingIntelligence'] as bool? ?? true,
      insightFrequency: $enumDecodeNullable(
              _$InsightFrequencyEnumMap, json['insightFrequency']) ??
          InsightFrequency.weekly,
      enableAppLock: json['enableAppLock'] as bool? ?? false,
      autoLockTimer:
          $enumDecodeNullable(_$AutoLockTimerEnumMap, json['autoLockTimer']) ??
              AutoLockTimer.thirtySeconds,
      requireAuthOnLaunch: json['requireAuthOnLaunch'] as bool? ?? true,
      lastExportDate: json['lastExportDate'] == null
          ? null
          : DateTime.parse(json['lastExportDate'] as String),
      storageUsageBytes: (json['storageUsageBytes'] as num?)?.toInt(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      lastModified: json['lastModified'] == null
          ? null
          : DateTime.parse(json['lastModified'] as String),
      version: (json['version'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$$AppSettingsImplToJson(_$AppSettingsImpl instance) =>
    <String, dynamic>{
      'defaultCurrency': instance.defaultCurrency,
      'defaultExpenseCategory': instance.defaultExpenseCategory,
      'enableQuickExpense': instance.enableQuickExpense,
      'enableGroceryOCR': instance.enableGroceryOCR,
      'saveLastStoreName': instance.saveLastStoreName,
      'showFrequentItemSuggestions': instance.showFrequentItemSuggestions,
      'clearGrocerySessionOnExit': instance.clearGrocerySessionOnExit,
      'confirmBeforeGrocerySubmit': instance.confirmBeforeGrocerySubmit,
      'enableSpendingIntelligence': instance.enableSpendingIntelligence,
      'insightFrequency': _$InsightFrequencyEnumMap[instance.insightFrequency]!,
      'enableAppLock': instance.enableAppLock,
      'autoLockTimer': _$AutoLockTimerEnumMap[instance.autoLockTimer]!,
      'requireAuthOnLaunch': instance.requireAuthOnLaunch,
      'lastExportDate': instance.lastExportDate?.toIso8601String(),
      'storageUsageBytes': instance.storageUsageBytes,
      'createdAt': instance.createdAt?.toIso8601String(),
      'lastModified': instance.lastModified?.toIso8601String(),
      'version': instance.version,
    };

const _$InsightFrequencyEnumMap = {
  InsightFrequency.daily: 'daily',
  InsightFrequency.weekly: 'weekly',
  InsightFrequency.monthly: 'monthly',
};

const _$AutoLockTimerEnumMap = {
  AutoLockTimer.immediate: 'immediate',
  AutoLockTimer.thirtySeconds: 'thirtySeconds',
  AutoLockTimer.oneMinute: 'oneMinute',
  AutoLockTimer.fiveMinutes: 'fiveMinutes',
};
