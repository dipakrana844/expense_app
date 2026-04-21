import 'package:smart_expense_tracker/features/categories/domain/entities/category_entity.dart';
import 'package:smart_expense_tracker/features/categories/domain/enums/category_type.dart';
import 'package:smart_expense_tracker/features/categories/domain/failures/category_failure.dart';

/// Abstract repository for category operations.
/// Defines the contract for category data access.
abstract class CategoryRepository {
  /// Gets all categories (excluding soft-deleted ones)
  Future<Result<List<CategoryEntity>>> getAllCategories();

  /// Gets categories filtered by type
  Future<Result<List<CategoryEntity>>> getCategoriesByType(CategoryType type);

  /// Gets a category by ID
  Future<Result<CategoryEntity>> getCategoryById(String id);

  /// Adds a new category
  Future<Result<void>> addCategory(CategoryEntity category);

  /// Updates an existing category
  Future<Result<void>> updateCategory(CategoryEntity category);

  /// Soft deletes a category
  Future<Result<void>> deleteCategory(String id);

  /// Restores a soft-deleted category
  Future<Result<void>> restoreCategory(String id);

  /// Searches categories by name
  Future<Result<List<CategoryEntity>>> searchCategories(String query);

  /// Gets paginated categories
  Future<Result<List<CategoryEntity>>> getPaginatedCategories({
    required int page,
    required int pageSize,
    CategoryType? type,
  });

  /// Gets the total count of active categories
  Future<Result<int>> getActiveCategoryCount();

  /// Gets the count of active categories by type
  Future<Result<int>> getActiveCategoryCountByType(CategoryType type);
}
