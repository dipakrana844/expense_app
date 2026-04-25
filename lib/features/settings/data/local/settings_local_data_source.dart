import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/constants/app_constants.dart';
import '../models/app_settings.dart';
import '../adapters/hive_adapters.dart' as adapters;
import '../../domain/entities/app_settings_entity.dart';

/// Local Data Source for Application Settings
///
/// Manages persistence of all application settings using Hive.
/// Provides CRUD operations and default settings management.
class SettingsLocalDataSource {
  late Box<AppSettings> _settingsBox;
  bool _isInitialized = false;
  static const String _boxName = AppConstants.settingsBoxName;
  static const String _settingsKey = 'app_settings';

  /// Initialize Hive and open settings box
  Future<void> init() async {
    if (_isInitialized) return;

    try {
      // Ensure Hive is initialized
      await Hive.initFlutter();

      // Register adapters if not already registered
      if (!Hive.isAdapterRegistered(11)) {
        Hive.registerAdapter(AppSettingsAdapter());
      }
      if (!Hive.isAdapterRegistered(12)) {
        Hive.registerAdapter(adapters.InsightFrequencyAdapter());
      }
      if (!Hive.isAdapterRegistered(13)) {
        Hive.registerAdapter(adapters.AutoLockTimerAdapter());
      }

      // Open box
      _settingsBox = await Hive.openBox<AppSettings>(_boxName);

      _isInitialized = true;
    } catch (e) {
      debugPrint('Failed to initialize Settings Hive box: $e');
      rethrow;
    }
  }

  /// Get current application settings
  ///
  /// Returns default settings if none exist or if not initialized
  AppSettings getSettings() {
    if (!_isInitialized) {
      // Return default settings if not initialized
      return _getDefaultSettings();
    }
    try {
      return _settingsBox.get(_settingsKey) ?? _getDefaultSettings();
    } catch (e) {
      // Return defaults if there's an error accessing the box
      debugPrint('Error reading settings: $e');
      return _getDefaultSettings();
    }
  }

  /// Save application settings
  Future<void> saveSettings(AppSettings settings) async {
    if (!_isInitialized) {
      debugPrint('Settings data source not initialized, cannot save settings');
      return;
    }
    try {
      final updated = settings.copyWith(lastModified: DateTime.now());
      await _settingsBox.put(_settingsKey, updated);
    } catch (e) {
      debugPrint('Failed to save settings: $e');
      // Don't throw - just log the error
    }
  }

  /// Update specific settings fields
  Future<void> updateSettings({
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
  }) async {
    if (!_isInitialized) {
      debugPrint(
        'Settings data source not initialized, cannot update settings',
      );
      return;
    }

    try {
      final current = getSettings();
      final updated = current.copyWith(
        defaultCurrency: defaultCurrency ?? current.defaultCurrency,
        defaultExpenseCategory:
            defaultExpenseCategory ?? current.defaultExpenseCategory,
        enableQuickExpense: enableQuickExpense ?? current.enableQuickExpense,
        enableGroceryOCR: enableGroceryOCR ?? current.enableGroceryOCR,
        saveLastStoreName: saveLastStoreName ?? current.saveLastStoreName,
        showFrequentItemSuggestions:
            showFrequentItemSuggestions ?? current.showFrequentItemSuggestions,
        clearGrocerySessionOnExit:
            clearGrocerySessionOnExit ?? current.clearGrocerySessionOnExit,
        confirmBeforeGrocerySubmit:
            confirmBeforeGrocerySubmit ?? current.confirmBeforeGrocerySubmit,
        enableSpendingIntelligence:
            enableSpendingIntelligence ?? current.enableSpendingIntelligence,
        insightFrequency: insightFrequency ?? current.insightFrequency,
        enableAppLock: enableAppLock ?? current.enableAppLock,
        autoLockTimer: autoLockTimer ?? current.autoLockTimer,
        requireAuthOnLaunch: requireAuthOnLaunch ?? current.requireAuthOnLaunch,
        lastModified: DateTime.now(),
      );
      await saveSettings(updated);
    } catch (e) {
      debugPrint('Failed to update settings: $e');
    }
  }

