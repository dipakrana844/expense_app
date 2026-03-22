import '../repositories/quick_expense_repository.dart';

/// Use case for getting the last used category
///
/// This use case encapsulates the business logic for retrieving
/// the last used category from preferences.
class GetLastUsedCategoryUseCase {
  final QuickExpenseRepository _repository;

  GetLastUsedCategoryUseCase(this._repository);

  /// Execute the use case to get the last used category
  ///
  /// Returns [Future<String?>] the last used category or null if not set
  Future<String?> execute() async {
    return await _repository.getLastUsedCategory();
  }
}