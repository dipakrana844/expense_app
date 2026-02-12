import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../providers/financial_trend_providers.dart';

/// Widget: Net Balance Trend Chart
///
/// Purpose: Visualizes cumulative net balance progression over time
/// - Smooth line chart showing financial growth/decline
/// - Highlights current month performance
/// - Dark theme optimized for fintech aesthetic
/// - Professional and clean visualization
class NetBalanceTrendChart extends ConsumerWidget {
  final double height;
  
  const NetBalanceTrendChart({
    super.key,
    this.height = 200,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trendSpots = ref.watch(netBalanceTrendProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (trendSpots.isEmpty) {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Net Worth Trend',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              _buildCurrentBalanceIndicator(ref, theme),
            ],
          ),
          const SizedBox(height: 16),
          
          // Chart
          Expanded(
            child: LineChart(
              _buildChartData(trendSpots, theme, isDark),
            ),
          ),
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
              Icons.show_chart_outlined,
              size: 48,
              color: isDark ? Colors.grey[600] : Colors.grey[400],
            ),
            const SizedBox(height: 12),
            Text(
              'No financial data yet',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Start tracking income and expenses to see your net worth trend',
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

  /// Build current balance indicator
  Widget _buildCurrentBalanceIndicator(WidgetRef ref, ThemeData theme) {
    final trendAsync = ref.watch(financialTrendProvider);
    final isDark = theme.brightness == Brightness.dark;
    
    return trendAsync.maybeWhen(
      data: (trend) {
        if (trend.netBalanceTrend.isEmpty) return const SizedBox.shrink();
        
        final currentBalance = trend.netBalanceTrend.last.cumulativeBalance;
        final previousBalance = trend.netBalanceTrend.length > 1 
            ? trend.netBalanceTrend[trend.netBalanceTrend.length - 2].cumulativeBalance 
            : currentBalance;
        
        final change = currentBalance - previousBalance;
        final isPositive = change >= 0;
        
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: isPositive 
                ? (isDark ? Colors.green[900] : Colors.green[100])
                : (isDark ? Colors.red[900] : Colors.red[100]),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isPositive ? Icons.trending_up : Icons.trending_down,
                size: 16,
                color: isPositive 
                    ? (isDark ? Colors.green[300] : Colors.green[700])
                    : (isDark ? Colors.red[300] : Colors.red[700]),
              ),
              const SizedBox(width: 4),
              Text(
                '${change >= 0 ? '+' : ''}${NumberFormat.currency(symbol: '\$').format(change)}',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isPositive 
                      ? (isDark ? Colors.green[300] : Colors.green[700])
                      : (isDark ? Colors.red[300] : Colors.red[700]),
                ),
              ),
            ],
          ),
        );
      },
      orElse: () => const SizedBox.shrink(),
    );
  }

  /// Build chart data configuration
  LineChartData _buildChartData(List<FlSpot> spots, ThemeData theme, bool isDark) {
    if (spots.isEmpty) {
      return _buildEmptyChartData(theme, isDark);
    }

    return LineChartData(
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          curveSmoothness: 0.3,
          color: isDark ? Colors.blue[300] : Colors.blue[600],
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) {
              final isLastPoint = index == spots.length - 1;
              return FlDotCirclePainter(
                radius: isLastPoint ? 6 : 4,
                color: isLastPoint 
                    ? (isDark ? Colors.blue[200]! : Colors.blue[700]!)
                    : (isDark ? Colors.blue[400]! : Colors.blue[500]!),
                strokeWidth: isLastPoint ? 3 : 0,
                strokeColor: isDark ? Colors.blue[100]! : Colors.blue[300]!,
              );
            },
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                (isDark ? Colors.blue[400]! : Colors.blue[200]!).withOpacity(0.3),
                (isDark ? Colors.blue[600]! : Colors.blue[100]!).withOpacity(0.0),
              ],
            ),
          ),
        ),
      ],
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: (value, meta) {
              if (value.toInt() >= 0 && value.toInt() < _getMonthLabels().length) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    _getMonthLabels()[value.toInt()],
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
        horizontalInterval: _calculateHorizontalInterval(spots),
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: isDark ? Colors.grey[800] : Colors.grey[200],
            strokeWidth: 0.5,
          );
        },
      ),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: (spots.length - 1).toDouble(),
      minY: _calculateMinY(spots),
      maxY: _calculateMaxY(spots),
    );
  }

  /// Build empty chart data for placeholder state
  LineChartData _buildEmptyChartData(ThemeData theme, bool isDark) {
    return LineChartData(
      lineBarsData: [],
      titlesData: FlTitlesData(show: false),
      gridData: FlGridData(show: false),
      borderData: FlBorderData(show: false),
    );
  }

  /// Get month labels for x-axis
  List<String> _getMonthLabels() {
    final now = DateTime.now();
    final labels = <String>[];
    
    for (int i = 11; i >= 0; i--) {
      final monthDate = DateTime(now.year, now.month - i, 1);
      labels.add(DateFormat('MMM').format(monthDate));
    }
    
    return labels;
  }

  /// Calculate horizontal grid interval
  double _calculateHorizontalInterval(List<FlSpot> spots) {
    if (spots.length <= 6) return 1;
    return (spots.length / 6).roundToDouble();
  }

  /// Calculate minimum Y value for chart
  double _calculateMinY(List<FlSpot> spots) {
    if (spots.isEmpty) return 0;
    final minSpot = spots.reduce((a, b) => a.y < b.y ? a : b);
    final buffer = (minSpot.y * 0.1).abs();
    return minSpot.y - buffer;
  }

  /// Calculate maximum Y value for chart
  double _calculateMaxY(List<FlSpot> spots) {
    if (spots.isEmpty) return 100;
    final maxSpot = spots.reduce((a, b) => a.y > b.y ? a : b);
    final buffer = (maxSpot.y * 0.1).abs();
    return maxSpot.y + buffer;
  }
}