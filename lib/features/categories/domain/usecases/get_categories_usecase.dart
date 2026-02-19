import '../repository.dart';
import '../entities/category_entity.dart';

class GetCategoriesUseCase {
  final CategoryRepository repository;

  GetCategoriesUseCase(this.repository);

  Future<List<CategoryEntity>> call({String? type}) async {
    if (type != null) {
      return await repository.getCategoriesByType(type);
    }
    return await repository.getAllCategories();
  }
}