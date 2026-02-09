import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_expense_tracker/features/income/domain/entities/income_entity.dart';
import 'package:smart_expense_tracker/features/income/presentation/providers/income_providers.dart';
import 'package:smart_expense_tracker/features/income/presentation/widgets/income_list_item.dart';

/// Screen: IncomeListScreen
///
/// Purpose: Displays a list of all income records
/// - Shows all income entries with amount, source, date
/// - Allows editing and deleting of income records
/// - Provides navigation to add new income
class IncomeListScreen extends ConsumerWidget {
  const IncomeListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final incomesAsync = ref.watch(incomesProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Income Records'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.pushNamed('add-income'),
            tooltip: 'Add Income',
          ),
        ],
      ),
      body: incomesAsync.when(
        data: (incomes) {
          if (incomes.isEmpty) {
            return _buildEmptyState(context, theme);
          }
          
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(incomesProvider);
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: incomes.length,
              itemBuilder: (context, index) {
                final income = incomes[index];
                return IncomeListItem(
                  income: income,
                  onTap: () {
                    // Navigate to edit screen
                    context.pushNamed('edit-income', pathParameters: {'id': income.id});
                  },
                  onEdit: () {
                    // Navigate to edit screen
                    context.pushNamed('edit-income', pathParameters: {'id': income.id});
                  },
                  onDelete: () {
                    _confirmDelete(context, ref, income);
                  },
                );
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => _buildErrorState(context, theme, error.toString()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed('add-income'),
        child: const Icon(Icons.add),
        tooltip: 'Add Income',
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.payments_outlined,
            size: 64,
            color: theme.colorScheme.secondary,
          ),
          const SizedBox(height: 16),
          const Text(
            'No income records yet',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          const Text(
            'Start by adding your first income',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () => context.pushNamed('add-income'),
            icon: const Icon(Icons.add),
            label: const Text('Add Income'),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, ThemeData theme, String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: theme.colorScheme.error,
          ),
          const SizedBox(height: 16),
          const Text(
            'Failed to load income records',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Text(
            error,
            style: TextStyle(
              fontSize: 14,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: () {
              // Retry loading
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, IncomeEntity income) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Income'),
          content: Text(
            'Are you sure you want to delete the income record for ${income.source} (${income.amount})? '
            'This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(context).pop();
                _performDelete(ref, income);
              },
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _performDelete(WidgetRef ref, IncomeEntity income) async {
    try {
      final deleteUseCase = ref.read(deleteIncomeUseCaseProvider);
      await deleteUseCase.execute(income.id);
      
      // Show success snackbar
      if (ScaffoldMessenger.maybeOf(ref.context) != null) {
        ScaffoldMessenger.of(ref.context).showSnackBar(
          const SnackBar(content: Text('Income deleted successfully')),
        );
      }
    } catch (e) {
      // Show error snackbar
      if (ScaffoldMessenger.maybeOf(ref.context) != null) {
        ScaffoldMessenger.of(ref.context).showSnackBar(
          SnackBar(content: Text('Error deleting income: $e')),
        );
      }
    }
  }
}