import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_expense_tracker/features/expenses/domain/entities/expense_entity.dart';
import 'package:smart_expense_tracker/features/expenses/presentation/providers/expense_providers.dart';
import 'package:smart_expense_tracker/features/income/domain/entities/income_entity.dart';
import 'package:smart_expense_tracker/features/income/presentation/providers/income_providers.dart';
import 'package:smart_expense_tracker/features/spending_intelligence/domain/entities/insight.dart';
import 'package:smart_expense_tracker/features/spending_intelligence/domain/algorithms/spending_algorithms.dart';
import 'package:smart_expense_tracker/features/budget/presentation/providers/budget_providers.dart';
import 'package:smart_expense_tracker/core/services/balance_service.dart' hide FinancialHealth;
import 'package:smart_expense_tracker/core/services/aggregation_service.dart';
import 'package:smart_expense_tracker/core/services/financial_calculator.dart';

/// Daily Snapshot Data
class DailySnapshot {
  final double todayTotal;
  final double yesterdayTotal;
  final double dailyAverage;
  final double percentChangeVsAverage;

  DailySnapshot({
    required this.todayTotal,
    required this.yesterdayTotal,
    required this.dailyAverage,
    required this.percentChangeVsAverage,
  });
}

/// Category Insight Data
class CategoryInsight {
  final String category;
  final double amount;
  final double percentageOfTotal;
  final double changeVsLastMonth; // percent change

  CategoryInsight({
    required this.category,
    required this.amount,
    required this.percentageOfTotal,
    required this.changeVsLastMonth,
  });
}

/// Provider for Daily Snapshot
/// Uses shared AggregationService for consistent calculations
final dailySnapshotProvider = Provider<DailySnapshot>((ref) {
  final expensesAsync = ref.watch(expensesProvider);
  return expensesAsync.maybeWhen(
    data: (expenses) {
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
      
      final todayTotal = AggregationService.calculateTotal(transactions: todayExpenses);
      final yesterdayTotal = AggregationService.calculateTotal(transactions: yesterdayExpenses);
      
      // Use shared service for daily average calculation
      final dailyAverage = AggregationService.calculateDailyAverage(transactions: expenses);

      double percentChange = 0;
      if (dailyAverage > 0) {
        percentChange = ((todayTotal - dailyAverage) / dailyAverage) * 100;
      }

      return DailySnapshot(
        todayTotal: todayTotal,
        yesterdayTotal: yesterdayTotal,
        dailyAverage: dailyAverage,
        percentChangeVsAverage: percentChange,
      );
    },
    orElse: () => DailySnapshot(
      todayTotal: 0,
      yesterdayTotal: 0,
      dailyAverage: 0,
      percentChangeVsAverage: 0,
    ),
  );
});

/// Provider for Smart Warnings
final smartWarningsProvider = Provider<List<Insight>>((ref) {
  final expensesAsync = ref.watch(expensesProvider);
  // We might also need budget info
  final budget = ref.watch(monthlyBudgetProvider).asData?.value ?? 0.0;

  return expensesAsync.maybeWhen(
    data: (expenses) {
      final insights = <Insight>[];

      // 1. Anomalies (spikes today)
      insights.addAll(SpendingAlgorithms.detectAnomalies(expenses));

      // 2. Budget burn
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
    },
    orElse: () => [],
  );
});

/// Provider for Trend Explanation
final trendExplanationProvider = Provider<String>((ref) {
  final trendData = ref.watch(monthlyTrendProvider);
  if (trendData.isEmpty) return "No data to analyze trends.";

  final entries = trendData.entries.toList();
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

  // Find max in last 6 months
  final maxSpend = entries.map((e) => e.value).reduce((a, b) => a > b ? a : b);
  if (currentMonth >= maxSpend && currentMonth > 0) {
    return "This month is your highest spending in 6 months.";
  }

  return "Your spending is relatively stable compared to last month.";
});

