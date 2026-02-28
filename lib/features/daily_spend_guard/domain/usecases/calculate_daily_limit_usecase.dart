import 'package:smart_expense_tracker/features/daily_spend_guard/domain/repositories/daily_spend_repository.dart';

/// Use Case: CalculateDailyLimitUseCase
///
/// Purpose: Calculates the recommended daily spending limit.
/// - Uses monthly budget when available
/// - Falls back to recent spending average
class CalculateDailyLimitUseCase {
  final DailySpendRepository _repository;

  CalculateDailyLimitUseCase(this._repository);

  Future<double> calculateDailyLimit() async {
    final monthlyBudget = await _repository.getMonthlyBudget();
    if (monthlyBudget > 0) {
      return _calculateFromMonthlyBudget(monthlyBudget);
    }
    return _calculateFromAverageSpending();
  }

  double _calculateFromMonthlyBudget(double monthlyBudget) {
    final now = DateTime.now();
    final daysInMonth = _getDaysInMonth(now.year, now.month);
    final daysRemaining = daysInMonth - now.day + 1;

    if (daysRemaining <= 0) {
      return monthlyBudget;
    }

    return monthlyBudget / daysRemaining;
  }

  Future<double> _calculateFromAverageSpending() async {
    try {
      final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
      final expenses = await _repository.getExpensesSince(thirtyDaysAgo);
      if (expenses.isEmpty) {
        return 0.0;
      }

      final totalAmount = expenses.fold<double>(
        0.0,
        (sum, expense) => sum + expense.amount,
      );

      final oldestDate = expenses
          .map((expense) => expense.date)
          .reduce((a, b) => a.isBefore(b) ? a : b);
      final daysOfData = DateTime.now().difference(oldestDate).inDays + 1;

      return totalAmount / daysOfData.clamp(1, 30);
    } catch (_) {
      return 0.0;
    }
  }

  int _getDaysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }
}

