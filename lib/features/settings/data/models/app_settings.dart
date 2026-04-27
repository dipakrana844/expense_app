import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
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
abstract class AppSettings with _$AppSettings {
  const factory AppSettings({
    // Expense Preferences
    @Default('₹') String defaultCurrency,

    @Default('Others') String defaultExpenseCategory,

    @Default(true) bool enableQuickExpense,

    @Default(true) bool enableGroceryOCR,

    // Grocery Settings
    @Default(true) bool saveLastStoreName,

    @Default(true) bool showFrequentItemSuggestions,

    @Default(false) bool clearGrocerySessionOnExit,

    @Default(true) bool confirmBeforeGrocerySubmit,

    // Smart Insights Controls
    @Default(true) bool enableSpendingIntelligence,

    @Default(InsightFrequency.weekly) InsightFrequency insightFrequency,

    // Security Settings
    @Default(false) bool enableAppLock,

    @Default(AutoLockTimer.thirtySeconds) AutoLockTimer autoLockTimer,

    @Default(true) bool requireAuthOnLaunch,

    // Data & Storage
    DateTime? lastExportDate,

    int? storageUsageBytes,

    // Metadata
    DateTime? createdAt,

    DateTime? lastModified,

    @Default(1) int version,
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
