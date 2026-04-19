import 'package:smart_expense_tracker/core/services/financial_calculator.dart';
import 'package:smart_expense_tracker/features/spending_intelligence/domain/entities/insight.dart';

/// Daily Snapshot Data - Entity
class DailySnapshotEntity {
  final double todayTotal;
  final double yesterdayTotal;
  final double dailyAverage;
  final double percentChangeVsAverage;

  DailySnapshotEntity({
    required this.todayTotal,
    required this.yesterdayTotal,
    required this.dailyAverage,
    required this.percentChangeVsAverage,
  });

  factory DailySnapshotEntity.empty() => DailySnapshotEntity(
    todayTotal: 0.0,
    yesterdayTotal: 0.0,
    dailyAverage: 0.0,
    percentChangeVsAverage: 0.0,
  );
}

/// Category Insight Data - Entity
class CategoryInsightEntity {
  final String category;
  final double amount;
  final double percentageOfTotal;
  final double changeVsLastMonth; // percent change

  CategoryInsightEntity({
    required this.category,
    required this.amount,
    required this.percentageOfTotal,
    required this.changeVsLastMonth,
  });
}

/// Enhanced Financial Analytics Data - Entity
class FinancialAnalyticsEntity {
  final double totalIncome;
  final double totalExpenses;
  final double netBalance;
  final double savingsRate;
  final FinancialHealth financialHealth;
  final Map<String, double> incomeBySource;
  final int balanceDepletionDays;

  FinancialAnalyticsEntity({
    required this.totalIncome,
    required this.totalExpenses,
    required this.netBalance,
    required this.savingsRate,
    required this.financialHealth,
    required this.incomeBySource,
    required this.balanceDepletionDays,
  });

  factory FinancialAnalyticsEntity.empty() => FinancialAnalyticsEntity(
    totalIncome: 0.0,
    totalExpenses: 0.0,
    netBalance: 0.0,
    savingsRate: 0.0,
    financialHealth: FinancialHealth.poor,
    incomeBySource: {},
    balanceDepletionDays: 0,
  );
}

/// Monthly Analytics Entity
class MonthlyAnalyticsEntity {
  final double totalSpent;
  final Map<String, double> categoryBreakdown;
  final String? topCategory;
  final double topAmount;
  final int expenseCount;
  final bool hasExpenses;

  MonthlyAnalyticsEntity({
    required this.totalSpent,
    required this.categoryBreakdown,
    this.topCategory,
    required this.topAmount,
    required this.expenseCount,
  }) : hasExpenses = expenseCount > 0;

  factory MonthlyAnalyticsEntity.empty() => MonthlyAnalyticsEntity(
    totalSpent: 0.0,
    categoryBreakdown: {},
    topCategory: null,
    topAmount: 0.0,
    expenseCount: 0,
  );
}

/// Trend Data Entity
class TrendDataEntity {
  final Map<String, double> monthlyTrend;
  final String explanation;

  TrendDataEntity({required this.monthlyTrend, required this.explanation});

  factory TrendDataEntity.empty() =>
      TrendDataEntity(monthlyTrend: {}, explanation: 'No data available');
}

/// Unified Analytics Data - Entity
///
/// Purpose: Single source of truth for all analytics data
/// - Eliminates duplicate calculations
/// - Easier to cache and manage
/// - Better performance
class AnalyticsData {
  final DailySnapshotEntity dailySnapshot;
  final List<Insight> smartWarnings;
  final String trendExplanation;
  final Map<String, CategoryInsightEntity> categoryInsights;
  final FinancialAnalyticsEntity financialAnalytics;
  final Map<String, Map<String, double>> incomeExpenseTrend;
  final MonthlyAnalyticsEntity monthlyAnalytics;
  final Map<String, double> monthlyTrend;

  AnalyticsData({
    required this.dailySnapshot,
    required this.smartWarnings,
    required this.trendExplanation,
    required this.categoryInsights,
    required this.financialAnalytics,
    required this.incomeExpenseTrend,
    required this.monthlyAnalytics,
    required this.monthlyTrend,
  });

  factory AnalyticsData.empty() => AnalyticsData(
    dailySnapshot: DailySnapshotEntity.empty(),
    smartWarnings: [],
    trendExplanation: 'No data available',
    categoryInsights: {},
    financialAnalytics: FinancialAnalyticsEntity.empty(),
    incomeExpenseTrend: {},
    monthlyAnalytics: MonthlyAnalyticsEntity.empty(),
    monthlyTrend: {},
  );
}

/// Income vs Expense Trend Entity
class IncomeExpenseTrendEntity {
  final Map<String, Map<String, double>> trendData;

  IncomeExpenseTrendEntity({required this.trendData});

  factory IncomeExpenseTrendEntity.empty() =>
      IncomeExpenseTrendEntity(trendData: {});
}
