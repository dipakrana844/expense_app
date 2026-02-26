import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/utils.dart';
import '../providers/transaction_providers.dart';

class ModernSummaryHeader extends ConsumerWidget {
  const ModernSummaryHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(transactionSummaryProvider);
    final currentMonth = ref.watch(currentMonthProvider);
    final theme = Theme.of(context);
    // final monthYear =
    //     "${DateTime(currentMonth.year, currentMonth.month, 1).month.toString()}, ${currentMonth.year}"; // Simplified for now, should use proper formatting

    return Container(
      padding: const EdgeInsets.fromLTRB(16, kToolbarHeight + 16, 16, 16),
      decoration: BoxDecoration(color: theme.scaffoldBackgroundColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Month Selector & Net Balance Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Month Selector (Compact)
              Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest.withOpacity(
                    0.5,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left, size: 20),
                      onPressed: () => ref
                          .read(transactionActionsProvider.notifier)
                          .goToPreviousMonth(),
                      visualDensity: VisualDensity.compact,
                      padding: const EdgeInsets.all(8),
                      constraints: const BoxConstraints(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        // Format: Feb 2026
                        _formatMonth(currentMonth),
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right, size: 20),
                      onPressed: () => ref
                          .read(transactionActionsProvider.notifier)
                          .goToNextMonth(),
                      visualDensity: VisualDensity.compact,
                      padding: const EdgeInsets.all(8),
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Financial Summary Cards
          summaryAsync.when(
            data: (summary) {
              final netBalance = summary.netBalance;
              final isPositive = netBalance >= 0;

              return Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.primaryContainer.withOpacity(0.3),
                      theme.colorScheme.secondaryContainer.withOpacity(0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: theme.colorScheme.outlineVariant.withOpacity(0.5),
                  ),
                ),
                child: Row(
                  children: [
                    // Left Side: Net Balance
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Net Balance',
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 8),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              CurrencyUtils.formatAmount(netBalance),
                              style: theme.textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: isPositive
                                    ? theme.colorScheme.primary
                                    : theme.colorScheme.error,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Divider
                    Container(
                      height: 50,
                      width: 1,
                      color: theme.colorScheme.outlineVariant.withOpacity(0.5),
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                    ),

                    // Right Side: Income & Expenses
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          _buildInlineSummary(
                            context,
                            'Income',
                            summary.totalIncome,
                            Icons.arrow_downward,
                            theme.colorScheme.primary,
                          ),
                          const SizedBox(height: 12),
                          _buildInlineSummary(
                            context,
                            'Expense',
                            summary.totalExpenses,
                            Icons.arrow_upward,
                            theme.colorScheme.error,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildInlineSummary(
    BuildContext context,
    String label,
    double amount,
    IconData icon,
    Color color,
  ) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 14, color: color),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const Spacer(),
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerRight,
            child: Text(
              CurrencyUtils.formatAmount(amount),
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _formatMonth(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return "${months[date.month - 1]} ${date.year}";
  }
}
