import '../domain/repository.dart';
import '../domain/entities/category_entity.dart';
import '../domain/enums/category_type.dart';
import '../domain/failures/category_failure.dart';
import 'datasource/category_local_data_source.dart';
import 'models/category_model.dart';

/// Implementation of CategoryRepository using local data source.
/// Handles data transformation and error mapping.
class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryLocalDataSource dataSource;

  CategoryRepositoryImpl(this.dataSource);

  @override
  Future<Result<List<CategoryEntity>>> getAllCategories() async {
    try {
      final models = dataSource.getAllCategories();
      final entities = models.map((model) => model.toEntity()).toList();
      return Result.success(entities);
    } on StorageFailure catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnexpectedFailure(
          message: 'Failed to get all categories',
          exception: e is Exception ? e : Exception(e.toString()),
        ),
      );
    }
  }

  @override
  Future<Result<List<CategoryEntity>>> getCategoriesByType(
    CategoryType type,
  ) async {
    try {
      final models = dataSource.getCategoriesByType(type);
      final entities = models.map((model) => model.toEntity()).toList();
      return Result.success(entities);
    } on StorageFailure catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnexpectedFailure(
          message: 'Failed to get categories by type',
          exception: e is Exception ? e : Exception(e.toString()),
        ),
      );
    }
  }

  @override
  Future<Result<CategoryEntity>> getCategoryById(String id) async {
    try {
      final model = dataSource.getCategoryById(id);
      if (model == null) {
        return Result.failure(NotFoundFailure(id));
      }
      return Result.success(model.toEntity());
    } on StorageFailure catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnexpectedFailure(
          message: 'Failed to get category by ID',
          exception: e is Exception ? e : Exception(e.toString()),
        ),
      );
    }
  }

  @override
  Future<Result<void>> addCategory(CategoryEntity category) async {
    try {
      final model = CategoryModel.fromEntity(category);
      await dataSource.addCategory(model);
      return Result.success(null);
    } on ValidationFailure catch (e) {
      return Result.failure(e);
    } on DuplicateFailure catch (e) {
      return Result.failure(e);
    } on StorageFailure catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnexpectedFailure(
          message: 'Failed to add category',
          exception: e is Exception ? e : Exception(e.toString()),
        ),
      );
    }
  }

  @override
  Future<Result<void>> updateCategory(CategoryEntity category) async {
    try {
      final model = CategoryModel.fromEntity(category);
      await dataSource.updateCategory(model);
      return Result.success(null);
    } on ValidationFailure catch (e) {
      return Result.failure(e);
    } on DuplicateFailure catch (e) {
      return Result.failure(e);
    } on NotFoundFailure catch (e) {
      return Result.failure(e);
    } on StorageFailure catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnexpectedFailure(
          message: 'Failed to update category',
          exception: e is Exception ? e : Exception(e.toString()),
        ),
      );
    }
  }

  @override
  Future<Result<void>> deleteCategory(String id) async {
    try {
      await dataSource.deleteCategory(id);
      return Result.success(null);
    } on NotFoundFailure catch (e) {
      return Result.failure(e);
    } on StorageFailure catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnexpectedFailure(
          message: 'Failed to delete category',
          exception: e is Exception ? e : Exception(e.toString()),
        ),
      );
    }
  }

  @override
  Future<Result<void>> restoreCategory(String id) async {
    try {
      await dataSource.restoreCategory(id);
      return Result.success(null);
    } on NotFoundFailure catch (e) {
      return Result.failure(e);
    } on StorageFailure catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnexpectedFailure(
          message: 'Failed to restore category',
          exception: e is Exception ? e : Exception(e.toString()),
        ),
      );
    }
  }

  @override
  Future<Result<List<CategoryEntity>>> searchCategories(String query) async {
    try {
      final models = dataSource.searchCategories(query);
      final entities = models.map((model) => model.toEntity()).toList();
      return Result.success(entities);
    } on StorageFailure catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnexpectedFailure(
          message: 'Failed to search categories',
          exception: e is Exception ? e : Exception(e.toString()),
        ),
      );
    }
  }

  @override
  Future<Result<List<CategoryEntity>>> getPaginatedCategories({
    required int page,
    required int pageSize,
    CategoryType? type,
  }) async {
    try {
      final models = dataSource.getPaginatedCategories(
        page: page,
        pageSize: pageSize,
        type: type,
      );
      final entities = models.map((model) => model.toEntity()).toList();
      return Result.success(entities);
    } on StorageFailure catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnexpectedFailure(
          message: 'Failed to get paginated categories',
          exception: e is Exception ? e : Exception(e.toString()),
        ),
      );
    }
  }

  @override
  Future<Result<int>> getActiveCategoryCount() async {
    try {
      final count = dataSource.getActiveCategoryCount();
      return Result.success(count);
    } on StorageFailure catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnexpectedFailure(
          message: 'Failed to get category count',
          exception: e is Exception ? e : Exception(e.toString()),
        ),
      );
    }
  }

  @override
  Future<Result<int>> getActiveCategoryCountByType(CategoryType type) async {
    try {
      final count = dataSource.getActiveCategoryCountByType(type);
      return Result.success(count);
    } on StorageFailure catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnexpectedFailure(
          message: 'Failed to get category count by type',
          exception: e is Exception ? e : Exception(e.toString()),
        ),
      );
    }
  }
}
