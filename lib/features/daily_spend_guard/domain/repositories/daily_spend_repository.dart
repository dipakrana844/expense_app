import 'package:smart_expense_tracker/features/daily_spend_guard/domain/entities/daily_spend_state_entity.dart';

class ExpenseSnapshot {
  final double amount;
  final DateTime date;

  const ExpenseSnapshot({
    required this.amount,
    required this.date,
  });
}

abstract class DailySpendRepository {
  Future<void> init();
  DailySpendStateEntity getCurrentState();
  Future<void> saveCurrentState(DailySpendStateEntity state);
  Future<void> resetDailyState();
  Future<double> getMonthlyBudget();
  Future<List<ExpenseSnapshot>> getExpensesSince(DateTime since);
}

