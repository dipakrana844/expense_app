import '../repository.dart';
import '../entities/category_entity.dart';

class AddCategoryUseCase {
  final CategoryRepository repository;

  AddCategoryUseCase(this.repository);

  Future<void> call(CategoryEntity category) async {
    await repository.addCategory(category);
  }
}