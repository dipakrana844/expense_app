import 'package:flutter/material.dart' hide DateUtils;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/transaction_entity.dart';
import '../providers/transaction_providers.dart';
import 'transaction_card.dart';
import '../../../../core/utils/utils.dart';

/// Widget: DailyView
///
/// Displays transactions grouped by date in chronological order.
/// Shows income and expense transactions together with per-day totals.
class DailyView extends ConsumerWidget {
  final AsyncValue<Map<String, List<TransactionEntity>>> groupedTransactionsAsync;

  const DailyView({
    super.key,
    required this.groupedTransactionsAsync,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    
    return groupedTransactionsAsync.when(
      data: (groupedTransactions) {
        if (groupedTransactions.isEmpty) {
          return const _EmptyTransactionsView();
        }
        
        return CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final dateKey = groupedTransactions.keys.elementAt(index);
                  final transactions = groupedTransactions[dateKey]!;
                  
                  return _buildDateGroup(context, dateKey, transactions, theme);
                },
                childCount: groupedTransactions.length,
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Failed to load transactions',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () => ref
                  .read(transactionActionsProvider.notifier)
                  .refresh(),
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateGroup(
      BuildContext context, String dateKey, List<TransactionEntity> transactions, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Date Header
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatDateHeader(dateKey),
                style: theme.textTheme.titleSmall?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                CurrencyUtils.formatAmount(
                  transactions.fold(
                    0.0,
                    (sum, transaction) => transaction.isIncome
                        ? sum + transaction.amount
                        : sum - transaction.amount,
                  ),
                ),
                style: theme.textTheme.titleSmall?.copyWith(
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        
        // Transactions for this date
        ...transactions.map(
          (transaction) => TransactionCard(
            transaction: transaction,
            onTap: () {
              // Show transaction details
              _showTransactionDetails(context, transaction);
            },
          ),
        ),
      ],
    );
  }

  String _formatDateHeader(String dateKey) {
    try {
      final parts = dateKey.split('-');
      final year = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final day = int.parse(parts[2]);
      
      final date = DateTime(year, month, day);
      return DateUtils.formatDate(date);
    } catch (e) {
      return dateKey; // Fallback to raw key
    }
  }

  void _showTransactionDetails(BuildContext context, TransactionEntity transaction) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    transaction.isIncome
                        ? Icons.trending_up
                        : Icons.trending_down,
                    color: transaction.isIncome
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.error,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    transaction.isIncome ? 'Income' : 'Expense',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _DetailRow(
                'Amount',
                CurrencyUtils.formatAmount(transaction.amount),
                transaction.isIncome
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.error,
              ),
              _DetailRow(
                'Category/Source',
                transaction.categoryOrSource,
                Theme.of(context).colorScheme.onSurface,
              ),
              _DetailRow(
                'Date',
                DateUtils.formatDate(transaction.date),
                Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              if (transaction.note != null && transaction.note!.isNotEmpty)
                _DetailRow(
                  'Note',
                  transaction.note!,
                  Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FilledButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      // Handle edit - this would need to be passed from parent
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      // Handle delete - this would need to be passed from parent
                    },
                    icon: const Icon(Icons.delete),
                    label: const Text('Delete'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyTransactionsView extends StatelessWidget {
  const _EmptyTransactionsView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 80,
              color: theme.colorScheme.primary.withOpacity(0.3),
            ),
            const SizedBox(height: 24),
            Text(
              'No transactions yet',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Tap the + button to add your first transaction',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.5),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;

  const _DetailRow(this.label, this.value, this.valueColor);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: valueColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}