import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/financial_trend_dto.dart';
import '../providers/financial_trend_providers.dart';

/// Widget: Income vs Expense Comparison Chart
///
/// Purpose: Visualizes monthly income and expense comparisons
/// - Grouped bar chart showing income (blue) vs expense (red)
/// - Compact and readable design
/// - 6-12 months of historical data
/// - Clear financial direction visualization
class IncomeExpenseComparisonChart extends ConsumerWidget {
  final double height;
  
  const IncomeExpenseComparisonChart({
    super.key,
    this.height = 250,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final comparisons = ref.watch(incomeExpenseComparisonProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (comparisons.isEmpty) {
      return _buildEmptyState(context, theme);
    }

    return Container(
      height: height,
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
            'Monthly Income vs Expenses',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          
          // Chart
          Expanded(
            child: BarChart(
              _buildChartData(comparisons, theme, isDark),
            ),
          ),
          
          // Legend
          const SizedBox(height: 16),
          _buildLegend(theme, isDark),
        ],
      ),
    );
  }

  /// Build empty state when no data is available
  Widget _buildEmptyState(BuildContext context, ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    
    return Container(
      height: height,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bar_chart_outlined,
              size: 48,
              color: isDark ? Colors.grey[600] : Colors.grey[400],
            ),
            const SizedBox(height: 12),
            Text(
              'No monthly data available',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Track income and expenses for multiple months to see comparisons',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: isDark ? Colors.grey[500] : Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build chart data configuration
  BarChartData _buildChartData(List<IncomeExpenseComparison> comparisons, ThemeData theme, bool isDark) {
    if (comparisons.isEmpty) {
      return _buildEmptyChartData(theme, isDark);
    }

    return BarChartData(
      barGroups: _generateBarGroups(comparisons),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: (value, meta) {
              final index = value.toInt();
              if (index >= 0 && index < comparisons.length) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    _formatMonthLabel(comparisons[index].monthKey),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 50,
            getTitlesWidget: (value, meta) {
              return Text(
                NumberFormat.compactCurrency(symbol: '\$').format(value),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                ),
              );
            },
          ),
        ),
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: _calculateHorizontalInterval(comparisons),
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: isDark ? Colors.grey[800] : Colors.grey[200],
            strokeWidth: 0.5,
          );
        },
      ),
      borderData: FlBorderData(show: false),
      barTouchData: BarTouchData(
        enabled: true,
      ),
      maxY: _calculateMaxY(comparisons),
    );
  }

  /// Generate bar groups for the chart
  List<BarChartGroupData> _generateBarGroups(List<IncomeExpenseComparison> comparisons) {
    return comparisons.asMap().entries.map((entry) {
      final index = entry.key;
      final comparison = entry.value;
      
      return BarChartGroupData(
        x: index,
        barRods: [
          // Income bar (Blue)
          BarChartRodData(
            toY: comparison.income,
            color: const Color(0xFF6C63FF), // Primary blue
            width: 12,
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide.none,
          ),
          // Expense bar (Red)
          BarChartRodData(
            toY: comparison.expense,
            color: const Color(0xFFEF5350), // Muted red
            width: 12,
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide.none,
          ),
        ],
        showingTooltipIndicators: [],
      );
    }).toList();
  }

  /// Build empty chart data for placeholder state
  BarChartData _buildEmptyChartData(ThemeData theme, bool isDark) {
    return BarChartData(
      barGroups: [],
      titlesData: FlTitlesData(show: false),
      gridData: FlGridData(show: false),
      borderData: FlBorderData(show: false),
    );
  }

  /// Build legend for chart interpretation
  Widget _buildLegend(ThemeData theme, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLegendItem(
          color: const Color(0xFF6C63FF),
          label: 'Income',
          theme: theme,
          isDark: isDark,
        ),
        const SizedBox(width: 24),
        _buildLegendItem(
          color: const Color(0xFFEF5350),
          label: 'Expenses',
          theme: theme,
          isDark: isDark,
        ),
      ],
    );
  }

  /// Build individual legend item
  Widget _buildLegendItem({
    required Color color,
    required String label,
    required ThemeData theme,
    required bool isDark,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: isDark ? Colors.grey[300] : Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  /// Format month label from YYYY-MM format
  String _formatMonthLabel(String monthKey) {
    try {
      final parts = monthKey.split('-');
      if (parts.length != 2) return monthKey;
      
      final year = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final date = DateTime(year, month, 1);
      
      return DateFormat('MMM').format(date);
    } catch (e) {
      return monthKey;
    }
  }

  /// Calculate horizontal grid interval
  double _calculateHorizontalInterval(List<IncomeExpenseComparison> comparisons) {
    if (comparisons.isEmpty) return 1;
    final maxValue = comparisons
        .map((c) => c.income > c.expense ? c.income : c.expense)
        .reduce((a, b) => a > b ? a : b);
    return maxValue / 5;
  }

  /// Calculate maximum Y value for chart
  double _calculateMaxY(List<IncomeExpenseComparison> comparisons) {
    if (comparisons.isEmpty) return 100;
    
    final maxValue = comparisons
        .map((c) => c.income > c.expense ? c.income : c.expense)
        .reduce((a, b) => a > b ? a : b);
    
    final buffer = maxValue * 0.1;
    return maxValue + buffer;
  }
}