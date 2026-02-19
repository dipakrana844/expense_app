import 'package:flutter/material.dart' hide DateUtils;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../quick_expense/presentation/widgets/quick_expense_sheet.dart';
import '../../../grocery/presentation/providers/grocery_notifier.dart';
import '../providers/transaction_providers.dart';
import '../widgets/summary_strip.dart';
import '../widgets/daily_view.dart';
import '../widgets/calendar_view.dart';
import '../widgets/monthly_view.dart';
import '../widgets/total_view.dart';
import '../widgets/notes_view.dart';
import '../../domain/enums/transaction_type.dart';

/// Screen: TransactionsScreen
///
/// Main screen for viewing and managing all financial transactions.
/// Combines income and expense records in a unified, chronological view.
///
/// Features:
/// - Month navigation controls
/// - Filter bar (All/Income/Expenses)
/// - Sticky financial summary
/// - Tabbed interface with multiple views
/// - Quick action floating button
class TransactionsScreen extends ConsumerStatefulWidget {
  const TransactionsScreen({super.key});

  @override
  ConsumerState<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends ConsumerState<TransactionsScreen> with TickerProviderStateMixin {
  bool _isSearching = false;
  final _searchController = TextEditingController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final groupedTransactionsAsync = ref.watch(groupedTransactionsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
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
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.colorScheme.onSurface,
        actions: [
          // Search icon
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
          
          // Filter icon
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'all',
                child: Text('All Transactions'),
              ),
              const PopupMenuItem(
                value: 'income',
                child: Text('Income Only'),
              ),
              const PopupMenuItem(
                value: 'expense',
                child: Text('Expenses Only'),
              ),
            ],
            onSelected: (value) {
              switch(value) {
                case 'all':
                  ref.read(transactionFilterProvider.notifier).setType(null);
                  break;
                case 'income':
                  ref.read(transactionFilterProvider.notifier).setType(TransactionType.income);
                  break;
                case 'expense':
                  ref.read(transactionFilterProvider.notifier).setType(TransactionType.expense);
                  break;
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Month/Year header with navigation
          _buildMonthHeader(context),
          
          // Segmented tab switcher
          Container(
            height: 48,
            decoration: BoxDecoration(
              color: theme.cardColor,
              border: Border(
                bottom: BorderSide(color: theme.dividerColor, width: 0.5),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: theme.colorScheme.primary,
              unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
              indicatorColor: theme.colorScheme.primary,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: const [
                Tab(text: 'Daily'),
                Tab(text: 'Calendar'),
                Tab(text: 'Monthly'),
                Tab(text: 'Total'),
                Tab(text: 'Notes'),
              ],
            ),
          ),
          
          // Shared summary header
          const SummaryStrip(isSticky: true),
          
          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Daily View
                DailyView(groupedTransactionsAsync: groupedTransactionsAsync),
                
                // Calendar View
                const CalendarView(),
                
                // Monthly View
                const MonthlyView(),
                
                // Total View
                const TotalView(),
                
                // Notes View
                NotesView(groupedTransactionsAsync: groupedTransactionsAsync),
              ],
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

  Widget _buildMonthHeader(BuildContext context) {
    final currentMonth = ref.watch(currentMonthProvider);
    final monthYear = "${DateTime(currentMonth.year, currentMonth.month, 1).month.toString()}, ${currentMonth.year}";
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: theme.cardColor,
        border: Border(
          bottom: BorderSide(color: theme.dividerColor, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          // Previous month button
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () {
              ref.read(transactionActionsProvider.notifier).goToPreviousMonth();
            },
          ),
          
          // Month label
          Expanded(
            child: Center(
              child: Text(
                monthYear,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          
          // Next month button
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () {
              ref.read(transactionActionsProvider.notifier).goToNextMonth();
            },
          ),
          
          // Search icon in month header
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = true;
              });
            },
          ),
        ],
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
            // Smart Entry - Unified transaction entry
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.smart_toy,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              title: const Text(
                'Smart Entry',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('Add Income, Expense or Transfer'),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'NEW',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                context.push('/smart-entry');
              },
            ),
            const Divider(height: 1),
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