/// Provider for Category Action Insights
final categoryActionInsightsProvider = Provider<Map<String, CategoryInsight>>((
  ref,
) {
  final expensesAsync = ref.watch(expensesProvider);

  return expensesAsync.maybeWhen(
    data: (expenses) {
      final now = DateTime.now();
      final currentMonthExpenses = expenses
          .where((e) => e.date.year == now.year && e.date.month == now.month)
          .toList();

      final lastMonth = DateTime(now.year, now.month - 1);
      final lastMonthExpenses = expenses
          .where(
            (e) =>
                e.date.year == lastMonth.year &&
                e.date.month == lastMonth.month,
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

      final insights = <String, CategoryInsight>{};
      currentTotals.forEach((cat, amt) {
        final lastAmt = lastTotals[cat] ?? 0;
        double change = 0;
        if (lastAmt > 0) {
          change = ((amt - lastAmt) / lastAmt) * 100;
        }

        insights[cat] = CategoryInsight(
          category: cat,
          amount: amt,
          percentageOfTotal: totalCurrent > 0 ? (amt / totalCurrent) * 100 : 0,
          changeVsLastMonth: change,
        );
      });

      return insights;
    },
    orElse: () => {},
  );
});

/// Enhanced Financial Analytics Data
class FinancialAnalytics {
  final double totalIncome;
  final double totalExpenses;
  final double netBalance;
  final double savingsRate;
  final FinancialHealth financialHealth;
  final Map<String, double> incomeBySource;
  final int balanceDepletionDays;

  FinancialAnalytics({
    required this.totalIncome,
    required this.totalExpenses,
    required this.netBalance,
    required this.savingsRate,
    required this.financialHealth,
    required this.incomeBySource,
    required this.balanceDepletionDays,
  });

  factory FinancialAnalytics.empty() => FinancialAnalytics(
        totalIncome: 0.0,
        totalExpenses: 0.0,
        netBalance: 0.0,
        savingsRate: 0.0,
        financialHealth: FinancialHealth.poor,
        incomeBySource: {},
        balanceDepletionDays: 0,
      );
}

/// Provider for Enhanced Financial Analytics
final financialAnalyticsProvider = Provider<FinancialAnalytics>((ref) {
  final incomesAsync = ref.watch(incomesProvider);
  final expensesAsync = ref.watch(expensesProvider);
  
  return incomesAsync.when(
    data: (incomes) => expensesAsync.when(
      data: (expenses) {
        final balanceService = BalanceService();
        
        final totalIncome = balanceService.getTotalIncome(incomes: incomes.cast<IncomeEntity>());
        final totalExpenses = balanceService.getTotalExpenses(expenses: expenses.cast<ExpenseEntity>());
        final netBalance = balanceService.getCurrentBalance(
          incomes: incomes.cast<IncomeEntity>(),
          expenses: expenses.cast<ExpenseEntity>(),
        );
        final savingsRate = balanceService.getSavingsRate(
          incomes: incomes.cast<IncomeEntity>(),
          expenses: expenses.cast<ExpenseEntity>(),
        );
        final financialHealth = FinancialCalculator.assessFinancialHealth(
          transactions: [...incomes.cast(), ...expenses.cast()],
        );
        final incomeBySource = balanceService.getIncomeSourceBreakdown(incomes.cast<IncomeEntity>());
        
        // Calculate balance depletion (assuming current daily spending rate)
        final now = DateTime.now();
        final thirtyDaysAgo = now.subtract(const Duration(days: 30));
        final recentExpenses = expenses.where((e) => e.date.isAfter(thirtyDaysAgo)).toList();
        final dailySpendingRate = recentExpenses.fold<double>(0.0, (sum, e) => sum + e.amount) / 30;
        final balanceDepletionDays = balanceService.getBalanceDepletionDays(
          currentBalance: netBalance,
          dailySpendingRate: dailySpendingRate,
        ) ?? 0;

        return FinancialAnalytics(
          totalIncome: totalIncome,
          totalExpenses: totalExpenses,
          netBalance: netBalance,
          savingsRate: savingsRate,
          financialHealth: financialHealth,
          incomeBySource: incomeBySource,
          balanceDepletionDays: balanceDepletionDays,
        );
      },
      loading: () => FinancialAnalytics.empty(),
      error: (_, __) => FinancialAnalytics.empty(),
    ),
    loading: () => FinancialAnalytics.empty(),
    error: (_, __) => FinancialAnalytics.empty(),
  );
});

/// Provider for Income vs Expense Trend Data
final incomeExpenseTrendProvider = Provider<Map<String, Map<String, double>>>((ref) {
  final incomesAsync = ref.watch(incomesProvider);
  final expensesAsync = ref.watch(expensesProvider);
  
  return incomesAsync.when(
    data: (incomes) => expensesAsync.when(
      data: (expenses) {
        final trendData = <String, Map<String, double>>{};
        
        // Get last 6 months
        final now = DateTime.now();
        for (int i = 5; i >= 0; i--) {
          final month = DateTime(now.year, now.month - i);
          final monthKey = '${month.year}-${month.month.toString().padLeft(2, '0')}';
          
          // Calculate income for this month
          final monthIncomes = incomes.where((income) => 
            income.date.year == month.year && income.date.month == month.month
          );
          final totalIncome = monthIncomes.fold<double>(0.0, (sum, income) => sum + income.amount);
          
          // Calculate expenses for this month
          final monthExpenses = expenses.where((expense) => 
            expense.date.year == month.year && expense.date.month == month.month
          );
          final totalExpense = monthExpenses.fold<double>(0.0, (sum, expense) => sum + expense.amount);
          
          trendData[monthKey] = {
            'income': totalIncome,
            'expense': totalExpense,
            'net': totalIncome - totalExpense,
          };
        }
        
        return trendData;
      },
      loading: () => {},
      error: (_, __) => {},
    ),
    loading: () => {},
    error: (_, __) => {},
  );
});
