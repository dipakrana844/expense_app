import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../domain/usecases/get_categories_usecase.dart';
import '../../domain/usecases/add_category_usecase.dart';
import '../../domain/usecases/update_category_usecase.dart';
import '../../domain/usecases/delete_category_usecase.dart';
import '../../domain/usecases/restore_category_usecase.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/enums/category_type.dart';
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

final restoreCategoryUseCaseProvider = Provider<RestoreCategoryUseCase>((ref) {
  final repository = ref.watch(categoryRepositoryProvider);
  return RestoreCategoryUseCase(repository);
});

// ---------------------------------------------------------------------------
// Read-only async providers
// ---------------------------------------------------------------------------

/// Provides all categories. Not autoDispose so the controller stays alive.
final categoriesProvider = FutureProvider<List<CategoryEntity>>((ref) async {
  final useCase = ref.watch(getCategoriesUseCaseProvider);
  final result = await useCase.call();
  return result.fold(
    onSuccess: (data) => data,
    onFailure: (failure) => throw Exception(failure.message),
  );
});

/// Provides categories filtered by type ('income' | 'expense').
final categoriesByTypeProvider =
    FutureProvider.family<List<CategoryEntity>, CategoryType>((
      ref,
      type,
    ) async {
      final useCase = ref.watch(getCategoriesUseCaseProvider);
      final result = await useCase.call(type: type);
      return result.fold(
        onSuccess: (data) => data,
        onFailure: (failure) => throw Exception(failure.message),
      );
    });

// ---------------------------------------------------------------------------
// CategoryState
// ---------------------------------------------------------------------------

class CategoryState {
  final List<CategoryEntity> categories;
  final bool isLoading;
  final String? error;
  final int currentPage;
  final int pageSize;
  final bool hasMore;

  const CategoryState({
    this.categories = const [],
    this.isLoading = false,
    this.error,
    this.currentPage = 0,
    this.pageSize = 20,
    this.hasMore = true,
  });

  CategoryState copyWith({
    List<CategoryEntity>? categories,
    bool? isLoading,
    String? error,
    int? currentPage,
    int? pageSize,
    bool? hasMore,
  }) {
    return CategoryState(
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      currentPage: currentPage ?? this.currentPage,
      pageSize: pageSize ?? this.pageSize,
      hasMore: hasMore ?? this.hasMore,
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
  late final RestoreCategoryUseCase _restoreCategoryUseCase;
  late final GetCategoriesUseCase _getCategoriesUseCase;

  @override
  CategoryState build() {
    _addCategoryUseCase = ref.watch(addCategoryUseCaseProvider);
    _updateCategoryUseCase = ref.watch(updateCategoryUseCaseProvider);
    _deleteCategoryUseCase = ref.watch(deleteCategoryUseCaseProvider);
    _restoreCategoryUseCase = ref.watch(restoreCategoryUseCaseProvider);
    _getCategoriesUseCase = ref.watch(getCategoriesUseCaseProvider);
    return const CategoryState();
  }

  void _invalidateCategoryQueries({CategoryType? changedType}) {
    ref.invalidate(categoriesProvider);
    if (changedType != null) {
      ref.invalidate(categoriesByTypeProvider(changedType));
      return;
    }
    ref.invalidate(categoriesByTypeProvider(CategoryType.expense));
    ref.invalidate(categoriesByTypeProvider(CategoryType.income));
  }

  /// Loads categories, optionally filtered by type
  Future<void> loadCategories({CategoryType? type}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _getCategoriesUseCase.call(type: type);
      result.fold(
        onSuccess: (categories) {
          state = state.copyWith(
            categories: categories,
            isLoading: false,
            hasMore: categories.length >= state.pageSize,
          );
        },
        onFailure: (failure) {
          state = state.copyWith(error: failure.message, isLoading: false);
        },
      );
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  /// Loads paginated categories
  Future<void> loadPaginatedCategories({CategoryType? type}) async {
    if (state.isLoading || !state.hasMore) return;

    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _getCategoriesUseCase.getPaginated(
        page: state.currentPage,
        pageSize: state.pageSize,
        type: type,
      );
      result.fold(
        onSuccess: (newCategories) {
          final allCategories = [...state.categories, ...newCategories];
          state = state.copyWith(
            categories: allCategories,
            isLoading: false,
            currentPage: state.currentPage + 1,
            hasMore: newCategories.length >= state.pageSize,
          );
        },
        onFailure: (failure) {
          state = state.copyWith(error: failure.message, isLoading: false);
        },
      );
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  /// Searches categories by name
  Future<void> searchCategories(String query) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _getCategoriesUseCase.search(query);
      result.fold(
        onSuccess: (categories) {
          state = state.copyWith(
            categories: categories,
            isLoading: false,
            hasMore: false,
          );
        },
        onFailure: (failure) {
          state = state.copyWith(error: failure.message, isLoading: false);
        },
      );
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  /// Adds a new category
  Future<void> addCategory({
    required String name,
    required CategoryType type,
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
      final result = await _addCategoryUseCase.call(newCategory);
      result.fold(
        onSuccess: (_) {
          _invalidateCategoryQueries(changedType: type);
          loadCategories(type: type);
        },
        onFailure: (failure) {
          state = state.copyWith(error: failure.message);
        },
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Updates an existing category
  Future<void> updateCategory(CategoryEntity category) async {
    try {
      final result = await _updateCategoryUseCase.call(category);
      result.fold(
        onSuccess: (_) {
          _invalidateCategoryQueries(changedType: category.type);
          loadCategories(type: category.type);
        },
        onFailure: (failure) {
          state = state.copyWith(error: failure.message);
        },
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Deletes a category (soft delete)
  Future<void> deleteCategory(String id) async {
    try {
      final result = await _deleteCategoryUseCase.call(id);
      result.fold(
        onSuccess: (_) {
          _invalidateCategoryQueries();
          loadCategories();
        },
        onFailure: (failure) {
          state = state.copyWith(error: failure.message);
        },
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Restores a soft-deleted category
  Future<void> restoreCategory(String id) async {
    try {
      final result = await _restoreCategoryUseCase.call(id);
      result.fold(
        onSuccess: (_) {
          _invalidateCategoryQueries();
          loadCategories();
        },
        onFailure: (failure) {
          state = state.copyWith(error: failure.message);
        },
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Clears the error state
  void clearError() {
    state = state.copyWith(error: null);
  }

  /// Resets the state to initial values
  void reset() {
    state = const CategoryState();
  }
}
