import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_expense_tracker/core/constants/app_constants.dart';
import 'package:smart_expense_tracker/core/constants/budget_constants.dart';
import 'package:smart_expense_tracker/core/utils/utils.dart';
import 'package:smart_expense_tracker/features/expenses/presentation/providers/expense_providers.dart';
import '../providers/budget_providers.dart';

class BudgetScreen extends ConsumerWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analytics = ref.watch(monthlyAnalyticsProvider);
    final totalSpent = analytics.total;

    return ref
        .watch(budgetControllerProvider)
        .when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 48),
                const SizedBox(height: 16),
                Text(
                  'Failed to load budget',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  error.toString(),
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () => ref.invalidate(budgetControllerProvider),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
          data: (budgetEntity) {
            final monthlyBudget = budgetEntity?.amount ?? 0.0;
            final progress = budgetEntity?.getProgress(totalSpent) ?? 0.0;
            final isOverBudget =
                budgetEntity?.isOverBudget(totalSpent) ?? false;
            final isNearBudget =
                budgetEntity?.isNearBudget(totalSpent) ?? false;

            return Scaffold(
              appBar: AppBar(title: const Text('Budget Tracking')),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Theme.of(context)
                          .colorScheme
                          .surfaceContainerHighest
                          .withValues(alpha: 0.3),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            Text(
                              'Monthly Budget Goal',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              CurrencyUtils.formatAmount(monthlyBudget),
                              style: Theme.of(context).textTheme.displaySmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                            ),
                            const SizedBox(height: 20),
                            FilledButton.icon(
                              onPressed: () => _showEditBudgetDialog(
                                context,
                                ref,
                                monthlyBudget,
                              ),
                              icon: const Icon(Icons.edit_note),
                              label: const Text('Adjust Budget'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    if (monthlyBudget > 0) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Current Spending',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                Text(
                                  '${(progress * 100).toStringAsFixed(1)}%',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isOverBudget
                                        ? Colors.red
                                        : (isNearBudget
                                              ? Colors.orange
                                              : Colors.green),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            LinearProgressIndicator(
                              value: progress.clamp(0.0, 1.0),
                              minHeight: 12,
                              borderRadius: BorderRadius.circular(6),
                              color: isOverBudget
                                  ? Colors.red
                                  : (isNearBudget
                                        ? Colors.orange
                                        : Colors.green),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(CurrencyUtils.formatAmount(totalSpent)),
                                Text(
                                  'Remaining: ${CurrencyUtils.formatAmount(budgetEntity?.getRemaining(totalSpent) ?? 0.0)}',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      if (isOverBudget)
                        _buildAlert(
                          context,
                          'Budget Exceeded! Consider reviewing your expenses.',
                          Colors.red,
                        ),
                      if (!isOverBudget && isNearBudget)
                        _buildAlert(
                          context,
                          'Approaching Limit: You have consumed over 80% of your budget.',
                          Colors.orange,
                        ),
                    ] else
                      Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Text(
                          'Start your financial journey by setting a monthly spending limit.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withValues(alpha: 0.6),
                              ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        );
  }

  Widget _buildAlert(BuildContext context, String message, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.report_problem_outlined, color: color),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: color, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditBudgetDialog(
    BuildContext context,
    WidgetRef ref,
    double currentBudget,
  ) {
    final controller = TextEditingController(text: currentBudget.toString());
    final validationError = ValueNotifier<String?>(null);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Monthly Budget'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ValueListenableBuilder<String?>(
              valueListenable: validationError,
              builder: (context, error, _) => TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                autofocus: true,
                decoration: InputDecoration(
                  prefixText: '${AppConstants.currencySymbol} ',
                  hintText: 'Enter amount',
                  errorText: error,
                ),
                onChanged: (value) {
                  final val = double.tryParse(value);
                  if (val == null) {
                    validationError.value = 'Please enter a valid number';
                  } else if (val < BudgetConstants.minBudgetAmount) {
                    validationError.value = 'Budget cannot be negative';
                  } else if (val > BudgetConstants.maxBudgetAmount) {
                    validationError.value = 'Budget exceeds maximum limit';
                  } else {
                    validationError.value = null;
                  }
                },
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Maximum: ${CurrencyUtils.formatAmount(BudgetConstants.maxBudgetAmount)}',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ValueListenableBuilder<String?>(
            valueListenable: validationError,
            builder: (context, error, _) => FilledButton(
              onPressed: error != null
                  ? null
                  : () {
                      final val = double.tryParse(controller.text);
                      if (val != null) {
                        ref
                            .read(budgetControllerProvider.notifier)
                            .updateBudget(val);
                        Navigator.pop(context);
                      }
                    },
              child: const Text('Save'),
            ),
          ),
        ],
      ),
    );
  }
}
