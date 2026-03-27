import 'package:flutter/foundation.dart';
import 'package:smart_expense_tracker/features/settings/data/local/settings_local_data_source.dart';
import 'package:smart_expense_tracker/features/settings/data/models/app_settings.dart' as model;
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
      final entity = _toEntity(settingsModel);
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
      final settingsModel = _toModel(settings);
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
        insightFrequency: _toDataInsightFrequencyNullable(insightFrequency),
        enableAppLock: enableAppLock,
        autoLockTimer: _toDataAutoLockTimerNullable(autoLockTimer),
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

  // Mapping helpers

  AppSettingsEntity _toEntity(model.AppSettings model) {
    return AppSettingsEntity(
      defaultCurrency: model.defaultCurrency,
      defaultExpenseCategory: model.defaultExpenseCategory,
      enableQuickExpense: model.enableQuickExpense,
      enableGroceryOCR: model.enableGroceryOCR,
      saveLastStoreName: model.saveLastStoreName,
      showFrequentItemSuggestions: model.showFrequentItemSuggestions,
      clearGrocerySessionOnExit: model.clearGrocerySessionOnExit,
      confirmBeforeGrocerySubmit: model.confirmBeforeGrocerySubmit,
      enableSpendingIntelligence: model.enableSpendingIntelligence,
      insightFrequency: _toDomainInsightFrequency(model.insightFrequency),
      enableAppLock: model.enableAppLock,
      autoLockTimer: _toDomainAutoLockTimer(model.autoLockTimer),
      requireAuthOnLaunch: model.requireAuthOnLaunch,
      lastExportDate: model.lastExportDate,
      storageUsageBytes: model.storageUsageBytes,
      createdAt: model.createdAt,
      lastModified: model.lastModified,
      version: model.version,
    );
  }

  model.AppSettings _toModel(AppSettingsEntity entity) {
    return model.AppSettings(
      defaultCurrency: entity.defaultCurrency,
      defaultExpenseCategory: entity.defaultExpenseCategory,
      enableQuickExpense: entity.enableQuickExpense,
      enableGroceryOCR: entity.enableGroceryOCR,
      saveLastStoreName: entity.saveLastStoreName,
      showFrequentItemSuggestions: entity.showFrequentItemSuggestions,
      clearGrocerySessionOnExit: entity.clearGrocerySessionOnExit,
      confirmBeforeGrocerySubmit: entity.confirmBeforeGrocerySubmit,
      enableSpendingIntelligence: entity.enableSpendingIntelligence,
      insightFrequency: _toDataInsightFrequency(entity.insightFrequency),
      enableAppLock: entity.enableAppLock,
      autoLockTimer: _toDataAutoLockTimer(entity.autoLockTimer),
      requireAuthOnLaunch: entity.requireAuthOnLaunch,
      lastExportDate: entity.lastExportDate,
      storageUsageBytes: entity.storageUsageBytes,
      createdAt: entity.createdAt,
      lastModified: entity.lastModified,
      version: entity.version,
    );
  }

  // Enum conversions (non-nullable)

  InsightFrequency _toDomainInsightFrequency(model.InsightFrequency dataEnum) {
    switch (dataEnum) {
      case model.InsightFrequency.daily:
        return InsightFrequency.daily;
      case model.InsightFrequency.weekly:
        return InsightFrequency.weekly;
      case model.InsightFrequency.monthly:
        return InsightFrequency.monthly;
    }
  }

  model.InsightFrequency _toDataInsightFrequency(InsightFrequency domainEnum) {
    switch (domainEnum) {
      case InsightFrequency.daily:
        return model.InsightFrequency.daily;
      case InsightFrequency.weekly:
        return model.InsightFrequency.weekly;
      case InsightFrequency.monthly:
        return model.InsightFrequency.monthly;
    }
  }

  AutoLockTimer _toDomainAutoLockTimer(model.AutoLockTimer dataEnum) {
    switch (dataEnum) {
      case model.AutoLockTimer.immediate:
        return AutoLockTimer.immediate;
      case model.AutoLockTimer.thirtySeconds:
        return AutoLockTimer.thirtySeconds;
      case model.AutoLockTimer.oneMinute:
        return AutoLockTimer.oneMinute;
      case model.AutoLockTimer.fiveMinutes:
        return AutoLockTimer.fiveMinutes;
    }
  }

  model.AutoLockTimer _toDataAutoLockTimer(AutoLockTimer domainEnum) {
    switch (domainEnum) {
      case AutoLockTimer.immediate:
        return model.AutoLockTimer.immediate;
      case AutoLockTimer.thirtySeconds:
        return model.AutoLockTimer.thirtySeconds;
      case AutoLockTimer.oneMinute:
        return model.AutoLockTimer.oneMinute;
      case AutoLockTimer.fiveMinutes:
        return model.AutoLockTimer.fiveMinutes;
    }
  }

  // Nullable versions for updateSettings

  model.InsightFrequency? _toDataInsightFrequencyNullable(
    InsightFrequency? domainEnum,
  ) {
    if (domainEnum == null) return null;
    return _toDataInsightFrequency(domainEnum);
  }

  model.AutoLockTimer? _toDataAutoLockTimerNullable(AutoLockTimer? domainEnum) {
    if (domainEnum == null) return null;
    return _toDataAutoLockTimer(domainEnum);
  }
}
