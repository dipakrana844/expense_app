import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../data/models/app_settings.dart';
import '../../domain/entities/app_settings_entity.dart' as domain;
import '../../domain/usecases/get_settings_usecase.dart';
import '../../domain/usecases/update_settings_usecase.dart';
import '../../domain/usecases/reset_settings_usecase.dart';
import '../../data/infrastructure_provider.dart';
import 'package:smart_expense_tracker/core/domain/usecases/base_usecase.dart';
import 'package:smart_expense_tracker/core/error/failures.dart';

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
/// Uses AsyncNotifier for proper async state management (Riverpod 3.x)
final appSettingsNotifierProvider =
    AsyncNotifierProvider<AppSettingsNotifier, AppSettings>(
      AppSettingsNotifier.new,
    );

class AppSettingsNotifier extends AsyncNotifier<AppSettings> {
  @override
  Future<AppSettings> build() async {
    // Load settings immediately on build
    return await _loadSettings();
  }

  /// Load settings from repository
  Future<AppSettings> _loadSettings() async {
    final getSettingsUseCase = ref.read(getSettingsUseCaseProvider);
    final (domain.AppSettingsEntity? entity, Failure? failure) =
        await getSettingsUseCase.call(NoParams());

    if (failure != null) {
      debugPrint('Failed to load settings: $failure');
      // Return default settings on error
      return const AppSettings();
    }

    if (entity != null) {
      // Convert entity to model and return
      return AppSettings.fromEntity(entity);
    }

    // Return default settings if no entity returned
    return const AppSettings();
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
    domain.InsightFrequency? insightFrequency,
    bool? enableAppLock,
    domain.AutoLockTimer? autoLockTimer,
    bool? requireAuthOnLaunch,
  }) async {
    // Get current settings
    final currentSettings = switch (state) {
      AsyncData(:final value) => value,
      _ => null,
    };
    if (currentSettings == null) {
      debugPrint('Cannot update settings: no current settings');
      return;
    }

    // Create updated entity
    final currentEntity = currentSettings.toEntity();
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
      insightFrequency: insightFrequency ?? currentEntity.insightFrequency,
      enableAppLock: enableAppLock ?? currentEntity.enableAppLock,
      autoLockTimer: autoLockTimer ?? currentEntity.autoLockTimer,
      requireAuthOnLaunch:
          requireAuthOnLaunch ?? currentEntity.requireAuthOnLaunch,
    );

    // Save updated settings
    final updateSettingsUseCase = ref.read(updateSettingsUseCaseProvider);
    final (_, Failure? failure) = await updateSettingsUseCase.call(
      updatedEntity,
    );

    if (failure != null) {
      debugPrint('Failed to update settings: $failure');
      return;
    }

    // Update state with new model
    final updatedModel = AppSettings.fromEntity(updatedEntity);
    state = AsyncValue.data(updatedModel);
  }

  /// Reset all settings to defaults
  Future<void> resetToDefaults() async {
    final resetSettingsUseCase = ref.read(resetSettingsUseCaseProvider);
    final (_, Failure? failure) = await resetSettingsUseCase.call(NoParams());

    if (failure != null) {
      debugPrint('Failed to reset settings: $failure');
      return;
    }

    // Reload settings after reset
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _loadSettings());
  }

  /// Update storage usage information
  Future<void> updateStorageUsage(int bytes) async {
    final currentSettings = switch (state) {
      AsyncData(:final value) => value,
      _ => null,
    };
    if (currentSettings == null) {
      debugPrint('Cannot update storage usage: no current settings');
      return;
    }

    final currentEntity = currentSettings.toEntity();
    final updatedEntity = currentEntity.copyWith(storageUsageBytes: bytes);

    final updateSettingsUseCase = ref.read(updateSettingsUseCaseProvider);
    final (_, Failure? failure) = await updateSettingsUseCase.call(
      updatedEntity,
    );

    if (failure != null) {
      debugPrint('Failed to update storage usage: $failure');
      return;
    }

    final updatedModel = AppSettings.fromEntity(updatedEntity);
    state = AsyncValue.data(updatedModel);
  }

  /// Recalculate and update storage usage
  Future<void> recalculateStorageUsage() async {
    final currentSettings = switch (state) {
      AsyncData(:final value) => value,
      _ => null,
    };
    if (currentSettings == null) {
      debugPrint('Cannot recalculate storage usage: no current settings');
      return;
    }

    try {
      // Get repository to calculate storage
      final repository = ref.read(settingsRepositoryProvider);
      final (int? bytes, Failure? failure) = await repository
          .calculateActualStorageUsage();

      if (failure != null || bytes == null) {
        debugPrint('Failed to calculate storage usage: $failure');
        return;
      }

      await updateStorageUsage(bytes);
    } catch (e) {
      debugPrint('Error recalculating storage usage: $e');
    }
  }

  /// Get estimated actual storage usage
  Future<int> getEstimatedStorageUsage() async {
    final currentSettings = switch (state) {
      AsyncData(:final value) => value,
      _ => null,
    };
    if (currentSettings == null) {
      return 0;
    }

    try {
      final repository = ref.read(settingsRepositoryProvider);
      final (int? bytes, Failure? failure) = await repository
          .calculateActualStorageUsage();

      return bytes ?? 0;
    } catch (e) {
      debugPrint('Error getting estimated storage usage: $e');
      return 0;
    }
  }

  /// Update last export date
  Future<void> updateLastExportDate(DateTime date) async {
    final currentSettings = switch (state) {
      AsyncData(:final value) => value,
      _ => null,
    };
    if (currentSettings == null) {
      debugPrint('Cannot update last export date: no current settings');
      return;
    }

    final currentEntity = currentSettings.toEntity();
    final updatedEntity = currentEntity.copyWith(lastExportDate: date);

    final updateSettingsUseCase = ref.read(updateSettingsUseCaseProvider);
    final (_, Failure? failure) = await updateSettingsUseCase.call(
      updatedEntity,
    );

    if (failure != null) {
      debugPrint('Failed to update last export date: $failure');
      return;
    }

    final updatedModel = AppSettings.fromEntity(updatedEntity);
    state = AsyncValue.data(updatedModel);
  }

  /// Reload settings from storage
  Future<void> reload() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _loadSettings());
  }
}

