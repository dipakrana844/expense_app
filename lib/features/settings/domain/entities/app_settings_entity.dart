import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_settings_entity.freezed.dart';

/// Domain entity representing application settings.
/// This is a pure domain object without any data-layer dependencies.
@freezed
class AppSettingsEntity with _$AppSettingsEntity {
  const AppSettingsEntity._();

  const factory AppSettingsEntity({
    // Expense Preferences
    required String defaultCurrency,
    required String defaultExpenseCategory,
    required bool enableQuickExpense,
    required bool enableGroceryOCR,

    // Grocery Settings
    required bool saveLastStoreName,
    required bool showFrequentItemSuggestions,
    required bool clearGrocerySessionOnExit,
    required bool confirmBeforeGrocerySubmit,

    // Smart Insights Controls
    required bool enableSpendingIntelligence,
    required InsightFrequency insightFrequency,

    // Security Settings
    required bool enableAppLock,
    required AutoLockTimer autoLockTimer,
    required bool requireAuthOnLaunch,

    // Data & Storage
    DateTime? lastExportDate,
    int? storageUsageBytes,

    // Metadata
    DateTime? createdAt,
    DateTime? lastModified,
    required int version,
  }) = _AppSettingsEntity;

  /// Returns default settings entity.
  /// This is a factory method that provides sensible defaults.
  /// Used when no settings are stored yet.
  factory AppSettingsEntity.defaults() => const AppSettingsEntity(
    defaultCurrency: '₹',
    defaultExpenseCategory: 'Others',
    enableQuickExpense: true,
    enableGroceryOCR: true,
    saveLastStoreName: true,
    showFrequentItemSuggestions: true,
    clearGrocerySessionOnExit: false,
    confirmBeforeGrocerySubmit: true,
    enableSpendingIntelligence: true,
    insightFrequency: InsightFrequency.weekly,
    enableAppLock: false,
    autoLockTimer: AutoLockTimer.thirtySeconds,
    requireAuthOnLaunch: true,
    lastExportDate: null,
    storageUsageBytes: null,
    createdAt: null,
    lastModified: null,
    version: 1,
  );

  /// Whether the app lock is enabled and requires authentication.
  bool get requiresAuthentication => enableAppLock && requireAuthOnLaunch;

  /// Whether storage usage has been calculated recently (within 1 hour).
  bool get isStorageUsageRecent {
    if (lastModified == null || storageUsageBytes == null) return false;
    final diff = DateTime.now().difference(lastModified!);
    return diff.inHours < 1;
  }
}

/// Frequency for spending insights generation (domain enum)
enum InsightFrequency { daily, weekly, monthly }

/// Auto-lock timer options (domain enum)
enum AutoLockTimer { immediate, thirtySeconds, oneMinute, fiveMinutes }
