import '../repositories/quick_expense_repository.dart';

/// Use case for saving the last used category
///
/// This use case encapsulates the business logic for saving
/// the last used category to preferences.
class SaveLastUsedCategoryUseCase {
  final QuickExpenseRepository _repository;

  SaveLastUsedCategoryUseCase(this._repository);

  /// Execute the use case to save the last used category
  ///
  /// [category]: The category to save as last used
  /// Returns [Future<void>]
  Future<void> execute(String category) async {
    await _repository.saveLastUsedCategory(category);
  }
}