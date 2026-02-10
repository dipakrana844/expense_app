import 'dart:math';
import '../domain/interfaces/transaction_interface.dart';

/// Service: FinancialCalculator
///
/// Purpose: Consolidate complex financial business logic calculations
/// - Daily spend limit calculations
/// - Budget burn predictions
/// - Anomaly detection algorithms
/// - Income consistency scoring
///
/// Design Principles:
/// 1. Stateless calculations - Pure functions with no side effects
/// 2. Reusable algorithms - Generic across different data sources
/// 3. Configurable thresholds - Easy to adjust sensitivity parameters
/// 4. Well-documented formulas - Clear explanation of calculation logic
class FinancialCalculator {
  FinancialCalculator._();

  // Configuration constants
  static const double _anomalyThreshold = 3.0; // 3x average spending
  static const double _minimumAverageForAnomaly = 50.0; // Minimum ₹50 average
  static const double _budgetWarningThreshold = 0.8; // 80% of budget
  static const double _budgetCriticalThreshold = 1.0; // 100% of budget
  static const int _consistencyMinimumMonths = 2; // Need at least 2 months data

  /// Calculate daily spending limit based on budget or historical average
  ///
  /// Parameters:
  /// - monthlyBudget: Optional monthly budget amount
  /// - historicalExpenses: List of recent expense transactions
  /// - targetDate: Date for which to calculate limit (defaults to today)
  ///
  /// Returns: Recommended daily spending limit
  static double calculateDailyLimit({
    double? monthlyBudget,
    List<TransactionInterface>? historicalExpenses,
    DateTime? targetDate,
  }) {
    final calculationDate = targetDate ?? DateTime.now();
    final daysRemaining = DateTime(calculationDate.year, calculationDate.month + 1, 0).day - calculationDate.day + 1;
    
    // Method 1: Budget-based calculation (primary)
    if (monthlyBudget != null && monthlyBudget > 0) {
      final daysInMonth = DateTime(calculationDate.year, calculationDate.month + 1, 0).day;
      return monthlyBudget / daysInMonth;
    }
    
    // Method 2: Historical average (fallback)
    if (historicalExpenses != null && historicalExpenses.isNotEmpty) {
      final recentExpenses = historicalExpenses.where((e) => e.isExpense).toList();
      if (recentExpenses.isNotEmpty) {
        final totalAmount = recentExpenses.fold<double>(0.0, (sum, expense) => sum + expense.amount);
        final daysOfData = calculationDate.difference(recentExpenses.last.date).inDays + 1;
        return totalAmount / daysOfData;
      }
    }
    
    // Fallback to conservative estimate
    return 0.0;
  }

  /// Predict when budget will be exhausted based on current spending velocity
  ///
  /// Parameters:
  /// - currentMonthExpenses: List of expenses for current month
  /// - monthlyBudget: Monthly budget limit
  ///
  /// Returns: Days until budget exhaustion, or null if not applicable
  static int? predictBudgetBurnout({
    required List<TransactionInterface> currentMonthExpenses,
    required double monthlyBudget,
  }) {
    if (monthlyBudget <= 0 || currentMonthExpenses.isEmpty) return null;
    
    final now = DateTime.now();
    final daysPassed = now.day;
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    final daysRemaining = daysInMonth - daysPassed;
    
    if (daysRemaining <= 0) return null;
    
    final totalSpent = currentMonthExpenses.fold<double>(0.0, (sum, e) => sum + e.amount);
    final dailyAverage = daysPassed > 0 ? totalSpent / daysPassed : 0;
    
    if (dailyAverage <= 0) return null;
    
    final remainingBudget = monthlyBudget - totalSpent;
    if (remainingBudget <= 0) return 0; // Already exceeded
    
    final daysToLimit = (remainingBudget / dailyAverage).ceil();
    return min(daysToLimit, daysRemaining);
  }

  /// Detect anomalous spending patterns using statistical analysis
  ///
  /// Parameters:
  /// - todayTransactions: Transactions from today
  /// - historicalTransactions: Recent historical transactions (last 30 days)
  /// - category: Specific category to analyze (null for all categories)
  ///
  /// Returns: True if anomalous spending detected
  static bool detectAnomaly({
    required List<TransactionInterface> todayTransactions,
    required List<TransactionInterface> historicalTransactions,
    String? category,
  }) {
    // Filter by category if specified
    List<TransactionInterface> todayExpenses = todayTransactions.where((t) => t.isExpense).toList();
    List<TransactionInterface> historyExpenses = historicalTransactions.where((t) => t.isExpense).toList();
    
    if (category != null) {
      todayExpenses = todayExpenses.where((t) => t.categoryOrSource == category).toList();
      historyExpenses = historyExpenses.where((t) => t.categoryOrSource == category).toList();
    }
    
    if (todayExpenses.isEmpty || historyExpenses.isEmpty) return false;
    
    // Calculate today's total
    final todayTotal = todayExpenses.fold<double>(0.0, (sum, t) => sum + t.amount);
    
    // Calculate historical average daily spending for this category
    final historyTotal = historyExpenses.fold<double>(0.0, (sum, t) => sum + t.amount);
    final avgDaily = historyTotal / 30; // 30-day average
    
    // Anomaly detection: today's spending > threshold × average AND average is significant
    return avgDaily > _minimumAverageForAnomaly && 
           todayTotal > (avgDaily * _anomalyThreshold);
  }

