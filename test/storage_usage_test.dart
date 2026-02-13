import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_expense_tracker/features/settings/presentation/providers/settings_providers.dart';
import 'package:smart_expense_tracker/features/settings/data/models/app_settings.dart';

void main() {
  group('Storage Usage Tests', () {
    test('Storage usage provider updates correctly', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      // Initial state should have null storage usage
      final initialState = container.read(appSettingsNotifierProvider);
      expect(initialState.storageUsageBytes, null);

      // Update storage usage
      final notifier = container.read(appSettingsNotifierProvider.notifier);
      await notifier.updateStorageUsage(1024); // 1KB

      // Check updated state
      final updatedState = container.read(appSettingsNotifierProvider);
      expect(updatedState.storageUsageBytes, 1024);
    });

    test('Storage usage selector provider works', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      // Initially null
      expect(container.read(storageUsageBytesProvider), null);

      // Update through main provider
      final notifier = container.read(appSettingsNotifierProvider.notifier);
      await notifier.updateStorageUsage(2048); // 2KB

      // Check selector updated
      expect(container.read(storageUsageBytesProvider), 2048);
    });

    test('Storage usage calculation estimates reasonable values', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(appSettingsNotifierProvider.notifier);
      final estimatedBytes = await notifier.getEstimatedStorageUsage();

      // Should return a reasonable estimate (greater than 0)
      expect(estimatedBytes, greaterThan(0));
      // Should be a reasonable size for app data
      expect(estimatedBytes, lessThan(10000000)); // Less than 10MB
    });
  });
}