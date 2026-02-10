import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/enums/transaction_type.dart';
import '../providers/transaction_providers.dart';

/// Widget: TransactionFilterBar
///
/// Provides filtering controls for transactions.
/// Allows switching between All/Income/Expenses views.
class TransactionFilterBar extends ConsumerWidget {
  const TransactionFilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterState = ref.watch(transactionFilterProvider);
    final theme = Theme.of(context);

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
          // Filter Label
          // Text(
          //   'View:',
          //   style: theme.textTheme.bodyMedium?.copyWith(
          //     fontWeight: FontWeight.w500,
          //     color: theme.colorScheme.onSurfaceVariant,
          //   ),
          // ),
          
          // const SizedBox(width: 12),
          
          // Segmented Control
          Expanded(
            child: _buildSegmentedControl(context, ref, filterState, theme),
          ),
          
          const SizedBox(width: 12),
          
          // Clear Filters Button (only show when filters are active)
          if (filterState.hasFilters)
            IconButton(
              icon: Icon(
                Icons.clear,
                size: 20,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              onPressed: () => ref
                  .read(transactionFilterProvider.notifier)
                  .clearFilters(),
              tooltip: 'Clear filters',
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              visualDensity: VisualDensity.compact,
            ),
        ],
      ),
    );
  }

  Widget _buildSegmentedControl(BuildContext context, WidgetRef ref,
      TransactionFilterState filterState, ThemeData theme) {
    final isSelected = filterState.type;
    
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          // All Button
          _buildFilterButton(
            context,
            'All',
            null,
            isSelected == null,
            theme,
            () => ref.read(transactionFilterProvider.notifier).setType(null),
          ),
          
          // Income Button
          _buildFilterButton(
            context,
            'Income',
            TransactionType.income,
            isSelected == TransactionType.income,
            theme,
            () => ref
                .read(transactionFilterProvider.notifier)
                .toggleType(TransactionType.income),
          ),
          
          // Expenses Button
          _buildFilterButton(
            context,
            'Expenses',
            TransactionType.expense,
            isSelected == TransactionType.expense,
            theme,
            () => ref
                .read(transactionFilterProvider.notifier)
                .toggleType(TransactionType.expense),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(
    BuildContext context,
    String label,
    TransactionType? type,
    bool isSelected,
    ThemeData theme,
    VoidCallback onPressed,
  ) {
    final color = isSelected ? theme.colorScheme.primary : Colors.transparent;
    final textColor = isSelected
        ? theme.colorScheme.onPrimary
        : theme.colorScheme.onSurfaceVariant;
    
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Indicator icon
                if (type != null) ...[
                  Icon(
                    type == TransactionType.income
                        ? Icons.trending_up
                        : Icons.trending_down,
                    size: 16,
                    color: textColor,
                  ),
                  const SizedBox(width: 4),
                ],
                
                // Label
                Flexible(
                  child: Text(
                    label,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: textColor,
                      fontSize: 13, // Slightly smaller font
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}