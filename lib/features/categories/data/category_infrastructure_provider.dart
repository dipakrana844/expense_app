import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'datasource/category_local_data_source.dart';
import 'repository_impl.dart';
import '../domain/repository.dart';

/// Infrastructure providers for the categories data layer.
///
/// Placing these here keeps the presentation providers (category_providers.dart)
/// free of any concrete data-layer imports — they only depend on the abstract
/// [CategoryRepository] interface.

final categoryLocalDataSourceProvider = Provider<CategoryLocalDataSource>((
  ref,
) {
  // Data source is expected to be initialized before use (e.g., in main.dart).
  return CategoryLocalDataSource();
});

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  final dataSource = ref.watch(categoryLocalDataSourceProvider);
  return CategoryRepositoryImpl(dataSource);
});
