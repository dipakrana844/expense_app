import 'package:flutter/material.dart' hide DateUtils;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_expense_tracker/core/utils/utils.dart';
import 'package:smart_expense_tracker/features/expenses/presentation/providers/expense_providers.dart';
import 'package:smart_expense_tracker/features/expenses/presentation/widgets/expense_widgets.dart';
import 'package:smart_expense_tracker/features/quick_expense/presentation/widgets/quick_expense_sheet.dart';
import 'package:smart_expense_tracker/features/grocery/presentation/providers/grocery_notifier.dart';
import 'package:smart_expense_tracker/features/spending_intelligence/presentation/widgets/smart_insights_section.dart';
import 'package:smart_expense_tracker/features/daily_spend_guard/presentation/widgets/daily_spend_card.dart';
import 'package:smart_expense_tracker/features/income/presentation/widgets/balance_summary_card.dart';

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
      body: CustomScrollView(
        slivers: [
          // Daily Spend Guard Card - Always visible at top
          const SliverToBoxAdapter(
            child: DailySpendCard(showFullDetails: true),
          ),
          // Balance Summary Card - Shows income/expense balance
          const SliverToBoxAdapter(
            child: BalanceSummaryCard(showDetailedMetrics: true),
          ),
          const SliverToBoxAdapter(child: SmartInsightsSection()),
          if (groupedExpenses.isEmpty)
            const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(child: Text('No matching expenses found')),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 80),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
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
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
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
                          onEdit: () {
                            if (e.category == 'Grocery') {
                              context.pushNamed('add-grocery', extra: e.id);
                            } else {
                              context.pushNamed(
                                'edit-expense',
                                pathParameters: {'id': e.id},
                                extra: {
                                  'amount': e.amount,
                                  'category': e.category,
                                  'date': e.date.millisecondsSinceEpoch,
                                  'note': e.note,
                                  'metadata': e.metadata,
                                },
                              );
                            }
                          },
                          onDelete: () async {
                            if (e.category == 'Grocery') {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Delete Grocery Expense?'),
                                  content: const Text(
                                    'This will remove all items from this grocery entry.',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, false),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, true),
                                      child: const Text(
                                        'Delete',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                              );

                              if (confirm == true) {
                                await ref
                                    .read(expensesProvider.notifier)
                                    .deleteExpense(e.id);
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Grocery expense deleted'),
                                    ),
                                  );
                                }
                              }
                            } else {
                              ref
                                  .read(expensesProvider.notifier)
                                  .deleteExpense(e.id);
                            }
                          },
                        ),
                      ),
                    ],
                  );
                }, childCount: groupedExpenses.length),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddOptions(context),
        tooltip: 'Add Expense',
        icon: const Icon(Icons.add),
        label: const Text('Add'),
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
            // Quick Expense button removed - use Smart Entry for streamlined transactions
            // Quick Expense feature and backend logic preserved for backward compatibility
            // Add Income button removed - use Smart Entry for all transactions
            // Income feature and backend logic preserved for backward compatibility
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
}
