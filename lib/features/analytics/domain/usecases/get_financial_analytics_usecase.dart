import 'package:smart_expense_tracker/features/analytics/domain/entities/analytics_entity.dart';
import 'package:smart_expense_tracker/features/analytics/domain/repositories/analytics_repository.dart';
import 'package:smart_expense_tracker/features/expenses/domain/entities/expense_entity.dart';
import 'package:smart_expense_tracker/features/income/domain/entities/income_entity.dart';
import 'package:smart_expense_tracker/features/spending_intelligence/domain/entities/insight.dart';
import 'package:smart_expense_tracker/features/spending_intelligence/domain/algorithms/spending_algorithms.dart';
import 'package:smart_expense_tracker/core/services/balance_service.dart'
    hide FinancialHealth;
import 'package:smart_expense_tracker/core/services/aggregation_service.dart';
import 'package:smart_expense_tracker/core/services/financial_calculator.dart';
import 'package:smart_expense_tracker/features/budget/presentation/providers/budget_providers.dart';

/// Usecase for getting comprehensive financial analytics
class GetFinancialAnalyticsUsecase {
  final AnalyticsRepository repository;

  GetFinancialAnalyticsUsecase(this.repository);

  Future<AnalyticsData> call({
    required List<IncomeEntity> incomes,
    required List<ExpenseEntity> expenses,
    int monthsBack = 6,
  }) async {
    // Validate monthsBack parameter
    if (monthsBack <= 0) {
      throw ArgumentError('monthsBack must be greater than 0');
    }

    // Limit to reasonable maximum to prevent performance issues
    if (monthsBack > 60) {
      monthsBack = 60;
    }

    // Get basic financial analytics from repository
    final financialAnalytics = await repository.getFinancialAnalytics(
      incomes: incomes,
      expenses: expenses,
    );

    // Calculate daily snapshot
    final dailySnapshot = _calculateDailySnapshot(expenses);

    // Calculate smart warnings
    final smartWarnings = _calculateSmartWarnings(expenses);

    // Calculate trend explanation
    final trendExplanation = _calculateTrendExplanation(expenses, monthsBack);

    // Calculate category insights
    final categoryInsights = _calculateCategoryInsights(expenses);

    // Calculate income vs expense trend
    final incomeExpenseTrend = _calculateIncomeExpenseTrend(
      incomes,
      expenses,
      monthsBack,
    );

    // Calculate monthly analytics
    final monthlyAnalytics = _calculateMonthlyAnalytics(expenses);

    // Calculate monthly trend
    final monthlyTrend = _calculateMonthlyTrend(expenses, monthsBack);

    return AnalyticsData(
      dailySnapshot: dailySnapshot,
      smartWarnings: smartWarnings,
      trendExplanation: trendExplanation,
      categoryInsights: categoryInsights,
      financialAnalytics: financialAnalytics,
      incomeExpenseTrend: incomeExpenseTrend,
      monthlyAnalytics: monthlyAnalytics,
      monthlyTrend: monthlyTrend,
    );
  }

  /// Calculate daily snapshot data
  DailySnapshotEntity _calculateDailySnapshot(List<ExpenseEntity> expenses) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    // Use shared service for date filtering and calculations
    final todayExpenses = AggregationService.filterByDateRange(
      transactions: expenses,
      start: today,
      end: DateTime(now.year, now.month, now.day, 23, 59, 59),
    );

    final yesterdayExpenses = AggregationService.filterByDateRange(
      transactions: expenses,
      start: yesterday,
      end: today.subtract(const Duration(milliseconds: 1)),
    );

    final todayTotal = AggregationService.calculateTotal(
      transactions: todayExpenses,
    );
    final yesterdayTotal = AggregationService.calculateTotal(
      transactions: yesterdayExpenses,
    );

    // Use shared service for daily average calculation
    final dailyAverage = AggregationService.calculateDailyAverage(
      transactions: expenses,
    );

    double percentChange = 0;
    if (dailyAverage > 0) {
      percentChange = ((todayTotal - dailyAverage) / dailyAverage) * 100;
    }

