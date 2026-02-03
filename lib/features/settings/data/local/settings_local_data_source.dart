import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/constants/app_constants.dart';
import '../models/app_settings.dart';

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
        Hive.registerAdapter(InsightFrequencyAdapter());
      }
      if (!Hive.isAdapterRegistered(13)) {
        Hive.registerAdapter(AutoLockTimerAdapter());
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
  /// Returns default settings if none exist
  AppSettings getSettings() {
    _ensureInitialized();
    return _settingsBox.get(_settingsKey) ?? _getDefaultSettings();
  }

  /// Save application settings
  Future<void> saveSettings(AppSettings settings) async {
    _ensureInitialized();
    try {
      final updated = settings.copyWith(
        lastModified: DateTime.now(),
      );
      await _settingsBox.put(_settingsKey, updated);
    } catch (e) {
      throw Exception('Failed to save settings: $e');
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
  }

  /// Reset all settings to defaults
  Future<void> resetToDefaults() async {
    _ensureInitialized();
    try {
      await _settingsBox.put(_settingsKey, _getDefaultSettings());
    } catch (e) {
      throw Exception('Failed to reset settings: $e');
    }
  }

  /// Get default settings with creation timestamp
  AppSettings _getDefaultSettings() {
    return const AppSettings(
      createdAt: null, // Will be set on first save
    ).copyWith(
      createdAt: DateTime.now(),
      lastModified: DateTime.now(),
    );
  }

  /// Update storage usage information
  Future<void> updateStorageUsage(int bytes) async {
    final current = getSettings();
    final updated = current.copyWith(
      storageUsageBytes: bytes,
      lastModified: DateTime.now(),
    );
    await saveSettings(updated);
  }

  /// Update last export date
  Future<void> updateLastExportDate(DateTime date) async {
    final current = getSettings();
    final updated = current.copyWith(
      lastExportDate: date,
      lastModified: DateTime.now(),
    );
    await saveSettings(updated);
  }

  /// Get storage usage information
  int getStorageSize() {
    _ensureInitialized();
    return _settingsBox.length;
  }

  /// Close the Hive box
  Future<void> close() async {
    if (_isInitialized && _settingsBox.isOpen) {
      await _settingsBox.close();
      _isInitialized = false;
    }
  }

  /// Internal helper to ensure initialization
  void _ensureInitialized() {
    if (!_isInitialized) {
      throw Exception('Settings data source not initialized. Call init() first.');
    }
  }
}