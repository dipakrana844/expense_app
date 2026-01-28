import 'package:flutter/material.dart' hide DateUtils;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_expense_tracker/core/utils/utils.dart';
import 'package:smart_expense_tracker/features/expenses/presentation/providers/expense_providers.dart';
import 'package:smart_expense_tracker/features/expenses/presentation/widgets/expense_widgets.dart';

class ExpenseListScreen extends ConsumerStatefulWidget {
  const ExpenseListScreen({super.key});

  @override
  ConsumerState<ExpenseListScreen> createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends ConsumerState<ExpenseListScreen> {
  bool _isSearching = false;
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final groupedExpenses = ref.watch(expensesGroupedByDateProvider);

    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search by category or note...',
                  border: InputBorder.none,
                ),
                onChanged: (val) =>
                    ref.read(searchQueryProvider.notifier).state = val,
              )
            : const Text('All Expenses'),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                  ref.read(searchQueryProvider.notifier).state = '';
                }
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.calendar_month_outlined),
            onPressed: () async {
              final range = await showDateRangePicker(
                context: context,
                firstDate: DateTime(2020),
                lastDate: DateTime.now(),
              );
              if (range != null) {
                ref.read(dateFilterProvider.notifier).state = range;
              }
            },
          ),
          if (ref.watch(dateFilterProvider) != null)
            IconButton(
              icon: const Icon(Icons.filter_list_off),
              onPressed: () =>
                  ref.read(dateFilterProvider.notifier).state = null,
            ),
        ],
      ),
      body: groupedExpenses.isEmpty
          ? const Center(child: Text('No matching expenses found'))
          : ListView.builder(
              padding: const EdgeInsets.only(bottom: 80),
              itemCount: groupedExpenses.length,
              itemBuilder: (context, index) {
                final dateKey = groupedExpenses.keys.elementAt(index);
                final expenses = groupedExpenses[dateKey]!;
                final dateTotal = expenses.fold(
                  0.0,
                  (sum, e) => sum + e.amount,
                );

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            dateKey,
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                          ),
                          Text(
                            CurrencyUtils.formatAmount(dateTotal),
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                    ...expenses.map(
                      (e) => ExpenseCard(
                        id: e.id,
                        amount: e.amount,
                        category: e.category,
                        date: e.date,
                        note: e.note,
                        onEdit: () => context.goNamed(
                          'edit-expense',
                          pathParameters: {'id': e.id},
                          extra: {
                            'amount': e.amount,
                            'category': e.category,
                            'date': e.date,
                            'note': e.note,
                          },
                        ),
                        onDelete: () => ref
                            .read(expensesProvider.notifier)
                            .deleteExpense(e.id),
                      ),
                    ),
                  ],
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddOptions(context),
        tooltip: 'Add Entry',
        child: const Icon(Icons.add),
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
            ListTile(
              leading: const Icon(Icons.receipt_long),
              title: const Text('Single Expense'),
              subtitle: const Text('Add a standard one-time expense'),
              onTap: () {
                context.pop();
                context.goNamed('add-expense');
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Grocery Session'),
              subtitle: const Text('Record multiple items as one entry'),
              onTap: () {
                context.pop();
                context.goNamed('add-grocery');
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
