import 'package:uuid/uuid.dart';
import 'package:smart_expense_tracker/features/expenses/domain/entities/expense_entity.dart';
import 'package:smart_expense_tracker/features/income/domain/entities/income_entity.dart';
import 'package:smart_expense_tracker/core/constants/app_constants.dart';
import '../entities/insight.dart';
import 'dart:math';

class SpendingAlgorithms {
  /// 1. Anomaly Detection
  /// Detects spikes in spending compared to 30-day history
  static List<Insight> detectAnomalies(List<ExpenseEntity> allExpenses) {
    final insights = <Insight>[];
    final now = DateTime.now();
    final thirtyDaysAgo = now.subtract(const Duration(days: 30));
    final todayStart = DateTime(now.year, now.month, now.day);

    // Filter relevant expenses
    final recentExpenses = allExpenses
        .where((e) => e.date.isAfter(thirtyDaysAgo))
        .toList();
    if (recentExpenses.isEmpty) return [];

    // Group by category
    final categoryTotals = <String, double>{};
    final categoryCounts = <String, int>{};

    // Calculate 30-day stats (excluding today)
    for (var expense in recentExpenses) {
      if (expense.date.isBefore(todayStart)) {
        categoryTotals[expense.category] =
            (categoryTotals[expense.category] ?? 0) + expense.amount;
        categoryCounts[expense.category] =
            (categoryCounts[expense.category] ?? 0) + 1;
      }
    }

    final todayExpenses = recentExpenses.where((e) => e.isToday).toList();
    final todayCategoryTotals = <String, double>{};
    for (var e in todayExpenses) {
      todayCategoryTotals[e.category] =
          (todayCategoryTotals[e.category] ?? 0) + e.amount;
    }

    // Check for spikes
    todayCategoryTotals.forEach((category, todayAmount) {
      final historyTotal = categoryTotals[category] ?? 0;
      final historyCount = categoryCounts[category] ?? 0;

      // We need reasonable history to detect anomaly (at least 5 transactions or > 0 amount spread over days)
      // Simpler: Average Daily Spend in last 30 days for this category
      // If we simply divide by 30, it might be too low if they shop once a week.
      // Let's use average per transaction if count > 0, or just look at raw values if meaningful.

      // Strategy: Compare today's total vs Average Daily Spend of last 30 days.
      final avgDaily = historyTotal / 30;

      // If today is > 2x average (and average is significant > 100)
      if (avgDaily > 50 && todayAmount > (avgDaily * 3)) {
        // 300% spike
        insights.add(
          Insight(
            id: const Uuid().v4(),
            type: InsightType.anomaly,
            severity: InsightSeverity.warning,
            title: 'High Spending Alert',
            message:
                'Spending on $category today is ${((todayAmount / avgDaily) * 100).toStringAsFixed(0)}% higher than your usual daily average.',
            createdDate: now,
            isRead: false,
            metadata: {'category': category, 'amount': todayAmount},
          ),
        );
      } else if (historyCount > 5) {
        // Check per-transaction anomaly
        final avgTx = historyTotal / historyCount;
        // If a single transaction today is huge
        for (var e in todayExpenses.where((e) => e.category == category)) {
          if (e.amount > avgTx * 3 && e.amount > 500) {
            insights.add(
              Insight(
                id: const Uuid().v4(),
                type: InsightType.anomaly,
                severity: InsightSeverity.warning,
                title: 'Unusual Expense',
                message:
                    'That ${AppConstants.currencySymbol}${e.amount.toInt()} on $category is unusually high compared to your average of ${AppConstants.currencySymbol}${avgTx.toInt()}.',
                createdDate: now,
                isRead: false,
              ),
            );
            // Break to avoid spamming for same category
            break;
          }
        }
      }
    });

    return insights;
  }

