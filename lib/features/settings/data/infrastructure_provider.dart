import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'local/settings_local_data_source.dart';
import 'repositories/settings_repository_impl.dart';
import '../domain/repository/repository.dart';

/// Infrastructure providers for the settings data layer.
///
/// Placing these here keeps the presentation providers (settings_providers.dart)
/// free of any concrete data-layer imports — they only depend on the abstract
/// [SettingsRepository] interface.

final settingsLocalDataSourceProvider = Provider<SettingsLocalDataSource>((
  ref,
) {
  // Data source is expected to be initialized before use (e.g., in main.dart).
  throw UnimplementedError(
    'settingsLocalDataSourceProvider must be overridden',
  );
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  final dataSource = ref.watch(settingsLocalDataSourceProvider);
  return SettingsRepositoryImpl(dataSource);
});
