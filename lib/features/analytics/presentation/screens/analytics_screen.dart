import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_expense_tracker/core/utils/utils.dart';
import 'package:smart_expense_tracker/features/expenses/presentation/providers/expense_providers.dart';
import 'package:smart_expense_tracker/features/analytics/presentation/providers/analytics_providers.dart';
import 'package:smart_expense_tracker/features/spending_intelligence/domain/entities/insight.dart';
import 'package:smart_expense_tracker/features/daily_spend_guard/presentation/widgets/daily_spend_card.dart';

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analytics = ref.watch(monthlyAnalyticsProvider);
    final trendData = ref.watch(monthlyTrendProvider);
    final snapshot = ref.watch(dailySnapshotProvider);
    final warnings = ref.watch(smartWarningsProvider);
    final trendExplanation = ref.watch(trendExplanationProvider);
    final categoryInsights = ref.watch(categoryActionInsightsProvider);
    final theme = Theme.of(context);

    if (!analytics.hasExpenses) {
      return Scaffold(
        appBar: AppBar(title: const Text('Analytics')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.pie_chart_outline,
                size: 64,
                color: theme.colorScheme.secondary,
              ),
              const SizedBox(height: 16),
              const Text('No expenses to analyze yet'),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () => context.pushNamed('add-expense'),
                icon: const Icon(Icons.add),
                label: const Text('Add your first expense'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Insights & Trends')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Daily Spend Guard Card - Always visible at top
            const DailySpendCard(showFullDetails: false),
            const SizedBox(height: 24),
            
            // 1. Daily Snapshot
            _buildDailySnapshot(context, snapshot),
            const SizedBox(height: 24),

            // 2. Smart Warnings
            if (warnings.isNotEmpty) ...[
              Text('Actionable Insights', style: theme.textTheme.titleMedium),
              const SizedBox(height: 12),
              ...warnings.map((insight) => _buildInsightCard(context, insight)),
              const SizedBox(height: 24),
            ],

            // 3. Month Total Card
            _buildTotalCard(context, analytics),
            const SizedBox(height: 32),

            // 4. Monthly Trend
            Text('6-Month Trend', style: theme.textTheme.titleLarge),
            const SizedBox(height: 16),
            _buildTrendSection(context, trendData, trendExplanation, theme),
            const SizedBox(height: 32),

            // 5. Pie Chart
            Text('Spending by Category', style: theme.textTheme.titleLarge),
            const SizedBox(height: 16),
            SizedBox(
              height: 220,
              child: PieChart(
                PieChartData(
                  sections: _getSections(analytics, theme),
                  centerSpaceRadius: 40,
                  sectionsSpace: 2,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // 6. Detailed Breakdown with Insights
            Text('Category Breakdown', style: theme.textTheme.titleLarge),
            const SizedBox(height: 16),
            ...analytics.categoryBreakdown.entries.map((entry) {
              final insight = categoryInsights[entry.key];
              return _buildCategoryTile(
                context,
                entry.key,
                entry.value,
                analytics.total,
                insight,
                theme,
              );
            }),

            const SizedBox(height: 100), // Space for bottom
          ],
        ),
      ),
    );
  }

  Widget _buildDailySnapshot(BuildContext context, DailySnapshot snapshot) {
    final theme = Theme.of(context);
    final isHigher = snapshot.percentChangeVsAverage > 0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Today's Snapshot", style: theme.textTheme.titleSmall),
              if (snapshot.todayTotal > 0)
                Icon(
                  isHigher ? Icons.trending_up : Icons.trending_down,
                  color: isHigher ? Colors.orange : Colors.green,
                  size: 20,
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    CurrencyUtils.formatAmount(snapshot.todayTotal),
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (snapshot.dailyAverage > 0)
                    Text(
                      isHigher
                          ? "${snapshot.percentChangeVsAverage.abs().toStringAsFixed(0)}% higher"
                          : "${snapshot.percentChangeVsAverage.abs().toStringAsFixed(0)}% lower",
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: isHigher ? Colors.orange : Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),
              TextButton(
                onPressed: () => context.pushNamed('expenses'),
                child: const Text('See details'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInsightCard(BuildContext context, Insight insight) {
    final theme = Theme.of(context);
    final color = insight.severity == InsightSeverity.critical
        ? Colors.red
        : insight.severity == InsightSeverity.warning
        ? Colors.orange
        : Colors.blue;

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: color.withOpacity(0.3)),
      ),
      color: color.withOpacity(0.05),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              insight.severity == InsightSeverity.critical
                  ? Icons.error_outline
                  : Icons.lightbulb_outline,
              color: color,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    insight.title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    insight.message,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildQuickAction(context, insight),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAction(BuildContext context, Insight insight) {
    if (insight.type == InsightType.anomaly) {
      final category = insight.metadata?['category'] as String?;
      return TextButton.icon(
        onPressed: () => context.pushNamed('expenses'),
        icon: const Icon(Icons.list_alt, size: 16),
        label: Text('Review $category'),
        style: TextButton.styleFrom(
          visualDensity: VisualDensity.compact,
          padding: EdgeInsets.zero,
        ),
      );
    }
    if (insight.type == InsightType.budgetPrediction) {
      return TextButton.icon(
        onPressed: () => context.pushNamed('budget'),
        icon: const Icon(Icons.account_balance_wallet_outlined, size: 16),
        label: const Text('Adjust Budget'),
        style: TextButton.styleFrom(
          visualDensity: VisualDensity.compact,
          padding: EdgeInsets.zero,
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildTotalCard(BuildContext context, MonthlyAnalytics analytics) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      color: theme.colorScheme.primaryContainer.withOpacity(0.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Month to Date'),
                  const SizedBox(height: 4),
                  Text(
                    CurrencyUtils.formatAmount(analytics.total),
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text('Expenses', style: theme.textTheme.labelSmall),
                  Text(
                    '${analytics.expenseCount}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendSection(
    BuildContext context,
    Map<String, double> data,
    String explanation,
    ThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 180,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              barGroups: _getTrendGroups(data, theme),
              borderData: FlBorderData(show: false),
              titlesData: const FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: _getTitles,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceVariant.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.insights, color: theme.colorScheme.primary, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  explanation,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryTile(
    BuildContext context,
    String category,
    double amount,
    double total,
    CategoryInsight? insight,
    ThemeData theme,
  ) {
    final percentage = (amount / total * 100).toStringAsFixed(1);
    final bool isUp = (insight?.changeVsLastMonth ?? 0) > 0;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: theme.colorScheme.primaryContainer,
        child: Text(category[0].toUpperCase()),
      ),
      title: Row(
        children: [
          Text(category, style: const TextStyle(fontWeight: FontWeight.w600)),
          const Spacer(),
          Text(
            CurrencyUtils.formatAmount(amount),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      subtitle: Row(
        children: [
          Text('$percentage% of total'),
          if (insight != null && insight.changeVsLastMonth != 0) ...[
            const SizedBox(width: 8),
            Icon(
              isUp ? Icons.arrow_upward : Icons.arrow_downward,
              size: 12,
              color: isUp ? Colors.orange : Colors.green,
            ),
            Text(
              ' ${insight.changeVsLastMonth.abs().toStringAsFixed(0)}% vs last month',
              style: TextStyle(
                fontSize: 12,
                color: isUp ? Colors.orange : Colors.green,
              ),
            ),
          ],
        ],
      ),
    );
  }

  List<PieChartSectionData> _getSections(
    MonthlyAnalytics analytics,
    ThemeData theme,
  ) {
    final List<Color> colors = [
      theme.colorScheme.primary,
      theme.colorScheme.secondary,
      theme.colorScheme.tertiary,
      Colors.orange,
      Colors.purple,
      Colors.teal,
    ];

    int index = 0;
    return analytics.categoryBreakdown.entries.map((entry) {
      final color = colors[index % colors.length];
      index++;
      final percentage = (entry.value / analytics.total * 100);

      return PieChartSectionData(
        color: color,
        value: entry.value,
        title: '${percentage.toInt()}%',
        radius: 50,
        titleStyle: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }

  List<BarChartGroupData> _getTrendGroups(
    Map<String, double> data,
    ThemeData theme,
  ) {
    int x = 0;
    return data.entries.map((entry) {
      return BarChartGroupData(
        x: x++,
        barRods: [
          BarChartRodData(
            toY: entry.value,
            color: theme.colorScheme.primary.withOpacity(
              x == data.length ? 1.0 : 0.6,
            ),
            width: 16,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    }).toList();
  }

  static Widget _getTitles(double value, TitleMeta meta) {
    return const Text('', style: TextStyle(fontSize: 10));
  }
}
