import 'package:flutter/material.dart' hide DateUtils;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/transaction_entity.dart';
import '../providers/transaction_providers.dart';
import '../../../../core/utils/utils.dart';

/// Widget: CalendarView
///
/// Displays a month grid view showing income and expense amounts per day.
/// Allows tapping on days to navigate to daily view for that date.
class CalendarView extends ConsumerWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMonth = ref.watch(currentMonthProvider);
    final allTransactionsAsync = ref.watch(allTransactionsProvider);
    
    return allTransactionsAsync.when(
      data: (allTransactions) {
        return CalendarGridView(
          month: currentMonth,
          transactions: allTransactions,
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Text('Error loading calendar view: $error'),
      ),
    );
  }
}

/// Widget: CalendarGridView
///
/// Renders the calendar grid with day cells showing income/expense data.
class CalendarGridView extends StatelessWidget {
  final DateTime month;
  final List<TransactionEntity> transactions;

  const CalendarGridView({
    super.key,
    required this.month,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Get first day of the month
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    // Get last day of the month
    final lastDayOfMonth = DateTime(month.year, month.month + 1, 0);
    // Get day of week for first day (0 = Sunday, 1 = Monday, etc.)
    final firstDayWeekday = firstDayOfMonth.weekday % 7; // Adjust for Sunday = 0
    
    // Group transactions by day
    final transactionsByDay = <int, List<TransactionEntity>>{};
    for (final transaction in transactions) {
      if (transaction.date.year == month.year && transaction.date.month == month.month) {
        final day = transaction.date.day;
        if (!transactionsByDay.containsKey(day)) {
          transactionsByDay[day] = [];
        }
        transactionsByDay[day]!.add(transaction);
      }
    }

    // Calculate total days to show (6 weeks = 42 days)
    final totalDays = ((lastDayOfMonth.day + firstDayWeekday) ~/ 7 + 1) * 7;
    
    return SingleChildScrollView(
      child: Column(
        children: [
          // Day headers
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
                  .map((day) => Expanded(
                        child: Center(
                          child: Text(
                            day,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
          // Calendar grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1.0,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
            ),
            itemCount: totalDays,
            itemBuilder: (context, index) {
              final day = index - firstDayWeekday + 1;
              final isCurrentMonth = day >= 1 && day <= lastDayOfMonth.day;
              final dayTransactions = isCurrentMonth ? (transactionsByDay[day] ?? []) : [];

              // Calculate income and expenses for this day
              double dayIncome = 0;
              double dayExpense = 0;
              for (final transaction in dayTransactions) {
                if (transaction.isIncome) {
                  dayIncome += transaction.amount;
                } else {
                  dayExpense += transaction.amount;
                }
              }

              return CalendarDayCell(
                day: day,
                isCurrentMonth: isCurrentMonth,
                dayIncome: dayIncome,
                dayExpense: dayExpense,
                month: month,
                theme: theme,
                index: index,
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Widget: CalendarDayCell
///
/// Individual cell in the calendar grid showing day number and financial data.
class CalendarDayCell extends ConsumerWidget {
  final int day;
  final bool isCurrentMonth;
  final double dayIncome;
  final double dayExpense;
  final DateTime month;
  final ThemeData theme;
  final int index;

  const CalendarDayCell({
    super.key,
    required this.day,
    required this.isCurrentMonth,
    required this.dayIncome,
    required this.dayExpense,
    required this.month,
    required this.theme,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        if (isCurrentMonth) {
          // Handle day tap - navigate to daily view for this date
          final selectedDate = DateTime(month.year, month.month, day);
          // Update current month provider to this date
          ref.read(currentMonthProvider.notifier).state = selectedDate;
          // Refresh data for new month
          ref.read(transactionActionsProvider.notifier).refresh();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: !isCurrentMonth
              ? theme.cardColor.withOpacity(0.3)
              : index % 7 == 0 || index % 7 == 6
                  ? theme.cardColor.withOpacity(0.6) // Weekend highlight
                  : theme.cardColor,
          border: Border.all(
            color: theme.dividerColor.withOpacity(0.3),
            width: 0.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isCurrentMonth ? day.toString() : '',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: !isCurrentMonth
                    ? theme.colorScheme.onSurface.withOpacity(0.4)
                    : day == DateTime.now().day &&
                            month.month == DateTime.now().month &&
                            month.year == DateTime.now().year
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onSurface,
              ),
            ),
            if (isCurrentMonth && dayIncome > 0)
              Text(
                '+${CurrencyUtils.formatAmountWithoutSymbol(dayIncome)}',
                style: TextStyle(
                  fontSize: 10,
                  color: theme.colorScheme.primary,
                ),
              ),
            if (isCurrentMonth && dayExpense > 0)
              Text(
                '-${CurrencyUtils.formatAmountWithoutSymbol(dayExpense)}',
                style: TextStyle(
                  fontSize: 10,
                  color: theme.colorScheme.error,
                ),
              ),
          ],
        ),
      ),
    );
  }
}