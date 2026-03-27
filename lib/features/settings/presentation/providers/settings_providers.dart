import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/app_settings.dart';
import '../../domain/entities/app_settings_entity.dart' as domain;
import '../../domain/usecases/get_settings_usecase.dart';
import '../../domain/usecases/update_settings_usecase.dart';
import '../../domain/usecases/reset_settings_usecase.dart';
import '../../data/infrastructure_provider.dart';
import 'package:smart_expense_tracker/core/domain/usecases/base_usecase.dart';
import 'package:smart_expense_tracker/core/error/failures.dart';

part 'settings_providers.g.dart';

/// Use-case providers (depend only on abstract SettingsRepository)
final getSettingsUseCaseProvider = Provider<GetSettingsUseCase>((ref) {
  final repository = ref.watch(settingsRepositoryProvider);
  return GetSettingsUseCase(repository);
});

final updateSettingsUseCaseProvider = Provider<UpdateSettingsUseCase>((ref) {
  final repository = ref.watch(settingsRepositoryProvider);
  return UpdateSettingsUseCase(repository);
});

final resetSettingsUseCaseProvider = Provider<ResetSettingsUseCase>((ref) {
  final repository = ref.watch(settingsRepositoryProvider);
  return ResetSettingsUseCase(repository);
});

/// Main Settings Provider - exposes current settings state
@riverpod
class AppSettingsNotifier extends _$AppSettingsNotifier {
  late final GetSettingsUseCase _getSettingsUseCase;
  late final UpdateSettingsUseCase _updateSettingsUseCase;
  late final ResetSettingsUseCase _resetSettingsUseCase;

