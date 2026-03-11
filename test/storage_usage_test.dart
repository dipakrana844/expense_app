import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_expense_tracker/features/settings/presentation/providers/settings_providers.dart';
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
  Future<int> calculateActualStorageUsage() async {
    // Simulate some logic
    return 1024;
  }

  @override
  Future<void> updateStorageUsage(int bytes) async {
    _settings = _settings.copyWith(storageUsageBytes: bytes);
  }

  @override
  Future<void> recalculateAndSaveStorageUsage() async {
    final bytes = await calculateActualStorageUsage();
    await updateStorageUsage(bytes);
  }
}

void main() {
  group('Storage Usage Tests', () {
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

    test('Storage usage provider updates correctly', () async {
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
      // Initially null
      expect(container.read(storageUsageBytesProvider), null);

      // Update through main provider
      final notifier = container.read(appSettingsNotifierProvider.notifier);
      await notifier.updateStorageUsage(2048); // 2KB

      // Check selector updated
      expect(container.read(storageUsageBytesProvider), 2048);
    });

    test('Storage usage calculation estimates reasonable values', () async {
      final notifier = container.read(appSettingsNotifierProvider.notifier);
      final estimatedBytes = await notifier.getEstimatedStorageUsage();

      // Should return a reasonable estimate (greater than 0)
      expect(estimatedBytes, greaterThan(0));
      // Should be a reasonable size for app data
      expect(estimatedBytes, lessThan(10000000)); // Less than 10MB
    });
   group('Integration Tests Helper Methods', () {
      test('recalculateStorageUsage updates state', () async {
        final notifier = container.read(appSettingsNotifierProvider.notifier);
        await notifier.recalculateStorageUsage();
        
        final state = container.read(appSettingsNotifierProvider);
        expect(state.storageUsageBytes, 1024);
      });
    });
  });
}