import 'dart:math';
import 'package:uuid/uuid.dart';
import '../../../../../core/domain/interfaces/transaction_interface.dart';
import '../../../../../core/services/aggregation_service.dart';
import '../../../../../core/services/balance_service.dart';
import '../../../../../features/spending_intelligence/domain/algorithms/spending_algorithms.dart';
import '../../../../../features/income/domain/entities/income_entity.dart';
import '../../../../../features/expenses/domain/entities/expense_entity.dart';
import '../entities/financial_trend_dto.dart';

/// Use Case: Financial Trend Analysis
///
/// Purpose: Single source of truth for all financial trend calculations
/// - Aggregates income and expense data
/// - Calculates cumulative net balance over time
/// - Generates financial health metrics
/// - Produces intelligent insights
/// - Reuses existing AggregationService for consistency
class FinancialTrendUseCase {
  final BalanceService _balanceService;

  FinancialTrendUseCase({required BalanceService balanceService})
      : _balanceService = balanceService;

  /// Get comprehensive financial trend analysis
  ///
  /// Parameters:
  /// - transactions: Unified list of income and expense transactions
  /// - monthsBack: How many months of history to analyze (default: 12)
  ///
  /// Returns: Complete financial trend data including charts, metrics, and insights
  Future<FinancialTrendDTO> getFinancialTrend({
    required List<TransactionInterface> transactions,
    int monthsBack = 12,
  }) async {
    // Filter to relevant time period
    final cutoffDate = DateTime.now().subtract(Duration(days: 30 * monthsBack));
    final filteredTransactions = transactions
        .where((t) => t.date.isAfter(cutoffDate))
        .toList();

    // Separate income and expenses
    final incomes = filteredTransactions
        .where((t) => t.isIncome)
        .map((t) => t as IncomeEntity)
        .toList();
    
    final expenses = filteredTransactions
        .where((t) => t.isExpense)
        .map((t) => t as ExpenseEntity)
        .toList();

    // Generate all components
    final netBalanceTrend = _calculateNetBalanceTrend(
      incomes: incomes,
      expenses: expenses,
      monthsBack: monthsBack,
    );

    final monthlyComparisons = _calculateMonthlyComparisons(
      incomes: incomes,
      expenses: expenses,
      monthsBack: monthsBack,
    );

    final healthMetrics = _calculateHealthMetrics(
      incomes: incomes,
      expenses: expenses,
    );

    final insights = _generateFinancialInsights(
      incomes: incomes,
      expenses: expenses,
      netBalanceTrend: netBalanceTrend,
      healthMetrics: healthMetrics,
    );

    return FinancialTrendDTO(
      netBalanceTrend: netBalanceTrend,
      monthlyComparisons: monthlyComparisons,
      healthMetrics: healthMetrics,
      insights: insights,
    );
  }

  /// Calculate cumulative net balance trend over time
  List<MonthlyBalancePoint> _calculateNetBalanceTrend({
    required List<IncomeEntity> incomes,
    required List<ExpenseEntity> expenses,
    required int monthsBack,
  }) {
    final trendPoints = <MonthlyBalancePoint>[];
    double cumulativeBalance = 0.0;

    // Get all unique months with data
    final allDates = <DateTime>[
      ...incomes.map((i) => i.date),
      ...expenses.map((e) => e.date),
    ];

    if (allDates.isEmpty) {
      return [];
    }

    // Sort dates and get month range
    allDates.sort();
    final startDate = DateTime(
      allDates.first.year,
      allDates.first.month,
      1,
    );
    
    final endDate = DateTime.now();
    
    // Generate points for each month in range
    DateTime currentDate = startDate;
    while (currentDate.isBefore(endDate) || 
           (currentDate.year == endDate.year && currentDate.month == endDate.month)) {
      
      // Filter transactions for current month
      final monthIncomes = AggregationService.filterByMonth(
        transactions: incomes,
        year: currentDate.year,
        month: currentDate.month,
      ).cast<IncomeEntity>();

      final monthExpenses = AggregationService.filterByMonth(
        transactions: expenses,
        year: currentDate.year,
        month: currentDate.month,
      ).cast<ExpenseEntity>();

      // Calculate monthly totals
      final monthlyIncome = _balanceService.getTotalIncome(
        incomes: monthIncomes,
      );
      
      final monthlyExpense = _balanceService.getTotalExpenses(
        expenses: monthExpenses,
      );
      
      final netChange = monthlyIncome - monthlyExpense;
      cumulativeBalance += netChange;

      trendPoints.add(MonthlyBalancePoint(
        monthKey: '${currentDate.year}-${currentDate.month.toString().padLeft(2, '0')}',
        date: currentDate,
        cumulativeBalance: cumulativeBalance,
        monthlyIncome: monthlyIncome,
        monthlyExpense: monthlyExpense,
        netChange: netChange,
      ));

      // Move to next month
      currentDate = DateTime(currentDate.year, currentDate.month + 1, 1);
    }

    return trendPoints;
  }

