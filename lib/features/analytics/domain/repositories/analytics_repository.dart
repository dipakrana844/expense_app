import 'package:smart_expense_tracker/features/analytics/domain/entities/analytics_entity.dart';
import 'package:smart_expense_tracker/features/expenses/domain/entities/expense_entity.dart';
import 'package:smart_expense_tracker/features/income/domain/entities/income_entity.dart';
import 'package:smart_expense_tracker/features/spending_intelligence/domain/entities/insight.dart';

/// Repository interface for analytics data
abstract class AnalyticsRepository {
  /// Get daily snapshot analytics
  Future<DailySnapshotEntity> getDailySnapshot(List<ExpenseEntity> expenses);

  /// Get monthly analytics
  Future<MonthlyAnalyticsEntity> getMonthlyAnalytics(
    List<ExpenseEntity> expenses,
  );

  /// Get monthly trend data (last 6 months)
  Future<Map<String, double>> getMonthlyTrend(List<ExpenseEntity> expenses);

  /// Get trend explanation based on trend data
  Future<String> getTrendExplanation(Map<String, double> trendData);

  /// Get category insights with month-over-month comparison
  Future<Map<String, CategoryInsightEntity>> getCategoryInsights(
    List<ExpenseEntity> expenses,
  );

  /// Get comprehensive financial analytics
  Future<FinancialAnalyticsEntity> getFinancialAnalytics({
    required List<IncomeEntity> incomes,
    required List<ExpenseEntity> expenses,
  });

  /// Get income vs expense trend data
  Future<Map<String, Map<String, double>>> getIncomeExpenseTrend({
    required List<IncomeEntity> incomes,
    required List<ExpenseEntity> expenses,
  });

  /// Get smart warnings/insights
  Future<List<Insight>> getSmartWarnings({
    required List<ExpenseEntity> expenses,
    required double budget,
  });
}
