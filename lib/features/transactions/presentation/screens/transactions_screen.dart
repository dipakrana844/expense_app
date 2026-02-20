import 'package:flutter/material.dart' hide DateUtils;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../grocery/presentation/providers/grocery_notifier.dart';
import '../providers/transaction_providers.dart';
import '../widgets/daily_view.dart';
import '../widgets/calendar_view.dart';
import '../widgets/monthly_view.dart';
import '../widgets/total_view.dart';
import '../widgets/notes_view.dart';
import '../widgets/modern_summary_header.dart';
import '../widgets/segmented_view_selector.dart';
import '../../domain/enums/transaction_type.dart';

/// Screen: TransactionsScreen
///
/// Main screen for viewing and managing all financial transactions.
/// Redesigned with a modern, clean architecture and improved UX.
///
/// Features:
/// - NestedScrollView for collapsible header effect
/// - Modern segmented view selector
/// - Clean summary card
/// - Smart Entry as primary action
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
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
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
                floating: true,
                pinned: true,
                expandedHeight: 280,
                flexibleSpace: const FlexibleSpaceBar(
                  background: ModernSummaryHeader(),
                  collapseMode: CollapseMode.pin,
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(48),
                  child: SegmentedViewSelector(
                    controller: _tabController,
                    tabs: const ['Daily', 'Calendar', 'Monthly', 'Total', 'Notes'],
                  ),
                ),
                actions: [
                  IconButton(
                    icon: Icon(_isSearching ? Icons.close : Icons.search),
                    onPressed: () {
                      setState(() {
                        _isSearching = !_isSearching;
                        if (!_isSearching) {
                          _searchController.clear();
                          ref.read(transactionFilterProvider.notifier).setSearchTerm('');
                        }
                      });
                    },
                  ),
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.filter_list),
                    itemBuilder: (context) => [
                      const PopupMenuItem(value: 'all', child: Text('All Transactions')),
                      const PopupMenuItem(value: 'income', child: Text('Income Only')),
                      const PopupMenuItem(value: 'expense', child: Text('Expenses Only')),
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
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            // Daily View (Needs to support NestedScrollView)
            DailyView(groupedTransactionsAsync: groupedTransactionsAsync),
            const CalendarView(),
            const MonthlyView(),
            const TotalView(),
            NotesView(groupedTransactionsAsync: groupedTransactionsAsync),
          ],
        ),
      ),

      // Floating Action Button - Direct Access to Smart Entry
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/smart-entry'),
        tooltip: 'Smart Entry',
        icon: const Icon(Icons.smart_toy_outlined),
        label: const Text('Smart Entry'),
        elevation: 2,
      ),
    );
  }
}
