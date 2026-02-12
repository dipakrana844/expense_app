import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/financial_trend_dto.dart';
import '../widgets/net_balance_chart.dart';
import '../widgets/income_expense_comparison_chart.dart';
import '../widgets/financial_health_summary.dart';
import '../providers/financial_trend_providers.dart';

/// Screen: Accounts Overview
///
/// Purpose: Main dashboard for financial trend analysis
/// - Consolidates all financial trend components
/// - Vertical compact layout as specified
/// - Dark-first fintech design aesthetic
/// - Single source of truth for financial direction
class AccountsOverviewScreen extends ConsumerWidget {
  const AccountsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Net Worth Dashboard'),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.refresh(financialTrendProvider),
            tooltip: 'Refresh data',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Net Balance Trend Chart
            const NetBalanceTrendChart(height: 220),
            const SizedBox(height: 20),
            
            // Section 2: Income vs Expense Comparison
            const IncomeExpenseComparisonChart(height: 280),
            const SizedBox(height: 20),
            
            // Section 3: Financial Health Summary
            const FinancialHealthSummary(),
            const SizedBox(height: 20),
            
            // Section 4: Financial Insights (if any)
            _buildInsightsSection(ref, theme, isDark),
          ],
        ),
      ),
    );
  }

  /// Build financial insights section
  Widget _buildInsightsSection(WidgetRef ref, ThemeData theme, bool isDark) {
    final insights = ref.watch(financialInsightsProvider);
    
    if (insights.isEmpty) {
      return const SizedBox.shrink();
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
          Text(
            'Financial Insights',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          ...insights.map((insight) => _buildInsightCard(insight, theme, isDark)).toList(),
        ],
      ),
    );
  }

  /// Build individual insight card
  Widget _buildInsightCard(dynamic insight, ThemeData theme, bool isDark) {
    final IconData icon;
    final Color iconColor;
    final Color backgroundColor;
    
    switch (insight.severity) {
      case InsightSeverity.critical:
        icon = Icons.error_outline;
        iconColor = isDark ? Colors.red[300]! : Colors.red[700]!;
        backgroundColor = isDark ? Colors.red[900]! : Colors.red[50]!;
        break;
      case InsightSeverity.warning:
        icon = Icons.warning_amber_outlined;
        iconColor = isDark ? Colors.orange[300]! : Colors.orange[700]!;
        backgroundColor = isDark ? Colors.orange[900]! : Colors.orange[50]!;
        break;
      case InsightSeverity.info:
      default:
        icon = Icons.info_outline;
        iconColor = isDark ? Colors.blue[300]! : Colors.blue[700]!;
        backgroundColor = isDark ? Colors.blue[900]! : Colors.blue[50]!;
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: iconColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  insight.title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  insight.message,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isDark ? Colors.grey[300] : Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}