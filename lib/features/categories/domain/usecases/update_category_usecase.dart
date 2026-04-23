import '../repository.dart';
import '../entities/category_entity.dart';
import '../failures/category_failure.dart';

/// Use case for updating an existing category.
/// Handles validation and duplicate checking.
class UpdateCategoryUseCase {
  final CategoryRepository repository;

  UpdateCategoryUseCase(this.repository);

  /// Updates an existing category in the repository.
  /// Returns Result<void> indicating success or failure.
  Future<Result<void>> call(CategoryEntity category) async {
    return await repository.updateCategory(category);
  }
}
