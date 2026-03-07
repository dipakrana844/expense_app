import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../domain/usecases/get_categories_usecase.dart';
import '../../domain/usecases/add_category_usecase.dart';
import '../../domain/usecases/update_category_usecase.dart';
import '../../domain/usecases/delete_category_usecase.dart';
import '../../domain/entities/category_entity.dart';
import '../../data/category_infrastructure_provider.dart';

// ---------------------------------------------------------------------------
// Use-case providers (depend only on abstract CategoryRepository)
// ---------------------------------------------------------------------------

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

// ---------------------------------------------------------------------------
// Read-only async providers
// ---------------------------------------------------------------------------

/// Provides all categories. Not autoDispose so the controller stays alive.
final categoriesProvider = FutureProvider<List<CategoryEntity>>((ref) async {
  final useCase = ref.watch(getCategoriesUseCaseProvider);
  return useCase.call();
});

/// Provides categories filtered by type ('income' | 'expense').
final categoriesByTypeProvider =
    FutureProvider.family<List<CategoryEntity>, String>((ref, type) async {
      final useCase = ref.watch(getCategoriesUseCaseProvider);
      return useCase.call(type: type);
    });

// ---------------------------------------------------------------------------
// CategoryState
// ---------------------------------------------------------------------------

class CategoryState {
  final List<CategoryEntity> categories;
  final bool isLoading;
  final String? error;

  const CategoryState({
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

// ---------------------------------------------------------------------------
// CategoryController — NotifierProvider (replaces StateNotifierProvider)
// ---------------------------------------------------------------------------

final categoryControllerProvider =
    NotifierProvider<CategoryController, CategoryState>(CategoryController.new);

class CategoryController extends Notifier<CategoryState> {
  // Use-cases resolved in build() — proper Notifier pattern.
  late final AddCategoryUseCase _addCategoryUseCase;
  late final UpdateCategoryUseCase _updateCategoryUseCase;
  late final DeleteCategoryUseCase _deleteCategoryUseCase;
  late final GetCategoriesUseCase _getCategoriesUseCase;

  @override
  CategoryState build() {
    _addCategoryUseCase = ref.watch(addCategoryUseCaseProvider);
    _updateCategoryUseCase = ref.watch(updateCategoryUseCaseProvider);
    _deleteCategoryUseCase = ref.watch(deleteCategoryUseCaseProvider);
    _getCategoriesUseCase = ref.watch(getCategoriesUseCaseProvider);
    return const CategoryState();
  }

  void _invalidateCategoryQueries({String? changedType}) {
    ref.invalidate(categoriesProvider);
    if (changedType != null && changedType.isNotEmpty) {
      ref.invalidate(categoriesByTypeProvider(changedType));
      return;
    }
    ref.invalidate(categoriesByTypeProvider('expense'));
    ref.invalidate(categoriesByTypeProvider('income'));
  }

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
    required String type,
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
      _invalidateCategoryQueries(changedType: type);
      await loadCategories();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> updateCategory(CategoryEntity category) async {
    try {
      await _updateCategoryUseCase.call(category);
      _invalidateCategoryQueries(changedType: category.type);
      await loadCategories();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> deleteCategory(String id) async {
    try {
      await _deleteCategoryUseCase.call(id);
      _invalidateCategoryQueries();
      await loadCategories();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}
