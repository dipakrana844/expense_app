import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:smart_expense_tracker/core/services/balance_service.dart';
import 'package:smart_expense_tracker/features/expenses/presentation/providers/expense_providers.dart';
import 'package:smart_expense_tracker/features/income/presentation/providers/income_providers.dart';

/// Widget: BalanceSummaryCard
///
/// Purpose: Displays current financial balance and key metrics
/// - Shows total income, expenses, and net balance
/// - Displays savings rate and financial health
/// - Provides quick insights into financial status
class BalanceSummaryCard extends ConsumerWidget {
  final bool showDetailedMetrics;

  const BalanceSummaryCard({super.key, this.showDetailedMetrics = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final incomesAsync = ref.watch(incomesProvider);
    final expensesAsync = ref.watch(expensesProvider);
    final theme = Theme.of(context);
    final formatter = NumberFormat.currency(locale: 'en_US', symbol: '\$');

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: incomesAsync.when(
          data: (incomes) => expensesAsync.when(
            data: (expenses) => _buildContent(
              context,
              ref,
              incomes,
              expenses,
              theme,
              formatter,
            ),
            loading: () => _buildLoadingState(theme),
            error: (error, _) => _buildErrorState(theme, error.toString()),
          ),
          loading: () => _buildLoadingState(theme),
          error: (error, _) => _buildErrorState(theme, error.toString()),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    List<dynamic> incomes,
    List<dynamic> expenses,
    ThemeData theme,
    NumberFormat formatter,
  ) {
    final balanceService = BalanceService();

    final totalIncome = balanceService.getTotalIncome(incomes: incomes.cast());
    final totalExpenses = balanceService.getTotalExpenses(
      expenses: expenses.cast(),
    );
    final currentBalance = balanceService.getCurrentBalance(
      incomes: incomes.cast(),
      expenses: expenses.cast(),
    );
    final savingsRate = balanceService.getSavingsRate(
      incomes: incomes.cast(),
      expenses: expenses.cast(),
    );
    final financialHealth = balanceService.getFinancialHealth(
      incomes: incomes.cast(),
      expenses: expenses.cast(),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          children: [
            Icon(
              Icons.account_balance,
              color: theme.colorScheme.primary,
              size: 24,
            ),
            const SizedBox(width: 12),
            Text(
              'Financial Summary',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Current Balance
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _getBalanceColor(currentBalance, theme),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                'Current Balance',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: _getBalanceTextColor(currentBalance, theme),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                formatter.format(currentBalance),
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: _getBalanceTextColor(currentBalance, theme),
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (currentBalance < 0)
                Text(
                  '(${formatter.format(currentBalance.abs())} overspent)',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: _getBalanceTextColor(currentBalance, theme),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Income and Expenses Row
        Row(
          children: [
            _buildMetricCard(
              context,
              'Income',
              formatter.format(totalIncome),
              Icons.trending_up,
              theme.colorScheme.primary,
            ),
            const SizedBox(width: 12),
            _buildMetricCard(
              context,
              'Expenses',
              formatter.format(totalExpenses),
              Icons.trending_down,
              theme.colorScheme.error,
            ),
          ],
        ),

        if (showDetailedMetrics) ...[
          const SizedBox(height: 16),

          // Savings Rate and Health
          Row(
            children: [
              _buildMetricCard(
                context,
                'Savings Rate',
                '${savingsRate.toStringAsFixed(1)}%',
                _getSavingsRateIcon(savingsRate),
                _getSavingsRateColor(savingsRate, theme),
              ),
              const SizedBox(width: 12),
              _buildMetricCard(
                context,
                'Financial Health',
                _getFinancialHealthLabel(financialHealth),
                _getFinancialHealthIcon(financialHealth),
                _getFinancialHealthColor(financialHealth, theme),
              ),
            ],
          ),
        ],

        const SizedBox(height: 8),

        // Status Message
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest.withValues(
              alpha: 0.5,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            _getStatusMessage(currentBalance, savingsRate, financialHealth),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    final theme = Theme.of(context);

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: theme.dividerColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 4),
            Text(
              value,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState(ThemeData theme) {
    return Center(
      child: Column(
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text('Calculating balance...', style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }

  Widget _buildErrorState(ThemeData theme, String error) {
    return Center(
      child: Column(
        children: [
          Icon(Icons.error_outline, color: theme.colorScheme.error, size: 48),
          const SizedBox(height: 16),
          Text(
            'Unable to load financial data',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.error,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            error,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Color _getBalanceColor(double balance, ThemeData theme) {
    if (balance < 0) return theme.colorScheme.errorContainer;
    if (balance == 0) return theme.colorScheme.surfaceContainerHighest;
    return theme.colorScheme.primaryContainer;
  }

  Color _getBalanceTextColor(double balance, ThemeData theme) {
    if (balance < 0) return theme.colorScheme.onErrorContainer;
    if (balance == 0) return theme.colorScheme.onSurfaceVariant;
    return theme.colorScheme.onPrimaryContainer;
  }

  IconData _getSavingsRateIcon(double rate) {
    if (rate < 0) return Icons.arrow_downward;
    if (rate >= 50) return Icons.emoji_events;
    if (rate >= 20) return Icons.trending_up;
    return Icons.trending_flat;
  }

  Color _getSavingsRateColor(double rate, ThemeData theme) {
    if (rate < 0) return theme.colorScheme.error;
    if (rate >= 50) return theme.colorScheme.primary;
    if (rate >= 20) return theme.colorScheme.secondary;
    return theme.colorScheme.onSurfaceVariant;
  }

  IconData _getFinancialHealthIcon(FinancialHealth health) {
    switch (health) {
      case FinancialHealth.excellent:
        return Icons.emoji_events;
      case FinancialHealth.good:
        return Icons.thumb_up;
      case FinancialHealth.fair:
        return Icons.info;
      case FinancialHealth.poor:
        return Icons.warning;
      case FinancialHealth.negative:
        return Icons.error;
    }
  }

  Color _getFinancialHealthColor(FinancialHealth health, ThemeData theme) {
    switch (health) {
      case FinancialHealth.excellent:
        return theme.colorScheme.primary;
      case FinancialHealth.good:
        return theme.colorScheme.secondary;
      case FinancialHealth.fair:
        return theme.colorScheme.tertiary;
      case FinancialHealth.poor:
        return theme.colorScheme.onSurfaceVariant;
      case FinancialHealth.negative:
        return theme.colorScheme.error;
    }
  }

  String _getFinancialHealthLabel(FinancialHealth health) {
    switch (health) {
      case FinancialHealth.excellent:
        return 'Excellent';
      case FinancialHealth.good:
        return 'Good';
      case FinancialHealth.fair:
        return 'Fair';
      case FinancialHealth.poor:
        return 'Poor';
      case FinancialHealth.negative:
        return 'Negative';
    }
  }

  String _getStatusMessage(
    double balance,
    double savingsRate,
    FinancialHealth health,
  ) {
    if (balance < 0) {
      return '⚠️ You\'re spending more than you earn. Consider reviewing your expenses.';
    }

    if (savingsRate >= 50) {
      return '🎉 Great job! You\'re saving more than half of your income.';
    }

    if (savingsRate >= 20) {
      return '👍 Good savings rate. Keep up the financial discipline!';
    }

    if (savingsRate >= 5) {
      return 'ℹ️ Moderate savings. Look for opportunities to increase income or reduce expenses.';
    }

    if (savingsRate > 0) {
      return '⚠️ Low savings rate. Focus on building better financial habits.';
    }

    return '🚨 Critical situation. Immediate action needed to improve your financial health.';
  }
}
