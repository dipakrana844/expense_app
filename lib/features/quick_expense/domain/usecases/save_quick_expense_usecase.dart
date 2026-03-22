import 'package:smart_expense_tracker/features/expenses/domain/entities/expense_entity.dart';
import '../repositories/quick_expense_repository.dart';

/// Use case for saving a quick expense
///
/// This use case encapsulates the business logic for saving a quick expense,
/// following the single responsibility principle.
class SaveQuickExpenseUseCase {
  final QuickExpenseRepository _repository;

  SaveQuickExpenseUseCase(this._repository);

  /// Execute the use case to save a quick expense
  ///
  /// [expense]: The expense entity to save
  /// Returns [Future<bool>] indicating success or failure
  Future<bool> execute(ExpenseEntity expense) async {
    return await _repository.saveQuickExpense(expense);
  }
}