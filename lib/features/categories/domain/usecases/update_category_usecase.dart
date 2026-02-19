import '../repository.dart';
import '../entities/category_entity.dart';

class UpdateCategoryUseCase {
  final CategoryRepository repository;

  UpdateCategoryUseCase(this.repository);

  Future<void> call(CategoryEntity category) async {
    await repository.updateCategory(category);
  }
}