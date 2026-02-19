import '../repository.dart';

class DeleteCategoryUseCase {
  final CategoryRepository repository;

  DeleteCategoryUseCase(this.repository);

  Future<void> call(String id) async {
    await repository.deleteCategory(id);
  }
}