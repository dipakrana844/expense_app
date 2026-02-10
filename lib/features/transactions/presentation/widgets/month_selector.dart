import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../providers/transaction_providers.dart';

/// Widget: MonthSelector
///
/// Provides month navigation controls for the transactions view.
/// Allows moving between months and jumping to today.
class MonthSelector extends ConsumerWidget {
  const MonthSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMonth = ref.watch(currentMonthProvider);
    final theme = Theme.of(context);
    final monthFormat = DateFormat('MMMM yyyy');

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.outline.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Previous Month Button
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () => ref
                .read(transactionActionsProvider.notifier)
                .goToPreviousMonth(),
            tooltip: 'Previous month',
          ),
          
          const SizedBox(width: 8),
          
          // Current Month Display
          Expanded(
            child: Center(
              child: Text(
                monthFormat.format(currentMonth),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
          ),
          
          const SizedBox(width: 8),
          
          // Next Month Button
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () => ref
                .read(transactionActionsProvider.notifier)
                .goToNextMonth(),
            tooltip: 'Next month',
          ),
          
          const SizedBox(width: 8),
          
          // Today Button
          TextButton.icon(
            onPressed: () => ref.read(transactionActionsProvider.notifier).goToToday(),
            icon: const Icon(Icons.today, size: 18),
            label: const Text('Today'),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}