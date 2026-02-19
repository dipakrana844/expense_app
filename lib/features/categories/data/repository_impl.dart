import '../domain/repository.dart';
import '../domain/entities/category_entity.dart';
import 'datasource/category_local_data_source.dart';
import 'models/category_model.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryLocalDataSource dataSource;

  CategoryRepositoryImpl(this.dataSource);

  @override
  Future<List<CategoryEntity>> getAllCategories() async {
    final models = await dataSource.getAllCategories();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<CategoryEntity>> getCategoriesByType(String type) async {
    final models = await dataSource.getCategoriesByType(type);
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<CategoryEntity?> getCategoryById(String id) async {
    final model = await dataSource.getCategoryById(id);
    return model?.toEntity();
  }

  @override
  Future<void> addCategory(CategoryEntity category) async {
    final model = CategoryModel.fromEntity(category);
    await dataSource.addCategory(model);
  }

  @override
  Future<void> updateCategory(CategoryEntity category) async {
    final model = CategoryModel.fromEntity(category);
    await dataSource.updateCategory(model);
  }

  @override
  Future<void> deleteCategory(String id) async {
    await dataSource.deleteCategory(id);
  }
}