/// Selector providers for specific setting groups
/// These provide convenient access to individual settings

/// Expense Preferences Selectors
final defaultCurrencyProvider = Provider<String>((ref) {
  final settings = ref.watch(appSettingsNotifierProvider);
  return switch (settings) {
    AsyncData(:final value) => value.defaultCurrency,
    _ => '₹',
  };
});

final defaultExpenseCategoryProvider = Provider<String>((ref) {
  final settings = ref.watch(appSettingsNotifierProvider);
  return switch (settings) {
    AsyncData(:final value) => value.defaultExpenseCategory,
    _ => 'Others',
  };
});

final enableQuickExpenseProvider = Provider<bool>((ref) {
  final settings = ref.watch(appSettingsNotifierProvider);
  return switch (settings) {
    AsyncData(:final value) => value.enableQuickExpense,
    _ => true,
  };
});

final enableGroceryOCRProvider = Provider<bool>((ref) {
  final settings = ref.watch(appSettingsNotifierProvider);
  return switch (settings) {
    AsyncData(:final value) => value.enableGroceryOCR,
    _ => true,
  };
});

/// Grocery Settings Selectors
final saveLastStoreNameProvider = Provider<bool>((ref) {
  final settings = ref.watch(appSettingsNotifierProvider);
  return switch (settings) {
    AsyncData(:final value) => value.saveLastStoreName,
    _ => true,
  };
});

final showFrequentItemSuggestionsProvider = Provider<bool>((ref) {
  final settings = ref.watch(appSettingsNotifierProvider);
  return switch (settings) {
    AsyncData(:final value) => value.showFrequentItemSuggestions,
    _ => true,
  };
});

final clearGrocerySessionOnExitProvider = Provider<bool>((ref) {
  final settings = ref.watch(appSettingsNotifierProvider);
  return switch (settings) {
    AsyncData(:final value) => value.clearGrocerySessionOnExit,
    _ => false,
  };
});

final confirmBeforeGrocerySubmitProvider = Provider<bool>((ref) {
  final settings = ref.watch(appSettingsNotifierProvider);
  return switch (settings) {
    AsyncData(:final value) => value.confirmBeforeGrocerySubmit,
    _ => true,
  };
});

/// Smart Insights Selectors
final enableSpendingIntelligenceProvider = Provider<bool>((ref) {
  final settings = ref.watch(appSettingsNotifierProvider);
  return switch (settings) {
    AsyncData(:final value) => value.enableSpendingIntelligence,
    _ => true,
  };
});

final insightFrequencyProvider = Provider<domain.InsightFrequency>((ref) {
  final settings = ref.watch(appSettingsNotifierProvider);
  return switch (settings) {
    AsyncData(:final value) => value.insightFrequency,
    _ => domain.InsightFrequency.weekly,
  };
});

/// Security Settings Selectors
final enableAppLockProvider = Provider<bool>((ref) {
  final settings = ref.watch(appSettingsNotifierProvider);
  return switch (settings) {
    AsyncData(:final value) => value.enableAppLock,
    _ => false,
  };
});

final autoLockTimerProvider = Provider<domain.AutoLockTimer>((ref) {
  final settings = ref.watch(appSettingsNotifierProvider);
  return switch (settings) {
    AsyncData(:final value) => value.autoLockTimer,
    _ => domain.AutoLockTimer.thirtySeconds,
  };
});

final requireAuthOnLaunchProvider = Provider<bool>((ref) {
  final settings = ref.watch(appSettingsNotifierProvider);
  return switch (settings) {
    AsyncData(:final value) => value.requireAuthOnLaunch,
    _ => true,
  };
});

/// Data & Storage Selectors
final lastExportDateProvider = Provider<DateTime?>((ref) {
  final settings = ref.watch(appSettingsNotifierProvider);
  return switch (settings) {
    AsyncData(:final value) => value.lastExportDate,
    _ => null,
  };
});

final storageUsageBytesProvider = Provider<int?>((ref) {
  final settings = ref.watch(appSettingsNotifierProvider);
  return switch (settings) {
    AsyncData(:final value) => value.storageUsageBytes,
    _ => null,
  };
});

/// UI State Providers
/// Provider for tracking security settings loading state
final securitySettingsLoadingProvider = StateProvider<bool>((ref) => false);

/// Provider for tracking storage calculation loading state
final storageCalculationLoadingProvider = StateProvider<bool>((ref) => false);
