 import 'package:flutter/material.dart' hide DateUtils;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/transaction_repository.dart';
import '../providers/transaction_providers.dart';
import '../../../../core/utils/utils.dart';

/// Widget: TotalView
///
/// Displays overall financial overview with budget status, comparisons, and account totals.
class TotalView extends ConsumerWidget {
  const TotalView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(transactionSummaryProvider);
    
    return summaryAsync.when(
      data: (summary) {
        return TotalViewContent(
          summary: summary,
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Text('Error loading total view: $error'),
      ),
    );
  }
}

/// Widget: TotalViewContent
///
/// Main content widget for the total view showing all financial metrics.
class TotalViewContent extends StatelessWidget {
  final TransactionSummary summary;

  const TotalViewContent({
    super.key,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Budget Status Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Budget Status',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    LinearProgressIndicator(
                      value: summary.totalExpenses / 1000, // Assuming budget of 1000 for demo
                      backgroundColor: theme.colorScheme.surfaceVariant,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        summary.totalExpenses / 1000 > 0.8
                            ? theme.colorScheme.error
                            : summary.totalExpenses / 1000 > 0.6
                                ? theme.colorScheme.secondary
                                : theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Used: ${CurrencyUtils.formatAmount(summary.totalExpenses)}',
                          style: theme.textTheme.bodyMedium,
                        ),
                        Text(
                          'Budget: ${CurrencyUtils.formatAmount(1000)}', // Placeholder
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Comparison Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Compared to Last Month',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ComparisonItem(
                          label: 'Income',
                          currentValue: summary.totalIncome,
                          previousValue: summary.totalIncome * 0.95, // Placeholder
                          theme: theme,
                        ),
                        ComparisonItem(
                          label: 'Expenses',
                          currentValue: summary.totalExpenses,
                          previousValue: summary.totalExpenses * 1.1, // Placeholder
                          theme: theme,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Account Totals
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Account Totals',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    AccountTotalItem(
                      label: 'Total Income',
                      amount: summary.totalIncome,
                      color: theme.colorScheme.primary,
                    ),
                    AccountTotalItem(
                      label: 'Total Expenses',
                      amount: summary.totalExpenses,
                      color: theme.colorScheme.error,
                    ),
                    AccountTotalItem(
                      label: 'Net Balance',
                      amount: summary.netBalance,
                      color: summary.netBalance >= 0 ? theme.colorScheme.primary : theme.colorScheme.error,
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Export Option
            FilledButton.icon(
              onPressed: () {
                // Handle export
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Export feature coming soon')),
                );
              },
              icon: const Icon(Icons.download),
              label: const Text('Export Data'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget: ComparisonItem
///
/// Shows comparison between current and previous values with percentage change.
class ComparisonItem extends StatelessWidget {
  final String label;
  final double currentValue;
  final double previousValue;
  final ThemeData theme;

  const ComparisonItem({
    super.key,
    required this.label,
    required this.currentValue,
    required this.previousValue,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final changePercent = previousValue != 0 
        ? ((currentValue - previousValue) / previousValue * 100).abs() 
        : 0;
    final isPositiveChange = currentValue >= previousValue;
    
    return Column(
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          CurrencyUtils.formatAmount(currentValue),
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isPositiveChange ? Icons.arrow_upward : Icons.arrow_downward,
              size: 14,
              color: isPositiveChange ? theme.colorScheme.primary : theme.colorScheme.error,
            ),
            Text(
              '${isPositiveChange ? "+" : "-"}${changePercent.toStringAsFixed(1)}%',
              style: TextStyle(
                color: isPositiveChange ? theme.colorScheme.primary : theme.colorScheme.error,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Widget: AccountTotalItem
///
/// Displays a single account total item with label and formatted amount.
class AccountTotalItem extends StatelessWidget {
  final String label;
  final double amount;
  final Color color;

  const AccountTotalItem({
    super.key,
    required this.label,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            CurrencyUtils.formatAmount(amount),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}