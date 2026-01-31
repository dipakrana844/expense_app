import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../expenses/presentation/providers/expense_providers.dart';
import 'quick_expense_state.dart';

part 'quick_expense_provider.g.dart';

/// Provider for quick expense functionality
///
/// Manages quick expense state and integrates with the existing
/// expense repository for persistence.
@riverpod
class QuickExpenseNotifier extends _$QuickExpenseNotifier {
  // Hive box key for storing last used category
  static const _lastCategoryKey = 'last_quick_expense_category';

  @override
  QuickExpenseState build() {
    // Load last used category from storage
    _loadLastUsedCategory();
    return const QuickExpenseState();
  }

  /// Load the last used category from Hive
  Future<void> _loadLastUsedCategory() async {
    try {
      final box = await Hive.openBox<String>('quick_expense_prefs');
      final lastCategory = box.get(_lastCategoryKey);
      if (lastCategory != null) {
        state = state.copyWith(
          lastUsedCategory: lastCategory,
          category: lastCategory,
        );
      }
    } catch (_) {
      // Ignore storage errors for preferences
    }
  }

  /// Save the last used category to Hive
  Future<void> _saveLastUsedCategory(String category) async {
    try {
      final box = await Hive.openBox<String>('quick_expense_prefs');
      await box.put(_lastCategoryKey, category);
    } catch (_) {
      // Ignore storage errors for preferences
    }
  }

  /// Update the amount field
  void updateAmount(String value) {
    state = state.copyWith(amount: value, errorMessage: null);
  }

  /// Update the selected category
  void updateCategory(String category) {
    state = state.copyWith(category: category, errorMessage: null);
  }

  /// Update the note field
  void updateNote(String note) {
    state = state.copyWith(note: note);
  }

  /// Save the quick expense
  ///
  /// Validates input and saves to repository
  Future<bool> saveExpense() async {
    // Validate amount
    final amount = double.tryParse(state.amount);
    if (amount == null || amount <= 0) {
      state = state.copyWith(
        errorMessage: 'Please enter a valid amount greater than 0',
      );
      return false;
    }

    // Start saving
    state = state.copyWith(isSaving: true, errorMessage: null);

    try {
      // Use existing expense notifier to add the expense
      await ref
          .read(expensesProvider.notifier)
          .addExpense(
            amount: amount,
            category: state.category,
            date: DateTime.now(),
            note: state.note.isEmpty ? null : state.note.trim(),
          );

      // Save last used category for smart defaults
      await _saveLastUsedCategory(state.category);

      // Mark as success
      state = state.copyWith(isSaving: false, isSuccess: true);
      return true;
    } catch (e) {
      state = state.copyWith(
        isSaving: false,
        errorMessage: 'Failed to save expense: ${e.toString()}',
      );
      return false;
    }
  }

  /// Reset state for a new quick expense
  void reset() {
    final lastCategory = state.lastUsedCategory;
    state = QuickExpenseState(
      lastUsedCategory: lastCategory,
      category: lastCategory ?? 'Grocery',
    );
  }

  /// Clear any error message
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

/// Provider to check if last save was successful
/// Useful for showing success feedback
@riverpod
bool quickExpenseSuccess(Ref ref) {
  final state = ref.watch(quickExpenseNotifierProvider);
  return state.isSuccess;
}
