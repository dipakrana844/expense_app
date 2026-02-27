import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../expenses/presentation/providers/expense_providers.dart';
import '../../../income/presentation/providers/income_providers.dart';
import '../../domain/entities/transaction_entity.dart';
import '../providers/transaction_providers.dart';

class TransactionActions {
  const TransactionActions._();

  static Future<void> handleEdit(
    BuildContext context,
    TransactionEntity transaction,
  ) async {
    final isGroceryExpense =
        transaction.isExpense && transaction.categoryOrSource == 'Grocery';
    if (isGroceryExpense) {
      context.pushNamed('add-grocery', extra: transaction.id);
      return;
    }

    context.pushNamed(
      'smart-entry-edit',
      extra: <String, dynamic>{
        'transactionId': transaction.id,
        'mode': transaction.isIncome ? 'income' : 'expense',
        'amount': transaction.amount,
        'category': transaction.isExpense ? transaction.categoryOrSource : null,
        'source': transaction.isIncome ? transaction.categoryOrSource : null,
        'note': transaction.note,
        'date': transaction.date.millisecondsSinceEpoch,
      },
    );
  }

  static Future<void> handleDelete(
    BuildContext context,
    WidgetRef ref,
    TransactionEntity transaction,
  ) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete ${transaction.isIncome ? 'Income' : 'Expense'}?'),
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

    if (confirm != true) return;

    try {
      if (transaction.isIncome) {
        final incomeRepository = ref.read(incomeRepositoryProvider);
        await incomeRepository.deleteIncome(transaction.id);
      } else {
        final expenseRepository = ref.read(expenseRepositoryProvider);
        await expenseRepository.deleteExpense(transaction.id);
      }

      if (!context.mounted) return;
      _showSnackBar(
        context,
        '${transaction.isIncome ? 'Income' : 'Expense'} deleted successfully',
      );
      ref.read(transactionActionsProvider.notifier).refresh();
    } catch (e) {
      if (!context.mounted) return;
      _showSnackBar(context, 'Failed to delete: $e', isError: true);
    }
  }

  static void _showSnackBar(
    BuildContext context,
    String message, {
    bool isError = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Theme.of(context).colorScheme.error : null,
      ),
    );
  }
}
