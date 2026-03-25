import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'local/budget_local_data_source.dart';
import 'repository_impl.dart';
import '../domain/repository.dart';

/// Infrastructure providers for the budget data layer.
///
/// Placing these here keeps the presentation providers (budget_providers.dart)
/// free of any concrete data-layer imports — they only depend on the abstract
/// [BudgetRepository] interface.

final budgetLocalDataSourceProvider = Provider<BudgetLocalDataSource>((ref) {
  // Data source is expected to be initialized before use (e.g., in main.dart).
  throw UnimplementedError('budgetLocalDataSourceProvider must be overridden');
});

final budgetRepositoryProvider = Provider<BudgetRepository>((ref) {
  final dataSource = ref.watch(budgetLocalDataSourceProvider);
  return BudgetRepositoryImpl(dataSource);
});