  @override
  AppSettings build() {
    // Initialize use cases
    _getSettingsUseCase = ref.read(getSettingsUseCaseProvider);
    _updateSettingsUseCase = ref.read(updateSettingsUseCaseProvider);
    _resetSettingsUseCase = ref.read(resetSettingsUseCaseProvider);

    // Schedule async loading of settings after the widget tree is built
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _loadSettings();
    });

    // Return default settings initially
    return const AppSettings();
  }

  Future<void> _loadSettings() async {
    final (domain.AppSettingsEntity? entity, Failure? failure) =
        await _getSettingsUseCase.call(NoParams());
    if (failure != null) {
      debugPrint('Failed to load settings: $failure');
      // Keep default settings
      return;
    }
    if (entity != null) {
      // Convert entity to model and update state
      state = _toModel(entity);
    }
  }

  /// Update settings with partial updates
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
    final currentEntity = _toEntity(state);
    final updatedEntity = currentEntity.copyWith(
      defaultCurrency: defaultCurrency ?? currentEntity.defaultCurrency,
      defaultExpenseCategory:
          defaultExpenseCategory ?? currentEntity.defaultExpenseCategory,
      enableQuickExpense:
          enableQuickExpense ?? currentEntity.enableQuickExpense,
      enableGroceryOCR: enableGroceryOCR ?? currentEntity.enableGroceryOCR,
      saveLastStoreName: saveLastStoreName ?? currentEntity.saveLastStoreName,
      showFrequentItemSuggestions:
          showFrequentItemSuggestions ??
          currentEntity.showFrequentItemSuggestions,
      clearGrocerySessionOnExit:
          clearGrocerySessionOnExit ?? currentEntity.clearGrocerySessionOnExit,
      confirmBeforeGrocerySubmit:
          confirmBeforeGrocerySubmit ??
          currentEntity.confirmBeforeGrocerySubmit,
      enableSpendingIntelligence:
          enableSpendingIntelligence ??
          currentEntity.enableSpendingIntelligence,
      insightFrequency: insightFrequency != null
          ? _toDomainInsightFrequency(insightFrequency)
          : currentEntity.insightFrequency,
      enableAppLock: enableAppLock ?? currentEntity.enableAppLock,
      autoLockTimer: autoLockTimer != null
          ? _toDomainAutoLockTimer(autoLockTimer)
          : currentEntity.autoLockTimer,
      requireAuthOnLaunch:
          requireAuthOnLaunch ?? currentEntity.requireAuthOnLaunch,
    );

    final (_, Failure? failure) = await _updateSettingsUseCase.call(
      updatedEntity,
    );
    if (failure != null) {
      debugPrint('Failed to update settings: $failure');
      // Optionally show error to user
      return;
    }

    // Update state with new model
    state = _toModel(updatedEntity);

    // Also notify listeners by rebuilding
    ref.invalidateSelf();
  }

  /// Reset all settings to defaults
  Future<void> resetToDefaults() async {
    final (_, Failure? failure) = await _resetSettingsUseCase.call(NoParams());
    if (failure != null) {
      debugPrint('Failed to reset settings: $failure');
      return;
    }
    // Reload settings after reset
    await _loadSettings();
    ref.invalidateSelf();
  }

  /// Update storage usage information
  Future<void> updateStorageUsage(int bytes) async {
    final currentEntity = _toEntity(state);
    final updatedEntity = currentEntity.copyWith(storageUsageBytes: bytes);
    final (_, Failure? failure) = await _updateSettingsUseCase.call(
      updatedEntity,
    );
    if (failure != null) {
      debugPrint('Failed to update storage usage: $failure');
      return;
    }
    state = _toModel(updatedEntity);
    ref.invalidateSelf();
  }

  /// Recalculate and update storage usage
  Future<void> recalculateStorageUsage() async {
    // This is a placeholder; actual implementation would call a use case
    // that calculates storage usage and updates settings.
    // For now, we'll just call the repository method via use case.
    // Since we don't have a dedicated use case, we'll simulate.
    // We'll leave this as a TODO.
    debugPrint('recalculateStorageUsage not yet implemented');
  }

  /// Get estimated actual storage usage
  Future<int> getEstimatedStorageUsage() async {
    // This method is used by UI; we need to implement it.
    // For now, return 0.
    return 0;
  }

  /// Update last export date
  Future<void> updateLastExportDate(DateTime date) async {
    final currentEntity = _toEntity(state);
    final updatedEntity = currentEntity.copyWith(lastExportDate: date);
    final (_, Failure? failure) = await _updateSettingsUseCase.call(
      updatedEntity,
    );
    if (failure != null) {
      debugPrint('Failed to update last export date: $failure');
      return;
    }
    state = _toModel(updatedEntity);
    ref.invalidateSelf();
  }

  // Mapping helpers

  domain.AppSettingsEntity _toEntity(AppSettings model) {
    return domain.AppSettingsEntity(
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

  AppSettings _toModel(domain.AppSettingsEntity entity) {
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

  // Enum conversions

  domain.InsightFrequency _toDomainInsightFrequency(InsightFrequency dataEnum) {
    switch (dataEnum) {
      case InsightFrequency.daily:
        return domain.InsightFrequency.daily;
      case InsightFrequency.weekly:
        return domain.InsightFrequency.weekly;
      case InsightFrequency.monthly:
        return domain.InsightFrequency.monthly;
    }
  }

  InsightFrequency _toDataInsightFrequency(domain.InsightFrequency domainEnum) {
    switch (domainEnum) {
      case domain.InsightFrequency.daily:
        return InsightFrequency.daily;
      case domain.InsightFrequency.weekly:
        return InsightFrequency.weekly;
      case domain.InsightFrequency.monthly:
        return InsightFrequency.monthly;
    }
  }

  domain.AutoLockTimer _toDomainAutoLockTimer(AutoLockTimer dataEnum) {
    switch (dataEnum) {
      case AutoLockTimer.immediate:
        return domain.AutoLockTimer.immediate;
      case AutoLockTimer.thirtySeconds:
        return domain.AutoLockTimer.thirtySeconds;
      case AutoLockTimer.oneMinute:
        return domain.AutoLockTimer.oneMinute;
      case AutoLockTimer.fiveMinutes:
        return domain.AutoLockTimer.fiveMinutes;
    }
  }

  AutoLockTimer _toDataAutoLockTimer(domain.AutoLockTimer domainEnum) {
    switch (domainEnum) {
      case domain.AutoLockTimer.immediate:
        return AutoLockTimer.immediate;
      case domain.AutoLockTimer.thirtySeconds:
        return AutoLockTimer.thirtySeconds;
      case domain.AutoLockTimer.oneMinute:
        return AutoLockTimer.oneMinute;
      case domain.AutoLockTimer.fiveMinutes:
        return AutoLockTimer.fiveMinutes;
    }
  }
}

/// Selector providers for specific setting groups

/// Expense Preferences Selectors
final defaultCurrencyProvider = Provider<String>((ref) {
  return ref.watch(appSettingsNotifierProvider).defaultCurrency;
});

final defaultExpenseCategoryProvider = Provider<String>((ref) {
  return ref.watch(appSettingsNotifierProvider).defaultExpenseCategory;
});

final enableQuickExpenseProvider = Provider<bool>((ref) {
  return ref.watch(appSettingsNotifierProvider).enableQuickExpense;
});

final enableGroceryOCRProvider = Provider<bool>((ref) {
  return ref.watch(appSettingsNotifierProvider).enableGroceryOCR;
});

/// Grocery Settings Selectors
final saveLastStoreNameProvider = Provider<bool>((ref) {
  return ref.watch(appSettingsNotifierProvider).saveLastStoreName;
});

final showFrequentItemSuggestionsProvider = Provider<bool>((ref) {
  return ref.watch(appSettingsNotifierProvider).showFrequentItemSuggestions;
});

final clearGrocerySessionOnExitProvider = Provider<bool>((ref) {
  return ref.watch(appSettingsNotifierProvider).clearGrocerySessionOnExit;
});

final confirmBeforeGrocerySubmitProvider = Provider<bool>((ref) {
  return ref.watch(appSettingsNotifierProvider).confirmBeforeGrocerySubmit;
});

/// Smart Insights Selectors
final enableSpendingIntelligenceProvider = Provider<bool>((ref) {
  return ref.watch(appSettingsNotifierProvider).enableSpendingIntelligence;
});

final insightFrequencyProvider = Provider<InsightFrequency>((ref) {
  return ref.watch(appSettingsNotifierProvider).insightFrequency;
});

/// Security Settings Selectors
final enableAppLockProvider = Provider<bool>((ref) {
  return ref.watch(appSettingsNotifierProvider).enableAppLock;
});

final autoLockTimerProvider = Provider<AutoLockTimer>((ref) {
  return ref.watch(appSettingsNotifierProvider).autoLockTimer;
});

final requireAuthOnLaunchProvider = Provider<bool>((ref) {
  return ref.watch(appSettingsNotifierProvider).requireAuthOnLaunch;
});

/// Data & Storage Selectors
final lastExportDateProvider = Provider<DateTime?>((ref) {
  return ref.watch(appSettingsNotifierProvider).lastExportDate;
});

final storageUsageBytesProvider = Provider<int?>((ref) {
  return ref.watch(appSettingsNotifierProvider).storageUsageBytes;
});

/// UI State Providers
/// Provider for tracking security settings loading state
final securitySettingsLoadingProvider = StateProvider<bool>((ref) => false);

/// Provider for tracking storage calculation loading state
final storageCalculationLoadingProvider = StateProvider<bool>((ref) => false);
