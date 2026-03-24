import 'package:smart_expense_tracker/features/analytics/domain/entities/analytics_entity.dart';
import 'package:smart_expense_tracker/features/analytics/domain/repositories/analytics_repository.dart';
import 'package:smart_expense_tracker/features/expenses/domain/entities/expense_entity.dart';
import 'package:smart_expense_tracker/features/income/domain/entities/income_entity.dart';
import 'package:smart_expense_tracker/core/services/aggregation_service.dart';
import 'package:smart_expense_tracker/core/services/balance_service.dart';
import 'package:smart_expense_tracker/core/services/financial_calculator.dart';
import 'package:smart_expense_tracker/features/spending_intelligence/domain/entities/insight.dart';
import 'package:smart_expense_tracker/features/spending_intelligence/domain/algorithms/spending_algorithms.dart';

/// Implementation of AnalyticsRepository
class AnalyticsRepositoryImpl implements AnalyticsRepository {
  final BalanceService balanceService;

  AnalyticsRepositoryImpl({required this.balanceService});

  @override
  Future<DailySnapshotEntity> getDailySnapshot(
    List<ExpenseEntity> expenses,
  ) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

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

  @override
  Future<MonthlyAnalyticsEntity> getMonthlyAnalytics(
    List<ExpenseEntity> expenses,
  ) async {
    final now = DateTime.now();
    final currentMonthExpenses = AggregationService.filterByMonth(
      transactions: expenses,
      year: now.year,
      month: now.month,
    );

    final total = AggregationService.calculateTotal(
      transactions: currentMonthExpenses,
    );
    final categoryBreakdown = AggregationService.calculateCategoryBreakdown(
      transactions: currentMonthExpenses,
    );

    final topCategories = AggregationService.getTopCategories(
      transactions: currentMonthExpenses,
      limit: 1,
    );

    return MonthlyAnalyticsEntity(
      totalSpent: total,
      categoryBreakdown: categoryBreakdown.map(
        (key, value) => MapEntry(key, value.amount),
      ),
      topCategory: topCategories.isNotEmpty
          ? topCategories.first.category
          : null,
      topAmount: topCategories.isNotEmpty ? topCategories.first.amount : 0.0,
      expenseCount: currentMonthExpenses.length,
    );
  }

  @override
  Future<Map<String, double>> getMonthlyTrend(
    List<ExpenseEntity> expenses,
  ) async {
    final trend = <String, double>{};
    final now = DateTime.now();

    for (int i = 5; i >= 0; i--) {
      final monthDate = DateTime(now.year, now.month - i, 1);
      final monthKey = "${monthDate.month}/${monthDate.year}";

      final monthExpenses = AggregationService.filterByMonth(
        transactions: expenses,
        year: monthDate.year,
        month: monthDate.month,
      );

      final monthTotal = AggregationService.calculateTotal(
        transactions: monthExpenses,
      );
      trend[monthKey] = monthTotal;
    }

    return trend;
  }

  @override
  Future<String> getTrendExplanation(Map<String, double> trendData) async {
    if (trendData.isEmpty) return "No data to analyze trends.";

    final entries = trendData.entries.toList();
    if (entries.length < 2) return "Continue tracking to see spending trends.";

    final currentMonth = entries.last.value;
    final previousMonth = entries[entries.length - 2].value;

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

    final maxSpend = entries
        .map((e) => e.value)
        .reduce((a, b) => a > b ? a : b);
    if (currentMonth >= maxSpend && currentMonth > 0) {
      return "This month is your highest spending in 6 months.";
    }

    return "Your spending is relatively stable compared to last month.";
  }

  @override
  Future<Map<String, CategoryInsightEntity>> getCategoryInsights(
    List<ExpenseEntity> expenses,
  ) async {
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

  @override
  Future<FinancialAnalyticsEntity> getFinancialAnalytics({
    required List<IncomeEntity> incomes,
    required List<ExpenseEntity> expenses,
  }) async {
    final totalIncome = balanceService.getTotalIncome(incomes: incomes);
    final totalExpenses = balanceService.getTotalExpenses(expenses: expenses);
    final netBalance = balanceService.getCurrentBalance(
      incomes: incomes,
      expenses: expenses,
    );
    final savingsRate = balanceService.getSavingsRate(
      incomes: incomes,
      expenses: expenses,
    );
    final financialHealth = FinancialCalculator.assessFinancialHealth(
      transactions: [...incomes, ...expenses],
    );
    final incomeBySource = balanceService.getIncomeSourceBreakdown(incomes);

    final now = DateTime.now();
    final thirtyDaysAgo = now.subtract(const Duration(days: 30));
    final recentExpenses = expenses
        .where((e) => e.date.isAfter(thirtyDaysAgo))
        .toList();
    final dailySpendingRate =
        recentExpenses.fold<double>(0.0, (sum, e) => sum + e.amount) / 30;
    final balanceDepletionDays =
        balanceService.getBalanceDepletionDays(
          currentBalance: netBalance,
          dailySpendingRate: dailySpendingRate,
        ) ??
        0;

    return FinancialAnalyticsEntity(
      totalIncome: totalIncome,
      totalExpenses: totalExpenses,
      netBalance: netBalance,
      savingsRate: savingsRate,
      financialHealth: financialHealth,
      incomeBySource: incomeBySource,
      balanceDepletionDays: balanceDepletionDays,
    );
  }

  @override
  Future<Map<String, Map<String, double>>> getIncomeExpenseTrend({
    required List<IncomeEntity> incomes,
    required List<ExpenseEntity> expenses,
  }) async {
    final trendData = <String, Map<String, double>>{};

    final now = DateTime.now();
    for (int i = 5; i >= 0; i--) {
      final month = DateTime(now.year, now.month - i);
      final monthKey =
          '${month.year}-${month.month.toString().padLeft(2, '0')}';

      final monthIncomes = incomes.where(
        (income) =>
            income.date.year == month.year && income.date.month == month.month,
      );
      final totalIncome = monthIncomes.fold<double>(
        0.0,
        (sum, income) => sum + income.amount,
      );

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

  @override
  Future<List<Insight>> getSmartWarnings({
    required List<ExpenseEntity> expenses,
    required double budget,
  }) async {
    final insights = <Insight>[];

    insights.addAll(SpendingAlgorithms.detectAnomalies(expenses));

    final now = DateTime.now();
    final currentMonthExpenses = expenses
        .where((e) => e.date.year == now.year && e.date.month == now.month)
        .toList();
    final burnInsight = SpendingAlgorithms.predictBudgetBurn(
      currentMonthExpenses,
      budget,
    );
    if (burnInsight != null) insights.add(burnInsight);

    return insights;
  }
}
