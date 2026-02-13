import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_expense_tracker/features/settings/presentation/providers/settings_providers.dart';

void main() {
  group('Settings Integration Tests', () {
    test('Settings provider updates correctly', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

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
      final container = ProviderContainer();
      addTearDown(container.dispose);

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