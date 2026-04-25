import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/entities/app_settings_entity.dart';

part 'app_settings.freezed.dart';
part 'app_settings.g.dart';

/// Application Settings Model
///
/// Comprehensive settings model covering all configurable aspects of the app:
/// - Expense preferences
/// - Grocery settings
/// - Security configuration
/// - Smart insights controls
/// - Data management options
///
/// This is the data layer model that maps to Hive storage.
/// Domain enums are used directly to avoid duplication.
@freezed
@HiveType(typeId: 11)
class AppSettings with _$AppSettings {
  const factory AppSettings({
    // Expense Preferences
    @HiveField(0) @Default('₹') String defaultCurrency,

    @HiveField(1) @Default('Others') String defaultExpenseCategory,

    @HiveField(2) @Default(true) bool enableQuickExpense,

    @HiveField(3) @Default(true) bool enableGroceryOCR,

    // Grocery Settings
    @HiveField(4) @Default(true) bool saveLastStoreName,

    @HiveField(5) @Default(true) bool showFrequentItemSuggestions,

    @HiveField(6) @Default(false) bool clearGrocerySessionOnExit,

    @HiveField(7) @Default(true) bool confirmBeforeGrocerySubmit,

    // Smart Insights Controls
    @HiveField(8) @Default(true) bool enableSpendingIntelligence,

    @HiveField(9)
    @Default(InsightFrequency.weekly)
    InsightFrequency insightFrequency,

    // Security Settings
    @HiveField(10) @Default(false) bool enableAppLock,

    @HiveField(11)
    @Default(AutoLockTimer.thirtySeconds)
    AutoLockTimer autoLockTimer,

    @HiveField(12) @Default(true) bool requireAuthOnLaunch,

    // Data & Storage
    @HiveField(13) DateTime? lastExportDate,

    @HiveField(14) int? storageUsageBytes,

    // Metadata
    @HiveField(15) DateTime? createdAt,

    @HiveField(16) DateTime? lastModified,

    @HiveField(17) @Default(1) int version,
  }) = _AppSettings;

  factory AppSettings.fromJson(Map<String, dynamic> json) =>
      _$AppSettingsFromJson(json);

  /// Convert domain entity to data model
  factory AppSettings.fromEntity(AppSettingsEntity entity) {
    return AppSettings(
      defaultCurrency: entity.defaultCurrency,
      defaultExpenseCategory: entity.defaultExpenseCategory,
      enableQuickExpense: entity.enableQuickExpense,
      enableGroceryOCR: entity.enableGroceryOCR,
      saveLastStoreName: entity.saveLastStoreName,
      showFrequentItemSuggestions: entity.showFrequentItemSuggestions,
      clearGrocerySessionOnExit: entity.clearGrocerySessionOnExit,
      confirmBeforeGrocerySubmit: entity.confirmBeforeGrocerySubmit,
      enableSpendingIntelligence: entity.enableSpendingIntelligence,
      insightFrequency: entity.insightFrequency,
      enableAppLock: entity.enableAppLock,
      autoLockTimer: entity.autoLockTimer,
      requireAuthOnLaunch: entity.requireAuthOnLaunch,
      lastExportDate: entity.lastExportDate,
      storageUsageBytes: entity.storageUsageBytes,
      createdAt: entity.createdAt,
      lastModified: entity.lastModified,
      version: entity.version,
    );
  }
}

/// Extension to add toEntity method to AppSettings
extension AppSettingsX on AppSettings {
  /// Convert data model to domain entity
  AppSettingsEntity toEntity() {
    return AppSettingsEntity(
      defaultCurrency: defaultCurrency,
      defaultExpenseCategory: defaultExpenseCategory,
      enableQuickExpense: enableQuickExpense,
      enableGroceryOCR: enableGroceryOCR,
      saveLastStoreName: saveLastStoreName,
      showFrequentItemSuggestions: showFrequentItemSuggestions,
      clearGrocerySessionOnExit: clearGrocerySessionOnExit,
      confirmBeforeGrocerySubmit: confirmBeforeGrocerySubmit,
      enableSpendingIntelligence: enableSpendingIntelligence,
      insightFrequency: insightFrequency,
      enableAppLock: enableAppLock,
      autoLockTimer: autoLockTimer,
      requireAuthOnLaunch: requireAuthOnLaunch,
      lastExportDate: lastExportDate,
      storageUsageBytes: storageUsageBytes,
      createdAt: createdAt,
      lastModified: lastModified,
      version: version,
    );
  }
}
