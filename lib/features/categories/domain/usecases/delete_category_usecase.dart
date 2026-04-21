import '../repository.dart';
import '../failures/category_failure.dart';

/// Use case for deleting a category.
/// Handles soft delete operations.
class DeleteCategoryUseCase {
  final CategoryRepository repository;

  DeleteCategoryUseCase(this.repository);

  /// Deletes a category by ID (soft delete).
  /// Returns Result<void> indicating success or failure.
  Future<Result<void>> call(String id) async {
    return await repository.deleteCategory(id);
  }
}
