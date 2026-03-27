import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_expense_tracker/features/daily_spend_guard/domain/entities/daily_spend_state_entity.dart';
import 'package:smart_expense_tracker/features/daily_spend_guard/domain/repositories/daily_spend_repository.dart';
import 'package:smart_expense_tracker/features/expenses/data/repositories/expense_repository.dart';

import '../local/daily_spend_local_data_source.dart';
import '../models/daily_spend_state.dart';

class DailySpendRepositoryImpl implements DailySpendRepository {
  final DailySpendLocalDataSource _localDataSource;
  final ExpenseRepository _expenseRepository;
  final Box _budgetBox;

  DailySpendRepositoryImpl({
    required DailySpendLocalDataSource localDataSource,
    required ExpenseRepository expenseRepository,
    required Box budgetBox,
  }) : _localDataSource = localDataSource,
       _expenseRepository = expenseRepository,
       _budgetBox = budgetBox;

  @override
  Future<void> init() {
    return _localDataSource.init();
  }

  @override
  DailySpendStateEntity getCurrentState() {
    return _localDataSource.getCurrentState().toEntity();
  }

  @override
  Future<void> saveCurrentState(DailySpendStateEntity state) {
    return _localDataSource.saveCurrentStateFromEntity(state);
  }

  @override
  Future<void> resetDailyState() {
    return _localDataSource.resetDailyState();
  }

  @override
  Future<double> getMonthlyBudget() async {
    final value = _budgetBox.get('monthly_limit', defaultValue: 0.0);
    if (value is num) {
      return value.toDouble();
    }
    return 0.0;
  }

  @override
  Future<List<ExpenseSnapshot>> getExpensesSince(DateTime since) async {
    final (expenses, error) = _expenseRepository.getExpensesByDateRange(
      since,
      DateTime.now(),
    );
    if (error != null || expenses == null) {
      return const [];
    }
    return expenses
        .map(
          (expense) =>
              ExpenseSnapshot(amount: expense.amount, date: expense.date),
        )
        .toList();
  }
}