  /// 2. Budget Burn Prediction
  static Insight? predictBudgetBurn(
    List<ExpenseEntity> currentMonthExpenses,
    double monthlyBudget,
  ) {
    if (monthlyBudget <= 0) return null;

    final now = DateTime.now();
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    final dayOfMonth = now.day;

    if (dayOfMonth < 5) return null; // Too early to predict

    final totalSpent = currentMonthExpenses.fold(
      0.0,
      (sum, e) => sum + e.amount,
    );
    final avgDaily = totalSpent / dayOfMonth;
    final predictedTotal = avgDaily * daysInMonth;

    if (predictedTotal > monthlyBudget * 1.05) {
      // Predict exceeding by 5%
      final daysToLimit = (monthlyBudget - totalSpent) / avgDaily;

      if (daysToLimit < (daysInMonth - dayOfMonth)) {
        return Insight(
          id: const Uuid().v4(),
          type: InsightType.budgetPrediction,
          severity: InsightSeverity.critical,
          title: 'Budget Risk',
          message:
              'At this pace, you might exceed your monthly budget in approximately ${daysToLimit.ceil()} days.',
          createdDate: now,
          isRead: false,
        );
      }
    }

    return null;
  }

  /// 3. Category Shift
  static Insight? detectCategoryShift(
    List<ExpenseEntity> currentMonthExpenses,
    List<ExpenseEntity> previousMonthExpenses,
  ) {
    if (currentMonthExpenses.isEmpty || previousMonthExpenses.isEmpty) {
      return null;
    }

    String getTopCategory(List<ExpenseEntity> expenses) {
      final totals = <String, double>{};
      for (var e in expenses) {
        totals[e.category] = (totals[e.category] ?? 0) + e.amount;
      }
      if (totals.isEmpty) return '';
      final sorted = totals.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));
      return sorted.first.key;
    }

    final currTop = getTopCategory(currentMonthExpenses);
    final prevTop = getTopCategory(previousMonthExpenses);

    if (currTop.isNotEmpty && prevTop.isNotEmpty && currTop != prevTop) {
      return Insight(
        id: const Uuid().v4(),
        type: InsightType.categoryDominance,
        severity: InsightSeverity.info,
        title: 'Spending Pattern Change',
        message:
            '$currTop currently replaced $prevTop as your top expense category this month.',
        createdDate: DateTime.now(),
        isRead: false,
      );
    }
    return null;
  }

  /// 4. Smart Daily Tip (Weekend Pattern, etc)
  static Insight? generateDailyTip(List<ExpenseEntity> history) {
    // Simple heuristic: Do they spend more on weekends?
    // Check last 4 weekends vs weekdays avg

    // Or just identifying highest spending day of week

    // Return random helpful insight if data exists
    return null; // For now keeping it simple
  }

  /// 4. Income Consistency Analysis
  /// Detects irregular income patterns
  static Insight? analyzeIncomeConsistency(List<IncomeEntity> incomes) {
    if (incomes.length < 3) return null;

    final now = DateTime.now();
    final threeMonthsAgo = DateTime(now.year, now.month - 3);
    final recentIncomes = incomes
        .where((income) => income.date.isAfter(threeMonthsAgo))
        .toList();

    if (recentIncomes.length < 3) return null;

    // Group by month
    final monthlyTotals = <String, double>{};
    for (var income in recentIncomes) {
      final monthKey = '${income.date.year}-${income.date.month}';
      monthlyTotals[monthKey] = (monthlyTotals[monthKey] ?? 0) + income.amount;
    }

    if (monthlyTotals.length < 2) return null;

    final values = monthlyTotals.values.toList();
    final average = values.reduce((a, b) => a + b) / values.length;
    
    // Calculate coefficient of variation
    final variance = values.map((value) => pow(value - average, 2)).reduce((a, b) => a + b) / values.length;
    final stdDev = sqrt(variance);
    final coefficientOfVariation = average > 0 ? stdDev / average : 0;

    // High variation suggests irregular income
    if (coefficientOfVariation > 0.5) {
      return Insight(
        id: const Uuid().v4(),
        type: InsightType.anomaly,
        severity: InsightSeverity.warning,
        title: 'Income Irregularity Detected',
        message: 'Your income varies significantly month to month. Consider building an emergency fund.',
        createdDate: now,
        isRead: false,
        metadata: {
          'variation_coefficient': coefficientOfVariation,
          'average_monthly_income': average,
        },
      );
    }

    return null;
  }

  /// 5. Savings Rate Analysis
  /// Provides insights about savings performance
  static Insight? analyzeSavingsRate(
    List<IncomeEntity> incomes,
    List<ExpenseEntity> expenses,
  ) {
    if (incomes.isEmpty) return null;

    final now = DateTime.now();
    final currentMonthIncomes = incomes
        .where((income) => 
            income.date.year == now.year && 
            income.date.month == now.month)
        .toList();
    
    final currentMonthExpenses = expenses
        .where((expense) => 
            expense.date.year == now.year && 
            expense.date.month == now.month)
        .toList();

    if (currentMonthIncomes.isEmpty) return null;

    final totalIncome = currentMonthIncomes.fold<double>(0.0, (sum, income) => sum + income.amount);
    final totalExpenses = currentMonthExpenses.fold<double>(0.0, (sum, expense) => sum + expense.amount);
    final savings = totalIncome - totalExpenses;
    final savingsRate = totalIncome > 0 ? (savings / totalIncome) * 100 : 0;

    if (savings < 0) {
      return Insight(
        id: const Uuid().v4(),
        type: InsightType.anomaly,
        severity: InsightSeverity.critical,
        title: 'Expenses Exceed Income',
        message: 'This month, your expenses (${totalExpenses.toStringAsFixed(2)}) exceed your income (${totalIncome.toStringAsFixed(2)}). Review your spending urgently.',
        createdDate: now,
        isRead: false,
        metadata: {
          'income': totalIncome,
          'expenses': totalExpenses,
          'deficit': savings.abs(),
        },
      );
    }

    if (savingsRate >= 50) {
      return Insight(
        id: const Uuid().v4(),
        type: InsightType.budgetPrediction,
        severity: InsightSeverity.info,
        title: 'Excellent Savings Rate!',
        message: 'You saved ${savingsRate.toStringAsFixed(1)}% of your income this month. Keep up the great financial discipline!',
        createdDate: now,
        isRead: false,
        metadata: {
          'savings_rate': savingsRate,
          'amount_saved': savings,
        },
      );
    }

    if (savingsRate >= 20) {
      return Insight(
        id: const Uuid().v4(),
        type: InsightType.categoryDominance,
        severity: InsightSeverity.info,
        title: 'Good Savings Progress',
        message: 'You saved ${savingsRate.toStringAsFixed(1)}% of your income. Consider ways to increase this rate further.',
        createdDate: now,
        isRead: false,
        metadata: {
          'savings_rate': savingsRate,
          'amount_saved': savings,
        },
      );
    }

    return null;
  }

  /// 6. Balance Depletion Warning
  /// Warns when balance is running low
  static Insight? predictBalanceDepletion(
    List<IncomeEntity> incomes,
    List<ExpenseEntity> expenses,
    double currentBalance,
  ) {
    if (currentBalance <= 0 || incomes.isEmpty) return null;

    final now = DateTime.now();
    final thirtyDaysAgo = now.subtract(const Duration(days: 30));
    final recentExpenses = expenses.where((e) => e.date.isAfter(thirtyDaysAgo)).toList();
    
    if (recentExpenses.isEmpty) return null;

    final dailySpendingRate = recentExpenses.fold<double>(0.0, (sum, e) => sum + e.amount) / 30;
    
    if (dailySpendingRate <= 0) return null;

    final daysUntilDepletion = (currentBalance / dailySpendingRate).floor();

    if (daysUntilDepletion <= 7) {
      return Insight(
        id: const Uuid().v4(),
        type: InsightType.budgetPrediction,
        severity: InsightSeverity.warning,
        title: 'Low Balance Alert',
        message: 'At your current spending rate, your balance will reach zero in approximately $daysUntilDepletion days. Consider reducing expenses or adding income.',
        createdDate: now,
        isRead: false,
        metadata: {
          'current_balance': currentBalance,
          'daily_spending_rate': dailySpendingRate,
          'days_until_depletion': daysUntilDepletion,
        },
      );
    }

    return null;
  }
}