  /// Calculate monthly income vs expense comparisons
  List<IncomeExpenseComparison> _calculateMonthlyComparisons({
    required List<IncomeEntity> incomes,
    required List<ExpenseEntity> expenses,
    required int monthsBack,
  }) {
    final comparisons = <IncomeExpenseComparison>[];
    
    final now = DateTime.now();
    
    // Calculate for last N months
    for (int i = monthsBack - 1; i >= 0; i--) {
      final monthDate = DateTime(now.year, now.month - i, 1);
      
      final monthIncomes = AggregationService.filterByMonth(
        transactions: incomes,
        year: monthDate.year,
        month: monthDate.month,
      ).cast<IncomeEntity>();

      final monthExpenses = AggregationService.filterByMonth(
        transactions: expenses,
        year: monthDate.year,
        month: monthDate.month,
      ).cast<ExpenseEntity>();

      final incomeTotal = _balanceService.getTotalIncome(incomes: monthIncomes);
      final expenseTotal = _balanceService.getTotalExpenses(expenses: monthExpenses);
      
      comparisons.add(IncomeExpenseComparison(
        monthKey: '${monthDate.year}-${monthDate.month.toString().padLeft(2, '0')}',
        income: incomeTotal,
        expense: expenseTotal,
        difference: incomeTotal - expenseTotal,
      ));
    }

    return comparisons;
  }

  /// Calculate key financial health metrics
  FinancialHealthMetrics _calculateHealthMetrics({
    required List<IncomeEntity> incomes,
    required List<ExpenseEntity> expenses,
  }) {
    if (incomes.isEmpty && expenses.isEmpty) {
      return FinancialHealthMetrics(
        averageMonthlyIncome: 0.0,
        averageMonthlyExpense: 0.0,
        savingsRate: 0.0,
        incomeConsistency: 0.0,
        bestMonth: MonthlyPerformance(monthKey: '', netBalance: 0.0, savingsRate: 0.0),
        worstMonth: MonthlyPerformance(monthKey: '', netBalance: 0.0, savingsRate: 0.0),
      );
    }

    // Group by month for analysis
    final monthlyData = <String, Map<String, double>>{};
    
    // Process incomes
    for (final income in incomes) {
      final monthKey = '${income.date.year}-${income.date.month.toString().padLeft(2, '0')}';
      monthlyData.putIfAbsent(monthKey, () => {'income': 0.0, 'expense': 0.0});
      monthlyData[monthKey]!['income'] = monthlyData[monthKey]!['income']! + income.amount;
    }
    
    // Process expenses
    for (final expense in expenses) {
      final monthKey = '${expense.date.year}-${expense.date.month.toString().padLeft(2, '0')}';
      monthlyData.putIfAbsent(monthKey, () => {'income': 0.0, 'expense': 0.0});
      monthlyData[monthKey]!['expense'] = monthlyData[monthKey]!['expense']! + expense.amount;
    }

    // Calculate averages
    final incomeValues = monthlyData.values.map((m) => m['income']!).toList();
    final expenseValues = monthlyData.values.map((m) => m['expense']!).toList();
    
    final avgIncome = incomeValues.isNotEmpty 
        ? incomeValues.reduce((a, b) => a + b) / incomeValues.length 
        : 0.0;
        
    final avgExpense = expenseValues.isNotEmpty 
        ? expenseValues.reduce((a, b) => a + b) / expenseValues.length 
        : 0.0;

    // Calculate savings rate
    final savingsRate = avgIncome > 0 
        ? ((avgIncome - avgExpense) / avgIncome) * 100 
        : 0.0;

    // Calculate income consistency
    final incomeConsistency = _calculateIncomeConsistency(incomeValues);

    // Find best and worst months
    MonthlyPerformance bestMonth = MonthlyPerformance(
      monthKey: '', 
      netBalance: double.negativeInfinity, 
      savingsRate: 0.0
    );
    
    MonthlyPerformance worstMonth = MonthlyPerformance(
      monthKey: '', 
      netBalance: double.infinity, 
      savingsRate: 0.0
    );

    monthlyData.forEach((monthKey, data) {
      final income = data['income']!;
      final expense = data['expense']!;
      final netBalance = income - expense;
      final monthSavingsRate = income > 0 ? ((income - expense) / income) * 100 : 0.0;
      
      if (netBalance > bestMonth.netBalance) {
        bestMonth = MonthlyPerformance(
          monthKey: monthKey,
          netBalance: netBalance,
          savingsRate: monthSavingsRate,
        );
      }
      
      if (netBalance < worstMonth.netBalance) {
        worstMonth = MonthlyPerformance(
          monthKey: monthKey,
          netBalance: netBalance,
          savingsRate: monthSavingsRate,
        );
      }
    });

    return FinancialHealthMetrics(
      averageMonthlyIncome: avgIncome,
      averageMonthlyExpense: avgExpense,
      savingsRate: savingsRate,
      incomeConsistency: incomeConsistency,
      bestMonth: bestMonth,
      worstMonth: worstMonth,
    );
  }

