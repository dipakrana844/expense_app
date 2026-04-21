import '../repository.dart';
import '../entities/category_entity.dart';
import '../enums/category_type.dart';
import '../failures/category_failure.dart';

/// Use case for retrieving categories.
/// Supports filtering by type and pagination.
class GetCategoriesUseCase {
  final CategoryRepository repository;

  GetCategoriesUseCase(this.repository);

  /// Gets categories, optionally filtered by type.
  /// Returns Result<List<CategoryEntity>> indicating success or failure.
  Future<Result<List<CategoryEntity>>> call({CategoryType? type}) async {
    if (type != null) {
      return await repository.getCategoriesByType(type);
    }
    return await repository.getAllCategories();
  }

  /// Gets paginated categories.
  Future<Result<List<CategoryEntity>>> getPaginated({
    required int page,
    required int pageSize,
    CategoryType? type,
  }) async {
    return await repository.getPaginatedCategories(
      page: page,
      pageSize: pageSize,
      type: type,
    );
  }

  /// Searches categories by name.
  Future<Result<List<CategoryEntity>>> search(String query) async {
    return await repository.searchCategories(query);
  }

  /// Gets the total count of active categories.
  Future<Result<int>> getCount({CategoryType? type}) async {
    if (type != null) {
      return await repository.getActiveCategoryCountByType(type);
    }
    return await repository.getActiveCategoryCount();
  }
}
