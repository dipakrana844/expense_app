import 'package:flutter/material.dart' hide DateUtils;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/utils.dart';
import '../../../income/presentation/providers/income_providers.dart';
import '../../../expenses/presentation/providers/expense_providers.dart';
import '../../../quick_expense/presentation/widgets/quick_expense_sheet.dart';
import '../../../grocery/presentation/providers/grocery_notifier.dart';
import '../../../income/presentation/widgets/balance_summary_card.dart';
import '../providers/transaction_providers.dart';
import '../widgets/transaction_card.dart';
import '../widgets/summary_strip.dart';
import '../widgets/transaction_filter_bar.dart';
import '../widgets/month_selector.dart';

/// Screen: TransactionsScreen
///
/// Main screen for viewing and managing all financial transactions.
/// Combines income and expense records in a unified, chronological view.
///
/// Features:
/// - Month navigation controls
/// - Filter bar (All/Income/Expenses)
/// - Sticky financial summary
/// - Grouped transaction list by date
/// - Quick action floating button
class TransactionsScreen extends ConsumerStatefulWidget {
  const TransactionsScreen({super.key});

  @override
  ConsumerState<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends ConsumerState<TransactionsScreen> {
  bool _isSearching = false;
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final groupedTransactionsAsync = ref.watch(groupedTransactionsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            pinned: true,
            floating: true,
            snap: false,
            title: _isSearching
                ? TextField(
                    controller: _searchController,
                    autofocus: true,
                    style: theme.textTheme.bodyLarge,
                    decoration: const InputDecoration(
                      hintText: 'Search transactions...',
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.white70),
                    ),
                    onChanged: (val) => ref
                        .read(transactionFilterProvider.notifier)
                        .setSearchTerm(val),
                  )
                : const Text('Transactions'),
            actions: [
              // Search Toggle
              IconButton(
                icon: Icon(_isSearching ? Icons.close : Icons.search),
                onPressed: () {
                  setState(() {
                    _isSearching = !_isSearching;
                    if (!_isSearching) {
                      _searchController.clear();
                      ref
                          .read(transactionFilterProvider.notifier)
                          .setSearchTerm('');
                    }
                  });
                },
              ),
              
              // Calendar View (Future enhancement)
              IconButton(
                icon: const Icon(Icons.calendar_month_outlined),
                onPressed: () {
                  // TODO: Implement calendar view
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Calendar view coming soon'),
                    ),
                  );
                },
              ),
            ],
          ),
          
          // Month Selector
          const SliverToBoxAdapter(
            child: MonthSelector(),
          ),
          
          // Filter Bar
          const SliverToBoxAdapter(
            child: TransactionFilterBar(),
          ),
          
          // Balance Summary Card
          const SliverToBoxAdapter(
            child: BalanceSummaryCard(showDetailedMetrics: true),
          ),
          
          // Summary Strip (Sticky)
          const SliverToBoxAdapter(
            child: SummaryStrip(isSticky: true),
          ),
          
          // Transaction List
          groupedTransactionsAsync.when(
            data: (groupedTransactions) {
              if (groupedTransactions.isEmpty) {
                return const SliverFillRemaining(
                  hasScrollBody: false,
                  child: _EmptyTransactionsView(),
                );
              }
              
              return SliverPadding(
                padding: const EdgeInsets.only(bottom: 80),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final dateKey = groupedTransactions.keys.elementAt(index);
                      final transactions = groupedTransactions[dateKey]!;
                      
                      return _buildDateGroup(context, dateKey, transactions);
                    },
                    childCount: groupedTransactions.length,
                  ),
                ),
              );
            },
            loading: () => const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, stack) => SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
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
            ),
          ),
        ],
      ),
      
      // Floating Action Button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddOptions(context),
        tooltip: 'Add Transaction',
        icon: const Icon(Icons.add),
        label: const Text('Add'),
      ),
    );
  }

  Widget _buildDateGroup(
      BuildContext context, String dateKey, List<dynamic> transactions) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Date Header
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
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

  void _showTransactionDetails(BuildContext context, dynamic transaction) {
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
                      // Handle edit
                      _handleEditTransaction(context, transaction);
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      // Handle delete
                      _handleDeleteTransaction(context, transaction);
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

  void _showAddOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Quick Expense - Primary option for daily use
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.flash_on,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              title: const Text(
                'Quick Expense',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('Add expense in seconds'),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'FAST',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                QuickExpenseSheet.show(context);
              },
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.payments, color: Colors.green),
              title: const Text('Add Income'),
              subtitle: const Text('Record money received'),
              onTap: () {
                context.pop();
                context.push('/income/add');
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Grocery Session'),
              subtitle: const Text('Record multiple items as one entry'),
              onTap: () {
                context.pop();
                ref.read(groceryNotifierProvider.notifier).resetSession();
                context.pushNamed('add-grocery');
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _handleEditTransaction(BuildContext context, dynamic transaction) {
    if (transaction.isIncome) {
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

  Future<void> _handleDeleteTransaction(
      BuildContext context, dynamic transaction) async {
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
          final incomeRepository = ref.read(incomeRepositoryProvider);
          await incomeRepository.deleteIncome(transaction.id);
        } else {
          final expenseRepository = ref.read(expenseRepositoryProvider);
          await expenseRepository.deleteExpense(transaction.id);
        }

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${transaction.isIncome ? 'Income' : 'Expense'} deleted successfully',
              ),
            ),
          );
        }

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