  /// Calculate income consistency score (0-100)
  double _calculateIncomeConsistency(List<double> incomeValues) {
    if (incomeValues.isEmpty) return 0.0;
    if (incomeValues.length == 1) return 100.0; // Perfect consistency with one data point
    
    final average = incomeValues.reduce((a, b) => a + b) / incomeValues.length;
    if (average == 0) return 0.0;
    
    // Calculate standard deviation
    final variance = incomeValues
        .map((value) => pow(value - average, 2))
        .reduce((a, b) => a + b) / incomeValues.length;
    
    final standardDeviation = sqrt(variance);
    
    // Convert to consistency score (inverse of coefficient of variation)
    final coefficientOfVariation = standardDeviation / average;
    final consistencyScore = (1 - coefficientOfVariation.clamp(0, 1)) * 100;
    
    return consistencyScore.clamp(0, 100).toDouble();
  }

  /// Generate intelligent financial insights
  List<FinancialInsight> _generateFinancialInsights({
    required List<IncomeEntity> incomes,
    required List<ExpenseEntity> expenses,
    required List<MonthlyBalancePoint> netBalanceTrend,
    required FinancialHealthMetrics healthMetrics,
  }) {
    final insights = <FinancialInsight>[];

    // Use existing spending intelligence algorithms
    final incomeInsight = SpendingAlgorithms.analyzeIncomeConsistency(incomes);
    if (incomeInsight != null) {
      insights.add(FinancialInsight(
        id: const Uuid().v4(),
        type: InsightType.warning,
        severity: InsightSeverity.warning,
        title: incomeInsight.title,
        message: incomeInsight.message,
        createdDate: incomeInsight.createdDate,
        isRead: false,
        metadata: incomeInsight.metadata,
      ));
    }

    // Add trend-based insights
    insights.addAll(_generateTrendInsights(netBalanceTrend, healthMetrics));

    return insights;
  }

  /// Generate insights based on financial trends
  List<FinancialInsight> _generateTrendInsights(
    List<MonthlyBalancePoint> trend,
    FinancialHealthMetrics metrics,
  ) {
    final insights = <FinancialInsight>[];
    final now = DateTime.now();

    if (trend.length < 3) return insights; // Need at least 3 months for trend analysis

    // Check for declining trend
    int decliningMonths = 0;
    for (int i = trend.length - 1; i > 0 && decliningMonths < 3; i--) {
      if (trend[i].cumulativeBalance < trend[i - 1].cumulativeBalance) {
        decliningMonths++;
      } else {
        break;
      }
    }

    if (decliningMonths >= 3) {
      insights.add(FinancialInsight(
        id: const Uuid().v4(),
        type: InsightType.trend,
        severity: InsightSeverity.warning,
        title: 'Declining Net Worth Trend',
        message: 'Your net balance has declined for $decliningMonths consecutive months. Consider reviewing your spending habits.',
        createdDate: now,
        isRead: false,
      ));
    }

    // Check savings rate improvement
    if (metrics.savingsRate > 20) {
      insights.add(FinancialInsight(
        id: const Uuid().v4(),
        type: InsightType.milestone,
        severity: InsightSeverity.info,
        title: 'Healthy Savings Rate Achieved',
        message: 'Your savings rate of ${metrics.savingsRate.toStringAsFixed(1)}% is excellent. Keep up the good work!',
        createdDate: now,
        isRead: false,
      ));
    }

    return insights;
  }
}