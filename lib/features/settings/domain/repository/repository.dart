import 'package:smart_expense_tracker/core/error/failures.dart';
import '../entities/app_settings_entity.dart';

abstract class SettingsRepository {
  /// Get current application settings.
  /// Returns a tuple of (settings, failure).
  /// If no settings are stored, returns default settings with null failure.
  Future<(AppSettingsEntity?, Failure?)> getSettings();

  /// Save application settings.
  /// Returns a failure if something goes wrong, otherwise null.
  Future<Failure?> saveSettings(AppSettingsEntity settings);

  /// Update specific settings fields.
  /// Returns a failure if something goes wrong, otherwise null.
  Future<Failure?> updateSettings({
    String? defaultCurrency,
    String? defaultExpenseCategory,
    bool? enableQuickExpense,
    bool? enableGroceryOCR,
    bool? saveLastStoreName,
    bool? showFrequentItemSuggestions,
    bool? clearGrocerySessionOnExit,
    bool? confirmBeforeGrocerySubmit,
    bool? enableSpendingIntelligence,
    InsightFrequency? insightFrequency,
    bool? enableAppLock,
    AutoLockTimer? autoLockTimer,
    bool? requireAuthOnLaunch,
  });

  /// Reset all settings to defaults.
  /// Returns a failure if something goes wrong, otherwise null.
  Future<Failure?> resetToDefaults();

  /// Update storage usage information.
  /// Returns a failure if something goes wrong, otherwise null.
  Future<Failure?> updateStorageUsage(int bytes);

  /// Update last export date.
  /// Returns a failure if something goes wrong, otherwise null.
  Future<Failure?> updateLastExportDate(DateTime date);

  /// Calculate actual storage usage across all app data.
  /// Returns a tuple of (bytes, failure).
  Future<(int?, Failure?)> calculateActualStorageUsage();

  /// Get current storage usage (cached value).
  /// Returns a tuple of (bytes, failure).
  Future<(int?, Failure?)> getStorageSize();

  /// Force recalculate and update storage usage.
  /// Returns a failure if something goes wrong, otherwise null.
  Future<Failure?> recalculateAndSaveStorageUsage();
}
