import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../domain/usecases/get_categories_usecase.dart';
import '../../domain/usecases/add_category_usecase.dart';
import '../../domain/usecases/update_category_usecase.dart';
import '../../domain/usecases/delete_category_usecase.dart';
import '../../data/datasource/category_local_data_source.dart';
import '../../data/repository_impl.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/repository.dart';

final categoryLocalDataSourceProvider = Provider<CategoryLocalDataSource>((ref) {
  // Data source is expected to be initialized elsewhere (e.g., in main.dart)
  return CategoryLocalDataSource();
});

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  final dataSource = ref.watch(categoryLocalDataSourceProvider);
  return CategoryRepositoryImpl(dataSource);
});

final getCategoriesUseCaseProvider = Provider<GetCategoriesUseCase>((ref) {
  final repository = ref.watch(categoryRepositoryProvider);
  return GetCategoriesUseCase(repository);
});

final addCategoryUseCaseProvider = Provider<AddCategoryUseCase>((ref) {
  final repository = ref.watch(categoryRepositoryProvider);
  return AddCategoryUseCase(repository);
});

final updateCategoryUseCaseProvider = Provider<UpdateCategoryUseCase>((ref) {
  final repository = ref.watch(categoryRepositoryProvider);
  return UpdateCategoryUseCase(repository);
});

final deleteCategoryUseCaseProvider = Provider<DeleteCategoryUseCase>((ref) {
  final repository = ref.watch(categoryRepositoryProvider);
  return DeleteCategoryUseCase(repository);
});

final categoriesProvider = FutureProvider.autoDispose<List<CategoryEntity>>((ref) async {
  final useCase = ref.watch(getCategoriesUseCaseProvider);
  return await useCase.call();
});

final categoriesByTypeProvider = FutureProvider.family<List<CategoryEntity>, String>((ref, type) async {
  final useCase = ref.watch(getCategoriesUseCaseProvider);
  return await useCase.call(type: type);
});

final categoryControllerProvider = StateNotifierProvider<CategoryController, CategoryState>((ref) {
  return CategoryController(
    ref.watch(addCategoryUseCaseProvider),
    ref.watch(updateCategoryUseCaseProvider),
    ref.watch(deleteCategoryUseCaseProvider),
    ref.watch(getCategoriesUseCaseProvider),
  );
});

class CategoryState {
  final List<CategoryEntity> categories;
  final bool isLoading;
  final String? error;

  CategoryState({
    this.categories = const [],
    this.isLoading = false,
    this.error,
  });

  CategoryState copyWith({
    List<CategoryEntity>? categories,
    bool? isLoading,
    String? error,
  }) {
    return CategoryState(
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class CategoryController extends StateNotifier<CategoryState> {
  final AddCategoryUseCase _addCategoryUseCase;
  final UpdateCategoryUseCase _updateCategoryUseCase;
  final DeleteCategoryUseCase _deleteCategoryUseCase;
  final GetCategoriesUseCase _getCategoriesUseCase;

  CategoryController(
    this._addCategoryUseCase,
    this._updateCategoryUseCase,
    this._deleteCategoryUseCase,
    this._getCategoriesUseCase,
  ) : super(CategoryState());

  Future<void> loadCategories({String? type}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final categories = await _getCategoriesUseCase.call(type: type);
      state = state.copyWith(categories: categories, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> addCategory({
    required String name,
    required String type, // 'income' or 'expense'
    required int iconCodePoint,
    required int colorValue,
  }) async {
    final newCategory = CategoryEntity(
      id: const Uuid().v4(),
      name: name,
      type: type,
      iconCodePoint: iconCodePoint,
      colorValue: colorValue,
      createdAt: DateTime.now(),
    );
    
    try {
      await _addCategoryUseCase.call(newCategory);
      // Reload categories
      await loadCategories();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> updateCategory(CategoryEntity category) async {
    try {
      await _updateCategoryUseCase.call(category);
      // Reload categories
      await loadCategories();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> deleteCategory(String id) async {
    try {
      await _deleteCategoryUseCase.call(id);
      // Reload categories
      await loadCategories();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}