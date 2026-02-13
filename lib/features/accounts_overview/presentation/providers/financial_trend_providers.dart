import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../transactions/presentation/providers/transaction_providers.dart';
import '../../domain/entities/financial_trend_dto.dart';
import '../../domain/usecases/financial_trend_usecase.dart';

/// Provider: Financial Trend Use Case
///
/// Purpose: Provides the financial trend use case with required dependencies
final financialTrendUseCaseProvider = Provider<FinancialTrendUseCase>((ref) {
  return FinancialTrendUseCase();
});

/// Provider: Financial Trend Data
///
/// Purpose: Main provider for complete financial trend analysis
/// - Fetches unified transaction data
/// - Processes through use case
/// - Provides comprehensive financial dashboard data
final financialTrendProvider = FutureProvider<FinancialTrendDTO>((ref) async {
  final useCase = ref.watch(financialTrendUseCaseProvider);
  final transactionsAsync = ref.watch(allTransactionsProvider);
  
  return transactionsAsync.when(
    data: (transactions) {
      return useCase.getFinancialTrend(
        transactions: transactions,
        monthsBack: 12,
      );
    },
    loading: () => throw Exception('Loading transactions'),
    error: (error, stack) => throw Exception('Failed to load transactions: $error'),
  );
});

/// Provider: Net Balance Trend for Chart
///
/// Purpose: Converts financial trend data to fl_chart compatible format
/// - Maps monthly balance points to FlSpot coordinates
/// - Ready for line chart visualization
final netBalanceTrendProvider = Provider<List<FlSpot>>((ref) {
  final trendAsync = ref.watch(financialTrendProvider);
  
  return trendAsync.maybeWhen(
    data: (trend) {
      return trend.netBalanceTrend
          .asMap()
          .entries
          .map((entry) => FlSpot(entry.key.toDouble(), entry.value.cumulativeBalance))
          .toList();
    },
    orElse: () => [],
  );
});

/// Provider: Income vs Expense Comparisons for Chart
///
/// Purpose: Prepares monthly comparison data for bar chart visualization
/// - Structures data for grouped bar chart
/// - Separates income and expense values
final incomeExpenseComparisonProvider = Provider<List<IncomeExpenseComparison>>((ref) {
  final trendAsync = ref.watch(financialTrendProvider);
  
  return trendAsync.maybeWhen(
    data: (trend) => trend.monthlyComparisons,
    orElse: () => [],
  );
});

/// Provider: Financial Health Metrics
///
/// Purpose: Provides key financial health indicators
/// - Average income/expense calculations
/// - Savings rate and consistency metrics
/// - Best/worst month performance
final financialHealthMetricsProvider = Provider<FinancialHealthMetrics?>((ref) {
  final trendAsync = ref.watch(financialTrendProvider);
  
  return trendAsync.maybeWhen(
    data: (trend) => trend.healthMetrics,
    orElse: () => null,
  );
});

/// Provider: Financial Insights
///
/// Purpose: Provides intelligent financial insights
/// - Trend analysis notifications
/// - Anomaly detections
/// - Performance recommendations
final financialInsightsProvider = Provider<List<FinancialInsight>>((ref) {
  final trendAsync = ref.watch(financialTrendProvider);
  
  return trendAsync.maybeWhen(
    data: (trend) => trend.insights,
    orElse: () => [],
  );
});

/// Provider: Current Month Financial Summary
///
/// Purpose: Provides quick access to current month financial status
/// - Current month income, expenses, and net change
/// - Useful for real-time dashboard updates
final currentMonthFinancialSummaryProvider = Provider<MonthlyBalancePoint?>((ref) {
  final trendAsync = ref.watch(financialTrendProvider);
  
  return trendAsync.maybeWhen(
    data: (trend) {
      if (trend.netBalanceTrend.isEmpty) return null;
      
      final now = DateTime.now();
      final currentMonthKey = '${now.year}-${now.month.toString().padLeft(2, '0')}';
      
      return trend.netBalanceTrend.firstWhere(
        (point) => point.monthKey == currentMonthKey,
        orElse: () => trend.netBalanceTrend.last,
      );
    },
    orElse: () => null,
  );
});