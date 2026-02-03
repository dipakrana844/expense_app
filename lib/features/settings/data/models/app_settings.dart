import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

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
@freezed
@HiveType(typeId: 11)
class AppSettings with _$AppSettings {
  const factory AppSettings({
    // Expense Preferences
    @HiveField(0)
    @Default('₹')
    String defaultCurrency,

    @HiveField(1)
    @Default('Others')
    String defaultExpenseCategory,

    @HiveField(2)
    @Default(true)
    bool enableQuickExpense,

    @HiveField(3)
    @Default(true)
    bool enableGroceryOCR,

    // Grocery Settings
    @HiveField(4)
    @Default(true)
    bool saveLastStoreName,

    @HiveField(5)
    @Default(true)
    bool showFrequentItemSuggestions,

    @HiveField(6)
    @Default(false)
    bool clearGrocerySessionOnExit,

    @HiveField(7)
    @Default(true)
    bool confirmBeforeGrocerySubmit,

    // Smart Insights Controls
    @HiveField(8)
    @Default(true)
    bool enableSpendingIntelligence,

    @HiveField(9)
    @Default(InsightFrequency.weekly)
    InsightFrequency insightFrequency,

    // Security Settings
    @HiveField(10)
    @Default(false)
    bool enableAppLock,

    @HiveField(11)
    @Default(AutoLockTimer.thirtySeconds)
    AutoLockTimer autoLockTimer,

    @HiveField(12)
    @Default(true)
    bool requireAuthOnLaunch,

    // Data & Storage
    @HiveField(13)
    DateTime? lastExportDate,

    @HiveField(14)
    int? storageUsageBytes,

    // Metadata
    @HiveField(15)
    DateTime? createdAt,

    @HiveField(16)
    DateTime? lastModified,

    @HiveField(17)
    @Default(1)
    int version,
  }) = _AppSettings;

  factory AppSettings.fromJson(Map<String, dynamic> json) =>
      _$AppSettingsFromJson(json);
}

/// Frequency for spending insights generation
@HiveType(typeId: 12)
enum InsightFrequency {
  @HiveField(0)
  daily,

  @HiveField(1)
  weekly,

  @HiveField(2)
  monthly,
}

/// Auto-lock timer options
@HiveType(typeId: 13)
enum AutoLockTimer {
  @HiveField(0)
  immediate,

  @HiveField(1)
  thirtySeconds,

  @HiveField(2)
  oneMinute,

  @HiveField(3)
  fiveMinutes,
}