    return DailySnapshotEntity(
      todayTotal: todayTotal,
      yesterdayTotal: yesterdayTotal,
      dailyAverage: dailyAverage,
      percentChangeVsAverage: percentChange,
    );
  }

  /// Calculate smart warnings and insights
  List<Insight> _calculateSmartWarnings(List<ExpenseEntity> expenses) {
    final insights = <Insight>[];

    // 1. Anomalies (spikes today)
    insights.addAll(SpendingAlgorithms.detectAnomalies(expenses));

    // 2. Budget burn (assuming a monthly budget)
    final now = DateTime.now();
    final currentMonthExpenses = expenses
        .where((e) => e.date.year == now.year && e.date.month == now.month)
        .toList();

    // Use a default budget if none is available
    final budget = 5000.0; // This could be made configurable

    final burnInsight = SpendingAlgorithms.predictBudgetBurn(
      currentMonthExpenses,
      budget,
    );
    if (burnInsight != null) insights.add(burnInsight);

    return insights;
  }

  /// Calculate trend explanation
  String _calculateTrendExplanation(
    List<ExpenseEntity> expenses,
    int monthsBack,
  ) {
    final monthlyTrend = _calculateMonthlyTrend(expenses, monthsBack);

    if (monthlyTrend.isEmpty) return "No data to analyze trends.";

    final entries = monthlyTrend.entries.toList();
    if (entries.length < 2) return "Continue tracking to see spending trends.";

    final currentMonth = entries.last.value;
    final previousMonth = entries[entries.length - 2].value;

    // Simple comparisons
    if (entries.length >= 3) {
      final prevPrevMonth = entries[entries.length - 3].value;
      if (currentMonth > previousMonth && previousMonth > prevPrevMonth) {
        return "Your spending has increased for 3 consecutive months.";
      }
    }

    if (currentMonth > previousMonth * 1.2) {
      return "This month is significantly higher than last month.";
    } else if (currentMonth < previousMonth * 0.8) {
      return "Great job! You've spent less than last month so far.";
    }

    // Find max in last N months
    final maxSpend = entries
        .map((e) => e.value)
        .reduce((a, b) => a > b ? a : b);
    if (currentMonth >= maxSpend && currentMonth > 0) {
      return "This month is your highest spending in $monthsBack months.";
    }

    return "Your spending is relatively stable compared to last month.";
  }

  /// Calculate category insights
  Map<String, CategoryInsightEntity> _calculateCategoryInsights(
    List<ExpenseEntity> expenses,
  ) {
    final now = DateTime.now();
    final currentMonthExpenses = expenses
        .where((e) => e.date.year == now.year && e.date.month == now.month)
        .toList();

    final lastMonth = DateTime(now.year, now.month - 1);
    final lastMonthExpenses = expenses
        .where(
          (e) =>
              e.date.year == lastMonth.year && e.date.month == lastMonth.month,
        )
        .toList();

    final currentTotals = <String, double>{};
    double totalCurrent = 0;
    for (var e in currentMonthExpenses) {
      currentTotals[e.category] = (currentTotals[e.category] ?? 0) + e.amount;
      totalCurrent += e.amount;
    }

    final lastTotals = <String, double>{};
    for (var e in lastMonthExpenses) {
      lastTotals[e.category] = (lastTotals[e.category] ?? 0) + e.amount;
    }

    final insights = <String, CategoryInsightEntity>{};
    currentTotals.forEach((cat, amt) {
      final lastAmt = lastTotals[cat] ?? 0;
      double change = 0;
      if (lastAmt > 0) {
        change = ((amt - lastAmt) / lastAmt) * 100;
      }

      insights[cat] = CategoryInsightEntity(
        category: cat,
        amount: amt,
        percentageOfTotal: totalCurrent > 0 ? (amt / totalCurrent) * 100 : 0,
        changeVsLastMonth: change,
      );
    });

    return insights;
  }

  /// Calculate income vs expense trend
  Map<String, Map<String, double>> _calculateIncomeExpenseTrend(
    List<IncomeEntity> incomes,
    List<ExpenseEntity> expenses,
    int monthsBack,
  ) {
    final trendData = <String, Map<String, double>>{};

    // Get last N months
    final now = DateTime.now();
    for (int i = monthsBack - 1; i >= 0; i--) {
      final month = DateTime(now.year, now.month - i);
      final monthKey =
          '${month.year}-${month.month.toString().padLeft(2, '0')}';

      // Calculate income for this month
      final monthIncomes = incomes.where(
        (income) =>
            income.date.year == month.year && income.date.month == month.month,
      );
      final totalIncome = monthIncomes.fold<double>(
        0.0,
        (sum, income) => sum + income.amount,
      );

      // Calculate expenses for this month
      final monthExpenses = expenses.where(
        (expense) =>
            expense.date.year == month.year &&
            expense.date.month == month.month,
      );
      final totalExpense = monthExpenses.fold<double>(
        0.0,
        (sum, expense) => sum + expense.amount,
      );

      trendData[monthKey] = {
        'income': totalIncome,
        'expense': totalExpense,
        'net': totalIncome - totalExpense,
      };
    }

    return trendData;
  }

  /// Calculate monthly analytics
  MonthlyAnalyticsEntity _calculateMonthlyAnalytics(
    List<ExpenseEntity> expenses,
  ) {
    final now = DateTime.now();
    final currentMonthExpenses = expenses
        .where((e) => e.date.year == now.year && e.date.month == now.month)
        .toList();

    final categoryBreakdown = <String, double>{};
    double totalSpent = 0;
    String? topCategory;
    double topAmount = 0;

    for (var expense in currentMonthExpenses) {
      categoryBreakdown[expense.category] =
          (categoryBreakdown[expense.category] ?? 0) + expense.amount;
      totalSpent += expense.amount;

      if (categoryBreakdown[expense.category]! > topAmount) {
        topAmount = categoryBreakdown[expense.category]!;
        topCategory = expense.category;
      }
    }

    return MonthlyAnalyticsEntity(
      totalSpent: totalSpent,
      categoryBreakdown: categoryBreakdown,
      topCategory: topCategory,
      topAmount: topAmount,
      expenseCount: currentMonthExpenses.length,
    );
  }

  /// Calculate monthly trend
  Map<String, double> _calculateMonthlyTrend(
    List<ExpenseEntity> expenses,
    int monthsBack,
  ) {
    final monthlyTrend = <String, double>{};

    final now = DateTime.now();
    for (int i = monthsBack - 1; i >= 0; i--) {
      final month = DateTime(now.year, now.month - i);
      final monthKey =
          '${month.year}-${month.month.toString().padLeft(2, '0')}';

      final monthExpenses = expenses.where(
        (expense) =>
            expense.date.year == month.year &&
            expense.date.month == month.month,
      );

      final totalExpense = monthExpenses.fold<double>(
        0.0,
        (sum, expense) => sum + expense.amount,
      );

      monthlyTrend[monthKey] = totalExpense;
    }

    return monthlyTrend;
  }
}
