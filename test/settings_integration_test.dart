import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_expense_tracker/features/settings/presentation/providers/settings_providers.dart';
import 'package:smart_expense_tracker/features/settings/data/infrastructure_provider.dart';
import 'package:smart_expense_tracker/features/settings/data/local/settings_local_data_source.dart';
import 'package:smart_expense_tracker/features/settings/data/models/app_settings.dart';

class FakeSettingsLocalDataSource extends SettingsLocalDataSource {
  AppSettings _settings = const AppSettings();

  @override
  Future<void> init() async {
    // No-op
  }

  @override
  AppSettings getSettings() {
    return _settings;
  }

  @override
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
    _settings = _settings.copyWith(
      defaultCurrency: defaultCurrency ?? _settings.defaultCurrency,
      defaultExpenseCategory:
          defaultExpenseCategory ?? _settings.defaultExpenseCategory,
      enableQuickExpense: enableQuickExpense ?? _settings.enableQuickExpense,
      enableGroceryOCR: enableGroceryOCR ?? _settings.enableGroceryOCR,
      saveLastStoreName: saveLastStoreName ?? _settings.saveLastStoreName,
      showFrequentItemSuggestions:
          showFrequentItemSuggestions ?? _settings.showFrequentItemSuggestions,
      clearGrocerySessionOnExit:
          clearGrocerySessionOnExit ?? _settings.clearGrocerySessionOnExit,
      confirmBeforeGrocerySubmit:
          confirmBeforeGrocerySubmit ?? _settings.confirmBeforeGrocerySubmit,
      enableSpendingIntelligence:
          enableSpendingIntelligence ?? _settings.enableSpendingIntelligence,
      insightFrequency: insightFrequency ?? _settings.insightFrequency,
      enableAppLock: enableAppLock ?? _settings.enableAppLock,
      autoLockTimer: autoLockTimer ?? _settings.autoLockTimer,
      requireAuthOnLaunch: requireAuthOnLaunch ?? _settings.requireAuthOnLaunch,
    );
  }

  @override
  Future<int> calculateActualStorageUsage() async {
    return 1024; // Return a dummy value
  }

  @override
  Future<void> updateStorageUsage(int bytes) async {
    _settings = _settings.copyWith(storageUsageBytes: bytes);
  }
}

void main() {
  group('Settings Integration Tests', () {
    late FakeSettingsLocalDataSource fakeDataSource;
    late ProviderContainer container;

    setUp(() {
      fakeDataSource = FakeSettingsLocalDataSource();
      container = ProviderContainer(
        overrides: [
          settingsLocalDataSourceProvider.overrideWithValue(fakeDataSource),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('Settings provider updates correctly', () async {
      // Initial state
      final initialState = container.read(appSettingsNotifierProvider);
      expect(initialState.defaultCurrency, '₹');
      expect(initialState.enableQuickExpense, true);

      // Update settings
      final notifier = container.read(appSettingsNotifierProvider.notifier);
      await notifier.updateSettings(
        defaultCurrency: '\$',
        enableQuickExpense: false,
      );

      // Check updated state
      final updatedState = container.read(appSettingsNotifierProvider);
      expect(updatedState.defaultCurrency, '\$');
      expect(updatedState.enableQuickExpense, false);
    });

    test('Selector providers work correctly', () async {
      // Test selector providers
      expect(container.read(defaultCurrencyProvider), '₹');
      expect(container.read(enableQuickExpenseProvider), true);

      // Update through main provider
      final notifier = container.read(appSettingsNotifierProvider.notifier);
      await notifier.updateSettings(defaultCurrency: '€');

      // Check selectors updated
      expect(container.read(defaultCurrencyProvider), '€');
    });
  });
}
