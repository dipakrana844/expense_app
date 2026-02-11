import 'package:flutter/material.dart' hide DateUtils;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/transaction_entity.dart';
import '../providers/transaction_providers.dart';
import '../../../../core/utils/utils.dart';

/// Widget: MonthlyView
///
/// Displays yearly summary grouped by month with expandable weekly breakdowns.
class MonthlyView extends ConsumerWidget {
  const MonthlyView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allTransactionsAsync = ref.watch(allTransactionsProvider);
    
    return allTransactionsAsync.when(
      data: (allTransactions) {
        return MonthlyListView(
          transactions: allTransactions,
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Text('Error loading monthly view: $error'),
      ),
    );
  }
}

/// Widget: MonthlyListView
///
/// Main list view showing months with expandable weekly breakdowns.
class MonthlyListView extends StatelessWidget {
  final List<TransactionEntity> transactions;

  const MonthlyListView({
    super.key,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Group transactions by month
    final transactionsByMonth = <String, List<TransactionEntity>>{};
    for (final transaction in transactions) {
      final monthKey = transaction.monthKey;
      if (!transactionsByMonth.containsKey(monthKey)) {
        transactionsByMonth[monthKey] = [];
      }
      transactionsByMonth[monthKey]!.add(transaction);
    }

    // Sort months in descending order
    final sortedMonths = transactionsByMonth.keys.toList()
      ..sort((a, b) => DateTime.parse('$b-01').compareTo(DateTime.parse('$a-01')));

    return ListView.builder(
      itemCount: sortedMonths.length,
      itemBuilder: (context, index) {
        final monthKey = sortedMonths[index];
        final monthTransactions = transactionsByMonth[monthKey]!;
        
        // Calculate totals for this month
        double monthIncome = 0;
        double monthExpense = 0;
        for (final transaction in monthTransactions) {
          if (transaction.isIncome) {
            monthIncome += transaction.amount;
          } else {
            monthExpense += transaction.amount;
          }
        }
        final net = monthIncome - monthExpense;

        return ExpansionTile(
          title: Row(
            children: [
              Expanded(
                child: Text(
                  _formatMonthYear(monthKey),
                  style: theme.textTheme.titleMedium,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '+${CurrencyUtils.formatAmountWithoutSymbol(monthIncome)}',
                    style: TextStyle(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '-${CurrencyUtils.formatAmountWithoutSymbol(monthExpense)}',
                    style: TextStyle(
                      color: theme.colorScheme.error,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          subtitle: Text(
            'Net: ${net >= 0 ? '+' : ''}${CurrencyUtils.formatAmountWithoutSymbol(net)}',
            style: TextStyle(
              color: net >= 0 ? theme.colorScheme.primary : theme.colorScheme.error,
            ),
          ),
          children: [
            // Weekly breakdown
            WeeklyBreakdown(
              transactions: monthTransactions,
              monthKey: monthKey,
            ),
          ],
        );
      },
    );
  }

  String _formatMonthYear(String monthKey) {
    final parts = monthKey.split('-');
    final year = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final monthNames = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${monthNames[month - 1]} $year';
  }
}

/// Widget: WeeklyBreakdown
///
/// Shows weekly breakdown within a month with income/expense totals.
class WeeklyBreakdown extends StatelessWidget {
  final List<TransactionEntity> transactions;
  final String monthKey;

  const WeeklyBreakdown({
    super.key,
    required this.transactions,
    required this.monthKey,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Group by week
    final transactionsByWeek = <int, List<TransactionEntity>>{};
    for (final transaction in transactions) {
      // Calculate week number for the transaction date
      final weekNumber = _getWeekNumber(transaction.date);
      if (!transactionsByWeek.containsKey(weekNumber)) {
        transactionsByWeek[weekNumber] = [];
      }
      transactionsByWeek[weekNumber]!.add(transaction);
    }

    final sortedWeeks = transactionsByWeek.keys.toList()..sort();

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sortedWeeks.length,
      itemBuilder: (context, index) {
        final weekNumber = sortedWeeks[index];
        final weekTransactions = transactionsByWeek[weekNumber]!;
        
        // Calculate totals for this week
        double weekIncome = 0;
        double weekExpense = 0;
        for (final transaction in weekTransactions) {
          if (transaction.isIncome) {
            weekIncome += transaction.amount;
          } else {
            weekExpense += transaction.amount;
          }
        }
        final net = weekIncome - weekExpense;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.cardColor.withOpacity(0.6),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Week $weekNumber',
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '+${CurrencyUtils.formatAmountWithoutSymbol(weekIncome)}',
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '-${CurrencyUtils.formatAmountWithoutSymbol(weekExpense)}',
                      style: TextStyle(
                        color: theme.colorScheme.error,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Net: ${net >= 0 ? '+' : ''}${CurrencyUtils.formatAmountWithoutSymbol(net)}',
                      style: TextStyle(
                        color: net >= 0 ? theme.colorScheme.primary : theme.colorScheme.error,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  int _getWeekNumber(DateTime date) {
    // Calculate the week number of the year
    final yearStart = DateTime(date.year, 1, 1);
    final days = date.difference(yearStart).inDays;
    return (days / 7).floor() + 1;
  }
}