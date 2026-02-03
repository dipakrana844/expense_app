import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/local/settings_local_data_source.dart';
import '../../data/models/app_settings.dart';

part 'settings_providers.g.dart';

/// Provider for Settings Local Data Source
final settingsLocalDataSourceProvider = Provider((ref) {
  final dataSource = SettingsLocalDataSource();
  dataSource.init();
  ref.onDispose(() => dataSource.close());
  return dataSource;
});

/// Main Settings Provider - exposes current settings state
@riverpod
class AppSettingsNotifier extends _$AppSettingsNotifier {
  @override
  AppSettings build() {
    final dataSource = ref.read(settingsLocalDataSourceProvider);
    return dataSource.getSettings();
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
    final dataSource = ref.read(settingsLocalDataSourceProvider);
    
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

    // Update the state
    state = dataSource.getSettings();
  }

  /// Reset all settings to defaults
  Future<void> resetToDefaults() async {
    final dataSource = ref.read(settingsLocalDataSourceProvider);
    await dataSource.resetToDefaults();
    state = dataSource.getSettings();
  }

  /// Update storage usage information
  Future<void> updateStorageUsage(int bytes) async {
    final dataSource = ref.read(settingsLocalDataSourceProvider);
    await dataSource.updateStorageUsage(bytes);
    state = dataSource.getSettings();
  }

  /// Update last export date
  Future<void> updateLastExportDate(DateTime date) async {
    final dataSource = ref.read(settingsLocalDataSourceProvider);
    await dataSource.updateLastExportDate(date);
    state = dataSource.getSettings();
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