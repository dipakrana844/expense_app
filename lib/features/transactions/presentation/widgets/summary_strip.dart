import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/utils.dart';
import '../../data/repositories/transaction_repository.dart';
import '../providers/transaction_providers.dart';

/// Widget: SummaryStrip
///
/// Displays key financial metrics in a sticky header.
/// Shows Income, Expenses, and Net Balance with clear visual hierarchy.
class SummaryStrip extends ConsumerWidget {
  final bool isSticky;

  const SummaryStrip({
    super.key,
    this.isSticky = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(transactionSummaryProvider);
    final theme = Theme.of(context);

    return summaryAsync.when(
      data: (summary) => _buildSummaryContent(context, theme, summary),
      loading: () => _buildLoadingState(theme),
      error: (error, _) => _buildErrorState(theme, error.toString()),
    );
  }

  Widget _buildSummaryContent(
      BuildContext context, ThemeData theme, TransactionSummary summary) {
    final netBalance = summary.netBalance;
    final isPositive = netBalance >= 0;
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: isSticky
            ? [
                BoxShadow(
                  color: theme.colorScheme.shadow.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(
                Icons.account_balance_wallet,
                color: theme.colorScheme.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Financial Summary',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Metrics Row
          Row(
            children: [
              // Income
              _buildMetricCard(
                context,
                'Income',
                CurrencyUtils.formatAmount(summary.totalIncome),
                Icons.trending_up,
                theme.colorScheme.primary,
              ),
              
              const SizedBox(width: 12),
              
              // Expenses
              _buildMetricCard(
                context,
                'Expenses',
                CurrencyUtils.formatAmount(summary.totalExpenses),
                Icons.trending_down,
                theme.colorScheme.error,
              ),
              
              const SizedBox(width: 12),
              
              // Net Balance
              Expanded(
                child: _buildNetBalanceCard(
                  context,
                  netBalance,
                  isPositive,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Additional Stats
          _buildAdditionalStats(context, theme, summary),
        ],
      ),
    );
  }

  Widget _buildMetricCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    final theme = Theme.of(context);
    
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 4),
            Text(
              value,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNetBalanceCard(
    BuildContext context,
    double netBalance,
    bool isPositive,
  ) {
    final theme = Theme.of(context);
    final color = isPositive 
        ? theme.colorScheme.primary 
        : theme.colorScheme.error;
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            isPositive ? Icons.savings : Icons.warning,
            color: color,
            size: 20,
          ),
          const SizedBox(height: 4),
          Text(
            CurrencyUtils.formatAmount(netBalance.abs()),
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            isPositive ? 'Savings' : 'Loss',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalStats(
      BuildContext context, ThemeData theme, TransactionSummary summary) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            context,
            '${summary.incomeCount}',
            'Income Entries',
            theme.colorScheme.primary,
          ),
          _buildStatItem(
            context,
            '${summary.expenseCount}',
            'Expense Entries',
            theme.colorScheme.error,
          ),
          _buildStatItem(
            context,
            '${summary.transactionCount}',
            'Total',
            theme.colorScheme.secondary,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String value,
    String label,
    Color color,
  ) {
    final theme = Theme.of(context);
    
    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontSize: 11,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildLoadingState(ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: isSticky
            ? [
                BoxShadow(
                  color: theme.colorScheme.shadow.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildErrorState(ThemeData theme, String error) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: isSticky
            ? [
                BoxShadow(
                  color: theme.colorScheme.shadow.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.error_outline,
              color: theme.colorScheme.error,
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              'Unable to load summary',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}