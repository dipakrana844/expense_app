import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/financial_trend_providers.dart';

/// Widget: Time Range Selector
///
/// Purpose: Allows users to select different time ranges for financial trend analysis
/// - Demonstrates the use of family providers with parameterized queries
/// - Updates the financial trend data based on selected time range
class TimeRangeSelector extends ConsumerWidget {
  const TimeRangeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final currentMonthsBack = ref.watch(financialTrendMonthsBackProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.3)
                : Colors.grey.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Time Range',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children: [
              _TimeRangeButton(
                label: '3 Months',
                monthsBack: 3,
                isSelected: currentMonthsBack == 3,
                onTap: () => _updateTimeRange(ref, 3),
              ),
              _TimeRangeButton(
                label: '6 Months',
                monthsBack: 6,
                isSelected: currentMonthsBack == 6,
                onTap: () => _updateTimeRange(ref, 6),
              ),
              _TimeRangeButton(
                label: '12 Months',
                monthsBack: 12,
                isSelected: currentMonthsBack == 12,
                onTap: () => _updateTimeRange(ref, 12),
              ),
              _TimeRangeButton(
                label: '24 Months',
                monthsBack: 24,
                isSelected: currentMonthsBack == 24,
                onTap: () => _updateTimeRange(ref, 24),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _updateTimeRange(WidgetRef ref, int monthsBack) {
    ref.read(financialTrendMonthsBackProvider.notifier).state = monthsBack;

    // Refresh the financial trend data with the new time range
    final notifier = ref.read(financialTrendProvider.notifier);
    notifier.refresh();
  }
}

class _TimeRangeButton extends StatelessWidget {
  final String label;
  final int monthsBack;
  final bool isSelected;
  final VoidCallback onTap;

  const _TimeRangeButton({
    required this.label,
    required this.monthsBack,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? Colors.blue[700] : Colors.blue[500])
              : (isDark ? Colors.grey[800] : Colors.grey[200]),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? (isDark ? Colors.blue[500]! : Colors.blue[700]!)
                : (isDark ? Colors.grey[700]! : Colors.grey[300]!),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: isSelected
                ? Colors.white
                : (isDark ? Colors.grey[300] : Colors.grey[700]),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
