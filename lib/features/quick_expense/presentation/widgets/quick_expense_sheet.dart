import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_expense_tracker/core/constants/app_constants.dart';
import '../providers/quick_expense_provider.dart';

/// Quick Expense Bottom Sheet
///
/// A lightweight bottom sheet for adding expenses with minimal friction.
///
/// Features:
/// - Auto-focus on amount field
/// - Remember last used category
/// - Keyboard opens immediately
/// - Enter key submits
/// - Double tap prevention
/// - Currency formatting (₹)
class QuickExpenseSheet extends ConsumerStatefulWidget {
  const QuickExpenseSheet({super.key});

  @override
  ConsumerState<QuickExpenseSheet> createState() => _QuickExpenseSheetState();

  /// Show the quick expense bottom sheet
  static Future<bool?> show(BuildContext context) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      useSafeArea: true,
      builder: (context) => const QuickExpenseSheet(),
    );
  }
}

class _QuickExpenseSheetState extends ConsumerState<QuickExpenseSheet> {
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  final _amountFocusNode = FocusNode();
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    // Reset state when sheet opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(quickExpenseNotifierProvider.notifier).reset();
      // Auto-focus amount field
      _amountFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    _amountFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(quickExpenseNotifierProvider);
    final notifier = ref.read(quickExpenseNotifierProvider.notifier);

    return AnimatedPadding(
      duration: const Duration(milliseconds: 150),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Text(
                'Quick Expense',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Add expense in seconds',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 24),

              // Amount Field (Primary Focus)
              _buildAmountField(notifier),
              const SizedBox(height: 16),

              // Category Selector
              _buildCategorySelector(state.category, notifier),
              const SizedBox(height: 16),

              // Optional Note
              _buildNoteField(notifier),
              const SizedBox(height: 24),

              // Error Message
              if (state.errorMessage != null) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          state.errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Save Button
              FilledButton(
                onPressed: state.isSaving || _isSubmitting
                    ? null
                    : () => _handleSave(),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: state.isSaving
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check),
                          SizedBox(width: 8),
                          Text(
                            'Add Expense',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAmountField(notifier) {
    return TextField(
      controller: _amountController,
      focusNode: _amountFocusNode,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      textInputAction: TextInputAction.next,
      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
      ],
      decoration: InputDecoration(
        prefixText: '${AppConstants.currencySymbol} ',
        prefixStyle: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
        hintText: '0.00',
        hintStyle: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.grey.withOpacity(0.5),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        filled: true,
        fillColor: Theme.of(
          context,
        ).colorScheme.surfaceContainerHighest.withOpacity(0.3),
        contentPadding: const EdgeInsets.all(20),
      ),
      onChanged: (value) => notifier.updateAmount(value),
      onSubmitted: (_) => _handleSave(),
    );
  }

  Widget _buildCategorySelector(String selectedCategory, notifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style: Theme.of(
            context,
          ).textTheme.labelMedium?.copyWith(color: Colors.grey),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: AppConstants.expenseCategories.map((category) {
            final isSelected = category == selectedCategory;
            return FilterChip(
              label: Text(category),
              selected: isSelected,
              onSelected: (_) => notifier.updateCategory(category),
              avatar: isSelected
                  ? null
                  : Icon(
                      IconData(
                        AppConstants.categoryIcons[category] ?? 0xe5cc,
                        fontFamily: 'MaterialIcons',
                      ),
                      size: 18,
                    ),
              showCheckmark: false,
              labelStyle: TextStyle(
                color: isSelected
                    ? Theme.of(context).colorScheme.onPrimary
                    : null,
                fontWeight: isSelected ? FontWeight.bold : null,
              ),
              backgroundColor: Theme.of(
                context,
              ).colorScheme.surfaceContainerHighest,
              selectedColor: Theme.of(context).colorScheme.primary,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildNoteField(notifier) {
    return TextField(
      controller: _noteController,
      textInputAction: TextInputAction.done,
      maxLines: 1,
      decoration: InputDecoration(
        labelText: 'Note (optional)',
        hintText: 'e.g., Coffee with friends',
        prefixIcon: const Icon(Icons.notes),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      onChanged: (value) => notifier.updateNote(value),
      onSubmitted: (_) => _handleSave(),
    );
  }

  Future<void> _handleSave() async {
    // Double tap prevention
    if (_isSubmitting) return;

    setState(() => _isSubmitting = true);

    try {
      final notifier = ref.read(quickExpenseNotifierProvider.notifier);
      final success = await notifier.saveExpense();

      if (success && mounted) {
        // Show success feedback
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 8),
                Text('Expense added!'),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
        // Close sheet with success
        Navigator.of(context).pop(true);
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }
}
