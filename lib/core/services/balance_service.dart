import 'dart:math' as math;
import '../../features/income/domain/entities/income_entity.dart';
import '../../features/expenses/domain/entities/expense_entity.dart';

/// Service: BalanceService
///
/// Purpose: Central service for calculating financial balances and metrics
/// - Computes current balance from income and expenses
/// - Calculates savings rates and financial health metrics
/// - Provides period-based financial summaries
///
/// Design Decision: Single source of truth for financial calculations
/// - Encapsulates all balance-related business logic
/// - Provides consistent calculations across the app
/// - Enables easy testing and maintenance
class BalanceService {
  /// Calculate current balance (income minus expenses)
  /// 
  /// Parameters:
  /// - incomes: List of IncomeEntity for the period
  /// - expenses: List of ExpenseEntity for the period
  /// 
  /// Returns: Current balance (can be negative if expenses exceed income)
  double getCurrentBalance({
    required List<IncomeEntity> incomes,
    required List<ExpenseEntity> expenses,
  }) {
    final totalIncome = incomes.fold<double>(0.0, (sum, income) => sum + income.amount);
    final totalExpenses = expenses.fold<double>(0.0, (sum, expense) => sum + expense.amount);
    
    return totalIncome - totalExpenses;
  }

  /// Calculate total income for a specific period
  /// 
  /// Parameters:
  /// - incomes: List of IncomeEntity to calculate from
  /// - startDate: Optional start date filter (inclusive)
  /// - endDate: Optional end date filter (inclusive)
  /// 
  /// Returns: Sum of income amounts within the specified period
  double getTotalIncome({
    required List<IncomeEntity> incomes,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    Iterable<IncomeEntity> filteredIncomes = incomes;
    
    if (startDate != null) {
      filteredIncomes = filteredIncomes.where((income) => !income.date.isBefore(startDate));
    }
    
    if (endDate != null) {
      filteredIncomes = filteredIncomes.where((income) => !income.date.isAfter(endDate));
    }
    
    return filteredIncomes.fold<double>(0.0, (sum, income) => sum + income.amount);
  }

  /// Calculate total expenses for a specific period
  /// 
  /// Parameters:
  /// - expenses: List of ExpenseEntity to calculate from
  /// - startDate: Optional start date filter (inclusive)
  /// - endDate: Optional end date filter (inclusive)
  /// 
  /// Returns: Sum of expense amounts within the specified period
  double getTotalExpenses({
    required List<ExpenseEntity> expenses,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    Iterable<ExpenseEntity> filteredExpenses = expenses;
    
    if (startDate != null) {
      filteredExpenses = filteredExpenses.where((expense) => !expense.date.isBefore(startDate));
    }
    
    if (endDate != null) {
      filteredExpenses = filteredExpenses.where((expense) => !expense.date.isAfter(endDate));
    }
    
    return filteredExpenses.fold<double>(0.0, (sum, expense) => sum + expense.amount);
  }

  /// Calculate savings rate as percentage
  /// 
  /// Formula: ((Income - Expenses) / Income) * 100
  /// Returns 0 if no income, 100% if no expenses
  /// 
  /// Parameters:
  /// - incomes: List of IncomeEntity for the period
  /// - expenses: List of ExpenseEntity for the period
  /// 
  /// Returns: Savings rate as percentage (0-100)
  double getSavingsRate({
    required List<IncomeEntity> incomes,
    required List<ExpenseEntity> expenses,
  }) {
    final totalIncome = getTotalIncome(incomes: incomes);
    final totalExpenses = getTotalExpenses(expenses: expenses);
    
    // Handle edge cases
    if (totalIncome <= 0) return 0.0; // No income = no savings
    if (totalExpenses <= 0) return 100.0; // No expenses = 100% savings
    
    final savings = totalIncome - totalExpenses;
    return (savings / totalIncome) * 100;
  }

  /// Calculate net worth change for a period
  /// 
  /// Parameters:
  /// - incomes: List of IncomeEntity for the period
  /// - expenses: List of ExpenseEntity for the period
  /// 
  /// Returns: Net change (positive = gain, negative = loss)
  double getNetWorthChange({
    required List<IncomeEntity> incomes,
    required List<ExpenseEntity> expenses,
  }) {
    return getCurrentBalance(incomes: incomes, expenses: expenses);
  }

  /// Get financial health status based on savings rate
  /// 
  /// Categories:
  /// - Excellent: 50%+ savings rate
  /// - Good: 20-49% savings rate
  /// - Fair: 5-19% savings rate
  /// - Poor: 0-4% savings rate
  /// - Negative: Negative savings (spending more than earning)
  FinancialHealth getFinancialHealth({
    required List<IncomeEntity> incomes,
    required List<ExpenseEntity> expenses,
  }) {
    final savingsRate = getSavingsRate(incomes: incomes, expenses: expenses);
    
    if (savingsRate < 0) return FinancialHealth.negative;
    if (savingsRate >= 50) return FinancialHealth.excellent;
    if (savingsRate >= 20) return FinancialHealth.good;
    if (savingsRate >= 5) return FinancialHealth.fair;
    return FinancialHealth.poor;
  }

  /// Calculate projected balance depletion timeline
  /// 
  /// Estimates how many days current balance will last at current spending rate
  /// 
  /// Parameters:
  /// - currentBalance: Current financial balance
  /// - dailySpendingRate: Average daily spending amount
  /// 
  /// Returns: Number of days until balance depletion, or null if balance is increasing
  int? getBalanceDepletionDays({
    required double currentBalance,
    required double dailySpendingRate,
  }) {
    if (dailySpendingRate <= 0) return null; // Balance won't deplete
    if (currentBalance <= 0) return 0; // Already depleted
    
    return (currentBalance / dailySpendingRate).floor();
  }

  /// Calculate income consistency score (0-100)
  /// Higher scores indicate more predictable/stable income
  /// 
  /// Parameters:
  /// - incomes: List of IncomeEntity for analysis
  /// - periodMonths: Number of months to analyze
  /// 
  /// Returns: Consistency score (0 = highly irregular, 100 = perfectly consistent)
  double getIncomeConsistencyScore({
    required List<IncomeEntity> incomes,
    required int periodMonths,
  }) {
    if (incomes.isEmpty || periodMonths <= 0) return 0.0;
    
    // Group incomes by month
    final monthlyTotals = <String, double>{};
    
    for (final income in incomes) {
      final monthKey = '${income.date.year}-${income.date.month}';
      monthlyTotals[monthKey] = (monthlyTotals[monthKey] ?? 0) + income.amount;
    }
    
    if (monthlyTotals.length < 2) return 100.0; // Perfect consistency with 0-1 data points
    
    // Calculate average and standard deviation
    final values = monthlyTotals.values.toList();
    final average = values.reduce((a, b) => a + b) / values.length;
    
    if (average == 0) return 0.0;
    
    final variance = values.map((value) => math.pow(value - average, 2)).reduce((a, b) => a + b) / values.length;
    final standardDeviation = math.sqrt(variance);
    
    // Convert to consistency score (inverse of coefficient of variation)
    final coefficientOfVariation = standardDeviation / average;
    final consistencyScore = (1 - coefficientOfVariation.clamp(0, 1)) * 100;
    
    return (consistencyScore.clamp(0, 100) as num).toDouble();
  }

  /// Get income source breakdown
  /// 
  /// Parameters:
  /// - incomes: List of IncomeEntity to analyze
  /// 
  /// Returns: Map of source names to total amounts
  Map<String, double> getIncomeSourceBreakdown(List<IncomeEntity> incomes) {
    final breakdown = <String, double>{};
    
    for (final income in incomes) {
      breakdown[income.source] = (breakdown[income.source] ?? 0) + income.amount;
    }
    
    return breakdown;
  }

  /// Check if expenses exceed income for the period
  bool areExpensesExceedingIncome({
    required List<IncomeEntity> incomes,
    required List<ExpenseEntity> expenses,
  }) {
    return getCurrentBalance(incomes: incomes, expenses: expenses) < 0;
  }
}

/// Enum representing financial health categories
enum FinancialHealth {
  excellent, // 50%+ savings rate
  good,      // 20-49% savings rate
  fair,      // 5-19% savings rate
  poor,      // 0-4% savings rate
  negative   // Spending more than earning
}

