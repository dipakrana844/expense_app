import '../repository.dart';
import '../failures/category_failure.dart';

/// Use case for restoring a soft-deleted category.
/// Handles restore operations.
class RestoreCategoryUseCase {
  final CategoryRepository repository;

  RestoreCategoryUseCase(this.repository);

  /// Restores a soft-deleted category by ID.
  /// Returns Result<void> indicating success or failure.
  Future<Result<void>> call(String id) async {
    return await repository.restoreCategory(id);
  }
}
