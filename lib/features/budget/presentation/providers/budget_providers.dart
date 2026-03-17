import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/budget_infrastructure_provider.dart';
import '../../data/local/budget_local_data_source.dart';

class MonthlyBudgetNotifier extends StateNotifier<AsyncValue<double>> {
  final BudgetLocalDataSource _dataSource;

  MonthlyBudgetNotifier(this._dataSource) : super(const AsyncValue.loading()) {
    _loadBudget();
  }

  void _loadBudget() {
    final budget = _dataSource.getMonthlyBudget();
    state = AsyncValue.data(budget);
  }

  Future<void> updateBudget(double amount) async {
    await _dataSource.updateMonthlyBudget(amount);
    state = AsyncValue.data(amount);
  }
}

final monthlyBudgetProvider =
    StateNotifierProvider<MonthlyBudgetNotifier, AsyncValue<double>>((ref) {
      final dataSource = ref.watch(budgetLocalDataSourceProvider);
      return MonthlyBudgetNotifier(dataSource);
    });
