import 'package:smart_expense_tracker/features/expenses/domain/entities/expense_entity.dart';

/// Repository interface for quick expense operations
///
/// This abstract class defines the contract for quick expense data operations,
/// following the dependency inversion principle.
abstract class QuickExpenseRepository {
  /// Save a quick expense
  ///
  /// [expense]: The expense entity to save
  /// Returns [Future<bool>] indicating success or failure
  Future<bool> saveQuickExpense(ExpenseEntity expense);

  /// Get the last used category from preferences
  ///
  /// Returns [Future<String?>] the last used category or null if not set
  Future<String?> getLastUsedCategory();

  /// Save the last used category to preferences
  ///
  /// [category]: The category to save as last used
  /// Returns [Future<void>]
  Future<void> saveLastUsedCategory(String category);
}