  /// Reset all settings to defaults
  Future<void> resetToDefaults() async {
    if (!_isInitialized) {
      debugPrint('Settings data source not initialized, cannot reset settings');
      return;
    }
    try {
      await _settingsBox.put(_settingsKey, _getDefaultSettings());
    } catch (e) {
      debugPrint('Failed to reset settings: $e');
    }
  }

  /// Get default settings with creation timestamp
  AppSettings _getDefaultSettings() {
    return const AppSettings(
      createdAt: null, // Will be set on first save
    ).copyWith(createdAt: DateTime.now(), lastModified: DateTime.now());
  }

  /// Update storage usage information
  Future<void> updateStorageUsage(int bytes) async {
    if (!_isInitialized) return;
    try {
      final current = getSettings();
      final updated = current.copyWith(
        storageUsageBytes: bytes,
        lastModified: DateTime.now(),
      );
      await saveSettings(updated);
    } catch (e) {
      debugPrint('Failed to update storage usage: $e');
    }
  }

  /// Update last export date
  Future<void> updateLastExportDate(DateTime date) async {
    if (!_isInitialized) return;
    try {
      final current = getSettings();
      final updated = current.copyWith(
        lastExportDate: date,
        lastModified: DateTime.now(),
      );
      await saveSettings(updated);
    } catch (e) {
      debugPrint('Failed to update last export date: $e');
    }
  }

  /// Calculate actual storage usage across all app data
  Future<int> calculateActualStorageUsage() async {
    int totalBytes = 0;

    final boxNames = [
      AppConstants.expensesBoxName,
      'incomes', // IncomeLocalDataSource._boxName is private
      'grocery_preferences_box',
      AppConstants.insightsBoxName,
      AppConstants.budgetBoxName,
      AppConstants.scheduledExpensesBoxName,
      AppConstants.settingsBoxName,
      'daily_spend_box',
      'categories_box',
    ];

    for (final name in boxNames) {
      try {
        final isAlreadyOpen = Hive.isBoxOpen(name);
        Box box;
        if (isAlreadyOpen) {
          box = Hive.box(name);
        } else {
          box = await Hive.openBox(name);
        }

        totalBytes += _estimateBoxSize(box);

        // Only close if we opened it specifically for this calculation
        if (!isAlreadyOpen) {
          await box.close();
        }
      } catch (e) {
        debugPrint('Could not access box $name for storage calculation: $e');
      }
    }

    return totalBytes;
  }

  /// Estimate the size of a Hive box in bytes
  int _estimateBoxSize(Box box) {
    if (!box.isOpen) return 0;

    int totalSize = 0;
    try {
      // Estimate based on number of entries and average size
      final entryCount = box.length;

      // Rough estimation: each entry has overhead + data
      // This is a simplified estimation - real size would require serialization
      const averageEntryOverhead = 100; // bytes for Hive metadata per entry
      const averageDataSize = 200; // bytes for typical app data

      totalSize = entryCount * (averageEntryOverhead + averageDataSize);
    } catch (e) {
      debugPrint('Error estimating box size: $e');
    }

    return totalSize;
  }

  /// Get current storage usage (returns cached value or calculates if needed)
  int getStorageSize() {
    if (!_isInitialized) return 0;
    try {
      final settings = getSettings();
      // Return cached value if available and recent (within 1 hour)
      if (settings.storageUsageBytes != null &&
          settings.lastModified != null &&
          DateTime.now().difference(settings.lastModified!).inHours < 1) {
        return settings.storageUsageBytes!;
      }
      // Otherwise return 0 - let the app trigger recalculation
      return 0;
    } catch (e) {
      debugPrint('Error getting storage size: $e');
      return 0;
    }
  }

  /// Force recalculate and update storage usage
  Future<void> recalculateAndSaveStorageUsage() async {
    final bytes = await calculateActualStorageUsage();
    await updateStorageUsage(bytes);
  }

  /// Close the Hive box
  Future<void> close() async {
    if (_isInitialized && _settingsBox.isOpen) {
      try {
        await _settingsBox.close();
        _isInitialized = false;
      } catch (e) {
        debugPrint('Error closing settings box: $e');
      }
    }
  }
}
