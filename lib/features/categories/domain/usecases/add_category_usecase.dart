import '../repository.dart';
import '../entities/category_entity.dart';
import '../failures/category_failure.dart';

/// Use case for adding a new category.
/// Handles validation and duplicate checking.
class AddCategoryUseCase {
  final CategoryRepository repository;

  AddCategoryUseCase(this.repository);

  /// Adds a new category to the repository.
  /// Returns Result<void> indicating success or failure.
  Future<Result<void>> call(CategoryEntity category) async {
    return await repository.addCategory(category);
  }
}
