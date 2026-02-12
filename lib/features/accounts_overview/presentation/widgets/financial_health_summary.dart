import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/financial_trend_dto.dart';
import '../providers/financial_trend_providers.dart';

/// Widget: Financial Health Summary
///
/// Purpose: Displays key financial health metrics in compact cards
/// - Average income and expenses
/// - Savings rate percentage
/// - Income consistency score
/// - Best and worst month performance
/// - Typography-based hierarchy instead of heavy decoration
class FinancialHealthSummary extends ConsumerWidget {
  const FinancialHealthSummary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final healthMetrics = ref.watch(financialHealthMetricsProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (healthMetrics == null) {
      return _buildLoadingState(context, theme);
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark 
                ? Colors.black.withOpacity(0.3) 
                : Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Financial Health',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          
          // Metrics Grid
          _buildMetricsGrid(healthMetrics, theme, isDark),
          
          const SizedBox(height: 16),
          
          // Performance Summary
          _buildPerformanceSummary(healthMetrics, theme, isDark),
        ],
      ),
    );
  }

  /// Build loading state
  Widget _buildLoadingState(BuildContext context, ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120,
            height: 20,
            color: isDark ? Colors.grey[700] : Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Row(
            children: List.generate(4, (_) => 
              Expanded(
                child: Container(
                  height: 80,
                  margin: const EdgeInsets.only(right: 8),
                  color: isDark ? Colors.grey[800] : Colors.grey[200],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build metrics grid with key financial indicators
  Widget _buildMetricsGrid(FinancialHealthMetrics metrics, ThemeData theme, bool isDark) {
    return Column(
      children: [
        // First row: Income, Expense, Savings Rate
        Row(
          children: [
            _buildMetricCard(
              title: 'Avg. Monthly Income',
              value: NumberFormat.currency(symbol: '\$').format(metrics.averageMonthlyIncome),
              subtitle: 'Consistent earnings',
              color: Colors.green,
              theme: theme,
              isDark: isDark,
            ),
            const SizedBox(width: 12),
            _buildMetricCard(
              title: 'Avg. Monthly Expenses',
              value: NumberFormat.currency(symbol: '\$').format(metrics.averageMonthlyExpense),
              subtitle: 'Regular spending',
              color: Colors.orange,
              theme: theme,
              isDark: isDark,
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Second row: Savings Rate, Consistency
        Row(
          children: [
            _buildMetricCard(
              title: 'Savings Rate',
              value: '${metrics.savingsRate.toStringAsFixed(1)}%',
              subtitle: _getSavingsRateDescription(metrics.savingsRate),
              color: _getSavingsRateColor(metrics.savingsRate),
              theme: theme,
              isDark: isDark,
            ),
            const SizedBox(width: 12),
            _buildMetricCard(
              title: 'Income Consistency',
              value: '${metrics.incomeConsistency.toStringAsFixed(0)}%',
              subtitle: _getConsistencyDescription(metrics.incomeConsistency),
              color: _getConsistencyColor(metrics.incomeConsistency),
              theme: theme,
              isDark: isDark,
            ),
          ],
        ),
      ],
    );
  }

  /// Build individual metric card
  Widget _buildMetricCard({
    required String title,
    required String value,
    required String subtitle,
    required Color color,
    required ThemeData theme,
    required bool isDark,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[900] : Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.bodySmall?.copyWith(
                color: isDark ? Colors.grey[400] : Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: theme.textTheme.bodySmall?.copyWith(
                color: isDark ? Colors.grey[500] : Colors.grey[500],
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build performance summary section
  Widget _buildPerformanceSummary(FinancialHealthMetrics metrics, ThemeData theme, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Performance Highlights',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildPerformanceItem(
                label: 'Best Month',
                value: metrics.bestMonth.monthKey,
                amount: metrics.bestMonth.netBalance,
                isPositive: true,
                theme: theme,
                isDark: isDark,
              ),
              const SizedBox(width: 16),
              _buildPerformanceItem(
                label: 'Worst Month',
                value: metrics.worstMonth.monthKey,
                amount: metrics.worstMonth.netBalance,
                isPositive: metrics.worstMonth.netBalance >= 0,
                theme: theme,
                isDark: isDark,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build individual performance item
  Widget _buildPerformanceItem({
    required String label,
    required String value,
    required double amount,
    required bool isPositive,
    required ThemeData theme,
    required bool isDark,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: isDark ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
          const SizedBox(height: 2),
          Text(
            _formatMonthKey(value),
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          Text(
            '${isPositive ? '+' : ''}${NumberFormat.currency(symbol: '\$').format(amount)}',
            style: theme.textTheme.bodySmall?.copyWith(
              color: isPositive 
                  ? (isDark ? Colors.green[400] : Colors.green[700])
                  : (isDark ? Colors.red[400] : Colors.red[700]),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  /// Get savings rate description based on value
  String _getSavingsRateDescription(double rate) {
    if (rate >= 50) return 'Excellent savings';
    if (rate >= 20) return 'Good savings';
    if (rate >= 0) return 'Moderate savings';
    return 'Negative savings';
  }

  /// Get savings rate color based on value
  Color _getSavingsRateColor(double rate) {
    if (rate >= 50) return Colors.green;
    if (rate >= 20) return Colors.lightGreen;
    if (rate >= 0) return Colors.orange;
    return Colors.red;
  }

  /// Get consistency description based on value
  String _getConsistencyDescription(double consistency) {
    if (consistency >= 80) return 'Very consistent';
    if (consistency >= 60) return 'Consistent';
    if (consistency >= 40) return 'Moderate';
    return 'Variable';
  }

  /// Get consistency color based on value
  Color _getConsistencyColor(double consistency) {
    if (consistency >= 80) return Colors.green;
    if (consistency >= 60) return Colors.lightGreen;
    if (consistency >= 40) return Colors.orange;
    return Colors.red;
  }

  /// Format month key (YYYY-MM) to readable format
  String _formatMonthKey(String monthKey) {
    try {
      final parts = monthKey.split('-');
      if (parts.length != 2) return monthKey;
      
      final year = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final date = DateTime(year, month, 1);
      
      return DateFormat('MMM yyyy').format(date);
    } catch (e) {
      return monthKey;
    }
  }
}