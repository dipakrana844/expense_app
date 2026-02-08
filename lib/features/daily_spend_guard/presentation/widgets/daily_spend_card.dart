import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_expense_tracker/core/utils/utils.dart';
import 'package:smart_expense_tracker/features/daily_spend_guard/data/models/daily_spend_state.dart';
import 'package:smart_expense_tracker/features/daily_spend_guard/presentation/providers/daily_spend_providers.dart';

/// Widget: DailySpendCard
///
/// Purpose: Visual representation of daily spending status
/// - Shows today's spending vs daily limit
/// - Displays color-coded status (Green/Yellow/Red)
/// - Provides clear, non-judgmental feedback
///
/// Design Philosophy:
/// - Extremely simple and fast
/// - No charts or complex visuals
/// - Emotionally clear status indication
/// - Works well in both light and dark themes

class DailySpendCard extends ConsumerWidget {
  final bool showFullDetails; // Whether to show all details or compact view
  
  const DailySpendCard({
    super.key,
    this.showFullDetails = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dailySpendState = ref.watch(dailySpendStateProvider);

    return dailySpendState.when(
      loading: () => _buildLoadingCard(context),
      error: (error, _) => _buildErrorCard(context, error.toString()),
      data: (state) => _buildContentCard(context, state),
    );
  }

  /// Loading state card
  Widget _buildLoadingCard(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 16),
            Text(
              'Calculating daily limit...',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  /// Error state card
  Widget _buildErrorCard(BuildContext context, String errorMessage) {
    return Card(
      margin: const EdgeInsets.all(16),
      color: Theme.of(context).colorScheme.errorContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              Icons.error_outline,
              color: Theme.of(context).colorScheme.onErrorContainer,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Unable to load daily spending data',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onErrorContainer,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Content card with spending information
  Widget _buildContentCard(BuildContext context, DailySpendState state) {
    final statusColor = _getStatusColor(state.status, context);
    final statusText = _getStatusText(state.status);
    final statusIcon = _getStatusIcon(state.status);

    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: statusColor.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              statusColor.withOpacity(0.1),
              statusColor.withOpacity(0.05),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with status indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Daily Spend Guard',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          statusIcon,
                          size: 16,
                          color: statusColor,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          statusText,
                          style: TextStyle(
                            color: statusColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),

              // Main spending information
              if (showFullDetails) ...[
                _buildSpendingRow(
                  context,
                  'Today Spent',
                  state.todaySpent,
                  Theme.of(context).colorScheme.onSurface,
                ),
                
                const SizedBox(height: 8),
                
                _buildSpendingRow(
                  context,
                  'Daily Limit',
                  state.dailyLimit,
                  Theme.of(context).colorScheme.primary,
                ),
                
                const SizedBox(height: 8),
                
                _buildSpendingRow(
                  context,
                  'Remaining',
                  state.remaining,
                  _getRemainingTextColor(state.remaining, context),
                ),
                
                const SizedBox(height: 16),
                
                // Progress visualization
                _buildProgressIndicator(context, state),
              ] else ...[
                // Compact view - just the essentials
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCompactInfo(
                      context,
                      'Spent',
                      state.todaySpent,
                      Theme.of(context).colorScheme.onSurface,
                    ),
                    _buildCompactInfo(
                      context,
                      'Limit',
                      state.dailyLimit,
                      Theme.of(context).colorScheme.primary,
                    ),
                    _buildCompactInfo(
                      context,
                      'Left',
                      state.remaining,
                      _getRemainingTextColor(state.remaining, context),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// Build a row showing spending information
  Widget _buildSpendingRow(
    BuildContext context,
    String label,
    double amount,
    Color color,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        Text(
          CurrencyUtils.formatAmount(amount),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  /// Build compact information display
  Widget _buildCompactInfo(
    BuildContext context,
    String label,
    double amount,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        Text(
          CurrencyUtils.formatAmount(amount),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  /// Build progress visualization bar
  Widget _buildProgressIndicator(BuildContext context, DailySpendState state) {
    final progress = state.dailyLimit > 0 
        ? (state.todaySpent / state.dailyLimit).clamp(0.0, 1.0)
        : 0.0;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${(progress * 100).toStringAsFixed(0)}% of daily limit used',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
          color: _getStatusColor(state.status, context),
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }

  /// Get color based on spending status
  Color _getStatusColor(SpendStatus status, BuildContext context) {
    switch (status) {
      case SpendStatus.safe:
        return Colors.green;
      case SpendStatus.caution:
        return Colors.orange;
      case SpendStatus.exceeded:
        return Colors.red;
    }
  }

  /// Get text description for status
  String _getStatusText(SpendStatus status) {
    switch (status) {
      case SpendStatus.safe:
        return 'Safe to spend';
      case SpendStatus.caution:
        return 'Caution zone';
      case SpendStatus.exceeded:
        return 'Limit exceeded';
    }
  }

  /// Get icon for status
  IconData _getStatusIcon(SpendStatus status) {
    switch (status) {
      case SpendStatus.safe:
        return Icons.check_circle;
      case SpendStatus.caution:
        return Icons.warning;
      case SpendStatus.exceeded:
        return Icons.error;
    }
  }

  /// Get text color for remaining amount
  Color _getRemainingTextColor(double remaining, BuildContext context) {
    if (remaining < 0) {
      return Colors.red;
    } else if (remaining == 0) {
      return Theme.of(context).colorScheme.onSurfaceVariant;
    } else {
      return Colors.green;
    }
  }
}