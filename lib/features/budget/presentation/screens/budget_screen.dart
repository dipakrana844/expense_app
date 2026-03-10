import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_expense_tracker/core/constants/app_constants.dart';
import 'package:smart_expense_tracker/core/utils/utils.dart';
import 'package:smart_expense_tracker/features/expenses/presentation/providers/expense_providers.dart';

class BudgetScreen extends ConsumerStatefulWidget {
  const BudgetScreen({super.key});

  @override
  ConsumerState<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends ConsumerState<BudgetScreen> {
  late Box _budgetBox;
  double _monthlyBudget = 0.0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBudget();
  }

  Future<void> _loadBudget() async {
    _budgetBox = await Hive.openBox(AppConstants.budgetBoxName);
    setState(() {
      _monthlyBudget = _budgetBox.get('monthly_limit', defaultValue: 0.0);
      _isLoading = false;
    });
  }

  Future<void> _saveBudget(double amount) async {
    await _budgetBox.put('monthly_limit', amount);
    setState(() {
      _monthlyBudget = amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Center(child: CircularProgressIndicator());

    final analytics = ref.watch(monthlyAnalyticsProvider);
    final totalSpent = analytics.total;
    final progress = _monthlyBudget > 0 ? (totalSpent / _monthlyBudget) : 0.0;
    final isOverBudget = progress > 1.0;
    final isNearBudget = progress > 0.8;

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
              color: Theme.of(
                context,
              ).colorScheme.surfaceContainerHighest.withOpacity(0.3),
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
                      CurrencyUtils.formatAmount(_monthlyBudget),
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 20),
                    FilledButton.icon(
                      onPressed: _showEditBudgetDialog,
                      icon: const Icon(Icons.edit_note),
                      label: const Text('Adjust Budget'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            if (_monthlyBudget > 0) ...[
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
                            color: isOverBudget ? Colors.red : Colors.green,
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
                          : (isNearBudget ? Colors.orange : Colors.green),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(CurrencyUtils.formatAmount(totalSpent)),
                        Text(
                          'Remaining: ${CurrencyUtils.formatAmount(_monthlyBudget - totalSpent)}',
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
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlert(BuildContext context, String message, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
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

  void _showEditBudgetDialog() {
    final controller = TextEditingController(text: _monthlyBudget.toString());
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Monthly Budget'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          autofocus: true,
          decoration: InputDecoration(
            prefixText: '${AppConstants.currencySymbol} ',
            hintText: 'Enter amount',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final val = double.tryParse(controller.text);
              if (val != null) {
                _saveBudget(val);
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