  /// Calculate income consistency score based on monthly variation
  ///
  /// Parameters:
  /// - incomeTransactions: List of income transactions over time
  ///
  /// Returns: Consistency score (0-100) where higher is more consistent
  static double calculateIncomeConsistency({
    required List<TransactionInterface> incomeTransactions,
  }) {
    final incomeOnly = incomeTransactions.where((t) => t.isIncome).toList();
    if (incomeOnly.length < _consistencyMinimumMonths) return 100.0; // Perfect consistency with insufficient data
    
    // Group by month
    final monthlyTotals = <String, double>{};
    for (final income in incomeOnly) {
      final monthKey = income.monthKey;
      monthlyTotals[monthKey] = (monthlyTotals[monthKey] ?? 0) + income.amount;
    }
    
    if (monthlyTotals.length < _consistencyMinimumMonths) return 100.0;
    
    // Calculate coefficient of variation
    final values = monthlyTotals.values.toList();
    final average = values.reduce((a, b) => a + b) / values.length;
    
    if (average == 0) return 0.0;
    
    final variance = values.map((value) => pow(value - average, 2)).reduce((a, b) => a + b) / values.length;
    final standardDeviation = sqrt(variance);
    final coefficientOfVariation = standardDeviation / average;
    
    // Convert to consistency score (inverse of coefficient of variation)
    final consistencyScore = (1 - coefficientOfVariation.clamp(0, 1)) * 100;
    return (consistencyScore.clamp(0, 100) as num).toDouble();
  }

  /// Calculate savings rate from mixed income/expense transactions
  ///
  /// Parameters:
  /// - transactions: Mixed list of income and expense transactions
  ///
  /// Returns: Savings rate as percentage (can be negative)
  static double calculateSavingsRate({
    required List<TransactionInterface> transactions,
  }) {
    double totalIncome = 0.0;
    double totalExpenses = 0.0;
    
    for (final transaction in transactions) {
      if (transaction.isIncome) {
        totalIncome += transaction.amount;
      } else {
        totalExpenses += transaction.amount;
      }
    }
    
    if (totalIncome <= 0) return 0.0;
    
    final savings = totalIncome - totalExpenses;
    return (savings / totalIncome) * 100;
  }

  /// Assess financial health based on spending patterns
  ///
  /// Parameters:
  /// - transactions: Recent transactions to analyze
  /// - monthlyBudget: Optional monthly budget for context
  ///
  /// Returns: Financial health assessment
  static FinancialHealth assessFinancialHealth({
    required List<TransactionInterface> transactions,
    double? monthlyBudget,
  }) {
    final now = DateTime.now();
    final currentMonthTransactions = transactions.where((t) => t.isCurrentMonth).toList();
    
    // Calculate key metrics
    final savingsRate = calculateSavingsRate(transactions: currentMonthTransactions);
    final totalIncome = currentMonthTransactions.where((t) => t.isIncome).fold(0.0, (sum, t) => sum + t.amount);
    final totalExpenses = currentMonthTransactions.where((t) => t.isExpense).fold(0.0, (sum, t) => sum + t.amount);
    
    // Determine health level
    if (savingsRate >= 20) {
      return FinancialHealth.excellent;
    } else if (savingsRate >= 10) {
      return FinancialHealth.good;
    } else if (savingsRate >= 0) {
      return FinancialHealth.fair;
    } else {
      return FinancialHealth.poor;
    }
  }

  /// Get budget status indicators
  ///
  /// Parameters:
  /// - currentMonthExpenses: Expenses for current month
  /// - monthlyBudget: Monthly budget limit
  ///
  /// Returns: Budget status information
  static BudgetStatus getBudgetStatus({
    required List<TransactionInterface> currentMonthExpenses,
    required double monthlyBudget,
  }) {
    if (monthlyBudget <= 0) {
      return BudgetStatus.noBudget;
    }
    
    final totalSpent = currentMonthExpenses.fold<double>(0.0, (sum, e) => sum + e.amount);
    final progress = totalSpent / monthlyBudget;
    
    if (progress >= _budgetCriticalThreshold) {
      return BudgetStatus.exceeded;
    } else if (progress >= _budgetWarningThreshold) {
      return BudgetStatus.warning;
    } else {
      return BudgetStatus.safe;
    }
  }
}

/// Enum: Financial Health Assessment Levels
enum FinancialHealth {
  excellent, // Savings rate ≥ 20%
  good,      // Savings rate 10-19%
  fair,      // Savings rate 0-9%
  poor       // Negative savings rate
}

/// Enum: Budget Status Indicators
enum BudgetStatus {
  safe,      // Within budget limits
  warning,   // Approaching budget limit (80%+)
  exceeded,  // Budget exceeded
  noBudget   // No budget set
}