// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppSettings _$AppSettingsFromJson(Map<String, dynamic> json) => _AppSettings(
  defaultCurrency: json['defaultCurrency'] as String? ?? '₹',
  defaultExpenseCategory: json['defaultExpenseCategory'] as String? ?? 'Others',
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
  insightFrequency:
      $enumDecodeNullable(
        _$InsightFrequencyEnumMap,
        json['insightFrequency'],
      ) ??
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

Map<String, dynamic> _$AppSettingsToJson(_AppSettings instance) =>
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
