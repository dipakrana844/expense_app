import 'package:smart_expense_tracker/core/services/financial_calculator.dart';
import 'package:smart_expense_tracker/features/analytics/domain/entities/analytics_entity.dart';

/// Data Model for Daily Snapshot
class DailySnapshotModel {
  final double todayTotal;
  final double yesterdayTotal;
  final double dailyAverage;
  final double percentChangeVsAverage;

  DailySnapshotModel({
    required this.todayTotal,
    required this.yesterdayTotal,
    required this.dailyAverage,
    required this.percentChangeVsAverage,
  });

  factory DailySnapshotModel.fromEntity(DailySnapshotEntity entity) {
    return DailySnapshotModel(
      todayTotal: entity.todayTotal,
      yesterdayTotal: entity.yesterdayTotal,
      dailyAverage: entity.dailyAverage,
      percentChangeVsAverage: entity.percentChangeVsAverage,
    );
  }

  DailySnapshotEntity toEntity() {
    return DailySnapshotEntity(
      todayTotal: todayTotal,
      yesterdayTotal: yesterdayTotal,
      dailyAverage: dailyAverage,
      percentChangeVsAverage: percentChangeVsAverage,
    );
  }
}

/// Data Model for Category Insight
class CategoryInsightModel {
  final String category;
  final double amount;
  final double percentageOfTotal;
  final double changeVsLastMonth;

  CategoryInsightModel({
    required this.category,
    required this.amount,
    required this.percentageOfTotal,
    required this.changeVsLastMonth,
  });

  factory CategoryInsightModel.fromEntity(CategoryInsightEntity entity) {
    return CategoryInsightModel(
      category: entity.category,
      amount: entity.amount,
      percentageOfTotal: entity.percentageOfTotal,
      changeVsLastMonth: entity.changeVsLastMonth,
    );
  }

  CategoryInsightEntity toEntity() {
    return CategoryInsightEntity(
      category: category,
      amount: amount,
      percentageOfTotal: percentageOfTotal,
      changeVsLastMonth: changeVsLastMonth,
    );
  }
}

/// Data Model for Financial Analytics
class FinancialAnalyticsModel {
  final double totalIncome;
  final double totalExpenses;
  final double netBalance;
  final double savingsRate;
  final FinancialHealth financialHealth;
  final Map<String, double> incomeBySource;
  final int balanceDepletionDays;

  FinancialAnalyticsModel({
    required this.totalIncome,
    required this.totalExpenses,
    required this.netBalance,
    required this.savingsRate,
    required this.financialHealth,
    required this.incomeBySource,
    required this.balanceDepletionDays,
  });

  factory FinancialAnalyticsModel.fromEntity(FinancialAnalyticsEntity entity) {
    return FinancialAnalyticsModel(
      totalIncome: entity.totalIncome,
      totalExpenses: entity.totalExpenses,
      netBalance: entity.netBalance,
      savingsRate: entity.savingsRate,
      financialHealth: entity.financialHealth,
      incomeBySource: Map.from(entity.incomeBySource),
      balanceDepletionDays: entity.balanceDepletionDays,
    );
  }

  FinancialAnalyticsEntity toEntity() {
    return FinancialAnalyticsEntity(
      totalIncome: totalIncome,
      totalExpenses: totalExpenses,
      netBalance: netBalance,
      savingsRate: savingsRate,
      financialHealth: financialHealth,
      incomeBySource: Map.from(incomeBySource),
      balanceDepletionDays: balanceDepletionDays,
    );
  }
}

/// Data Model for Monthly Analytics
class MonthlyAnalyticsModel {
  final double totalSpent;
  final Map<String, double> categoryBreakdown;
  final String? topCategory;
  final double topAmount;
  final int expenseCount;

  MonthlyAnalyticsModel({
    required this.totalSpent,
    required this.categoryBreakdown,
    this.topCategory,
    required this.topAmount,
    required this.expenseCount,
  });

  factory MonthlyAnalyticsModel.fromEntity(MonthlyAnalyticsEntity entity) {
    return MonthlyAnalyticsModel(
      totalSpent: entity.totalSpent,
      categoryBreakdown: Map.from(entity.categoryBreakdown),
      topCategory: entity.topCategory,
      topAmount: entity.topAmount,
      expenseCount: entity.expenseCount,
    );
  }

  MonthlyAnalyticsEntity toEntity() {
    return MonthlyAnalyticsEntity(
      totalSpent: totalSpent,
      categoryBreakdown: Map.from(categoryBreakdown),
      topCategory: topCategory,
      topAmount: topAmount,
      expenseCount: expenseCount,
    );
  }
}
