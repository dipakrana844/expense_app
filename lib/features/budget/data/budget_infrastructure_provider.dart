import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'local/budget_local_data_source.dart';
import 'repository_impl.dart';
import '../domain/repository.dart';

/// Infrastructure providers for the budget data layer.
///
/// Placing these here keeps the presentation providers (budget_providers.dart)
/// free of any concrete data-layer imports — they only depend on the abstract
/// [BudgetRepository] interface.

/// Provider for the budget local data source.
/// This provider creates a new instance of BudgetLocalDataSource.
/// The data source must be initialized by calling [budgetInitializationProvider].
final budgetLocalDataSourceProvider = Provider<BudgetLocalDataSource>((ref) {
  return BudgetLocalDataSource();
});

/// Provider for initializing the budget data source.
/// This should be awaited during app initialization (e.g., in main.dart).
final budgetInitializationProvider = FutureProvider<void>((ref) async {
  final dataSource = ref.watch(budgetLocalDataSourceProvider);
  await dataSource.init();
});

/// Provider for the budget repository.
/// Depends on the budget local data source provider.
final budgetRepositoryProvider = Provider<BudgetRepository>((ref) {
  final dataSource = ref.watch(budgetLocalDataSourceProvider);
  return BudgetRepositoryImpl(dataSource);
});
