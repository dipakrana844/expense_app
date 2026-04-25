import 'package:flutter/foundation.dart';
import 'package:smart_expense_tracker/features/settings/data/local/settings_local_data_source.dart';
import 'package:smart_expense_tracker/features/settings/data/models/app_settings.dart'
    as model;
import 'package:smart_expense_tracker/features/settings/domain/entities/app_settings_entity.dart';

import 'package:smart_expense_tracker/features/settings/domain/repository/repository.dart';

import 'package:smart_expense_tracker/core/error/failures.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource dataSource;

  SettingsRepositoryImpl(this.dataSource);

  @override
  Future<(AppSettingsEntity?, Failure?)> getSettings() async {
    try {
      final settingsModel = dataSource.getSettings();
      final entity = settingsModel.toEntity();
      return (entity, null);
    } catch (e) {
      debugPrint('SettingsRepositoryImpl: Error loading settings: $e');
      return (
        null,
        Failure.storage(message: 'Failed to load settings', error: e),
      );
    }
  }

  @override
  Future<Failure?> saveSettings(AppSettingsEntity settings) async {
    try {
      final settingsModel = model.AppSettings.fromEntity(settings);
      await dataSource.saveSettings(settingsModel);
      return null;
    } catch (e) {
      debugPrint('SettingsRepositoryImpl: Error saving settings: $e');
      return Failure.storage(message: 'Failed to save settings', error: e);
    }
  }

  @override
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
  }) async {
    try {
      await dataSource.updateSettings(
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
      );
      return null;
    } catch (e) {
      debugPrint('SettingsRepositoryImpl: Error updating settings: $e');
      return Failure.storage(message: 'Failed to update settings', error: e);
    }
  }

  @override
  Future<Failure?> resetToDefaults() async {
    try {
      await dataSource.resetToDefaults();
      return null;
    } catch (e) {
      debugPrint('SettingsRepositoryImpl: Error resetting settings: $e');
      return Failure.storage(message: 'Failed to reset settings', error: e);
    }
  }

  @override
  Future<Failure?> updateStorageUsage(int bytes) async {
    try {
      await dataSource.updateStorageUsage(bytes);
      return null;
    } catch (e) {
      debugPrint('SettingsRepositoryImpl: Error updating storage usage: $e');
      return Failure.storage(
        message: 'Failed to update storage usage',
        error: e,
      );
    }
  }

  @override
  Future<Failure?> updateLastExportDate(DateTime date) async {
    try {
      await dataSource.updateLastExportDate(date);
      return null;
    } catch (e) {
      debugPrint('SettingsRepositoryImpl: Error updating last export date: $e');
      return Failure.storage(
        message: 'Failed to update last export date',
        error: e,
      );
    }
  }

  @override
  Future<(int?, Failure?)> calculateActualStorageUsage() async {
    try {
      final bytes = await dataSource.calculateActualStorageUsage();
      return (bytes, null);
    } catch (e) {
      debugPrint('SettingsRepositoryImpl: Error calculating storage usage: $e');
      return (
        null,
        Failure.storage(message: 'Failed to calculate storage usage', error: e),
      );
    }
  }

  @override
  Future<(int?, Failure?)> getStorageSize() async {
    try {
      final bytes = dataSource.getStorageSize();
      return (bytes, null);
    } catch (e) {
      debugPrint('SettingsRepositoryImpl: Error getting storage size: $e');
      return (
        null,
        Failure.storage(message: 'Failed to get storage size', error: e),
      );
    }
  }

  @override
  Future<Failure?> recalculateAndSaveStorageUsage() async {
    try {
      await dataSource.recalculateAndSaveStorageUsage();
      return null;
    } catch (e) {
      debugPrint(
        'SettingsRepositoryImpl: Error recalculating storage usage: $e',
      );
      return Failure.storage(
        message: 'Failed to recalculate storage usage',
        error: e,
      );
    }
  }
}
