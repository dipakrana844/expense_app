import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../shared/utils/transaction_utils.dart';
import '../../presentation/providers/transaction_providers.dart';
import '../../../expenses/presentation/providers/expense_providers.dart';
import '../../../income/presentation/providers/income_providers.dart';

/// Widget: TransactionCard
///
/// Displays a single transaction with appropriate styling based on type.
/// Shows income/expense differentiation with color coding and icons.
class TransactionCard extends ConsumerWidget {
  final TransactionEntity transaction;
  final VoidCallback? onTap;

  const TransactionCard({
    super.key,
    required this.transaction,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Category/Source Icon
              _buildCategoryIcon(theme),
              
              const SizedBox(width: 16),
              
              // Transaction Details
              Expanded(
                child: _buildTransactionDetails(theme),
              ),
              
              // Amount and Actions
              _buildAmountAndActions(context, theme, ref),
            ],
          ),
        ),
      ),
    );
  }

  /// Build category/source icon with appropriate styling
  Widget _buildCategoryIcon(ThemeData theme) {
    final isIncome = transaction.isIncome;
    final color = isIncome 
        ? theme.colorScheme.primary 
        : theme.colorScheme.error;
    
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Icon(
        TransactionUtils.getCategoryIcon(transaction.categoryOrSource),
        color: color,
        size: 24,
      ),
    );
  }

  /// Build transaction details section
  Widget _buildTransactionDetails(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category/Source name
        Text(
          transaction.categoryOrSource,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        
        const SizedBox(height: 4),
        
        // Note (if available)
        if (transaction.note != null && transaction.note!.isNotEmpty)
          Text(
            transaction.note!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        
        // Date
        Text(
          TransactionUtils.formatTransactionDate(transaction.date),
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  /// Build amount display with actions
  Widget _buildAmountAndActions(
      BuildContext context, ThemeData theme, WidgetRef ref) {
    final isIncome = transaction.isIncome;
    final color = isIncome 
        ? theme.colorScheme.primary 
        : theme.colorScheme.error;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Amount with color coding
        Text(
          TransactionUtils.formatTransactionAmount(transaction),
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        
        const SizedBox(height: 8),
        
        // Action buttons
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Edit button
            IconButton(
              icon: Icon(
                Icons.edit,
                size: 20,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              onPressed: () => _handleEdit(context, ref),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              visualDensity: VisualDensity.compact,
            ),
            
            const SizedBox(width: 8),
            
            // Delete button
            IconButton(
              icon: Icon(
                Icons.delete,
                size: 20,
                color: theme.colorScheme.error,
              ),
              onPressed: () => _handleDelete(context, ref),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),
      ],
    );
  }

  /// Handle edit action
  void _handleEdit(BuildContext context, WidgetRef ref) {
    if (transaction.isIncome) {
      // Navigate to edit income screen
      context.pushNamed(
        'edit-income',
        pathParameters: {'id': transaction.id},
        extra: {
          'income': {
            'id': transaction.id,
            'amount': transaction.amount,
            'source': transaction.categoryOrSource,
            'date': transaction.date.millisecondsSinceEpoch,
            'note': transaction.note,
          },
        },
      );
    } else {
      // Navigate to edit expense screen
      if (transaction.categoryOrSource == 'Grocery') {
        context.pushNamed('add-grocery', extra: transaction.id);
      } else {
        context.pushNamed(
          'edit-expense',
          pathParameters: {'id': transaction.id},
          extra: {
            'amount': transaction.amount,
            'category': transaction.categoryOrSource,
            'date': transaction.date.millisecondsSinceEpoch,
            'note': transaction.note,
          },
        );
      }
    }
  }

  /// Handle delete action
  Future<void> _handleDelete(BuildContext context, WidgetRef ref) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Delete ${transaction.isIncome ? 'Income' : 'Expense'}?',
        ),
        content: Text(
          'Are you sure you want to delete this '
          '${transaction.isIncome ? 'income' : 'expense'} entry?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              'Delete',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        if (transaction.isIncome) {
          // Delete income
          final incomeRepository = ref.read(incomeRepositoryProvider);
          await incomeRepository.deleteIncome(transaction.id);
        } else {
          // Delete expense
          final expenseRepository = ref.read(expenseRepositoryProvider);
          await expenseRepository.deleteExpense(transaction.id);
        }

        // Show success message
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${transaction.isIncome ? 'Income' : 'Expense'} deleted successfully',
              ),
            ),
          );
        }

        // Refresh the data
        ref.read(transactionActionsProvider.notifier).refresh();
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to delete: ${e.toString()}'),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      }
    }
  }
}