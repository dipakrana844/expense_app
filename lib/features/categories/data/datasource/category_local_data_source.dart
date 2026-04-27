import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_expense_tracker/features/categories/data/adapters/category_model_adapter.dart';
import '../models/category_model.dart';
import '../../domain/enums/category_type.dart';
import '../../domain/failures/category_failure.dart';
import '../../domain/validators/category_validator.dart';

/// Local data source for categories using Hive.
/// Provides CRUD operations with proper error handling and validation.
class CategoryLocalDataSource {
  static const String boxName = 'categories_box';
  static const int typeId = 14;
  static const int currentSchemaVersion = 1;

  late Box<CategoryModel> _categoryBox;
  bool _isInitialized = false;

  /// Index for fast lookups by type
  final Map<CategoryType, List<String>> _typeIndex = {};

  /// Index for fast duplicate checking
  final Map<String, String> _nameIndex = {}; // normalized name -> id

  /// Initializes the data source and registers adapters
  Future<void> init() async {
    if (_isInitialized) return;

    try {
      await Hive.initFlutter();

      // Register adapter if not already registered
      if (!Hive.isAdapterRegistered(typeId)) {
        Hive.registerAdapter(CategoryModelAdapter());
      }

      _categoryBox = await Hive.openBox<CategoryModel>(boxName);

      // Build indexes for faster queries
      _buildIndexes();

      _isInitialized = true;
      debugPrint('CategoryLocalDataSource initialized successfully');
    } catch (e) {
      debugPrint('Failed to initialize Categories Hive box: $e');
      rethrow;
    }
  }

  /// Builds in-memory indexes for faster queries
  void _buildIndexes() {
    _typeIndex.clear();
    _nameIndex.clear();

    for (final category in _categoryBox.values) {
      if (category.isDeleted) continue;

      final type = CategoryType.fromString(category.type);
      _typeIndex.putIfAbsent(type, () => []).add(category.id);

      final normalizedName = CategoryValidator.normalizeName(category.name);
      _nameIndex[normalizedName] = category.id;
    }
  }

  /// Updates indexes after a category change
  void _updateIndexes(CategoryModel category) {
    if (category.isDeleted) {
      // Remove from indexes
      final type = CategoryType.fromString(category.type);
      _typeIndex[type]?.remove(category.id);
      final normalizedName = CategoryValidator.normalizeName(category.name);
      _nameIndex.remove(normalizedName);
    } else {
      // Add to indexes
      final type = CategoryType.fromString(category.type);
      _typeIndex.putIfAbsent(type, () => []).add(category.id);
      final normalizedName = CategoryValidator.normalizeName(category.name);
      _nameIndex[normalizedName] = category.id;
    }
  }

  void _ensureInitialized() {
    if (!_isInitialized) {
      throw const StorageFailure(
        message: 'CategoryLocalDataSource not initialized. Call init() first.',
      );
    }
  }

  /// Gets all categories (excluding soft-deleted ones)
  /// Returns empty list if no categories exist
  List<CategoryModel> getAllCategories() {
    _ensureInitialized();
    return _categoryBox.values
        .where((category) => !category.isDeleted)
        .toList();
  }

  /// Gets categories by type using index for O(1) lookup
  List<CategoryModel> getCategoriesByType(CategoryType type) {
    _ensureInitialized();
    final ids = _typeIndex[type] ?? [];
    return ids
        .map((id) => _categoryBox.get(id))
        .whereType<CategoryModel>()
        .toList();
  }

  /// Gets category by ID
  CategoryModel? getCategoryById(String id) {
    _ensureInitialized();
    return _categoryBox.get(id);
  }

  /// Checks if a category with the given name and type exists
  /// Uses index for O(1) lookup
  bool categoryExists(String name, CategoryType type) {
    _ensureInitialized();
    final normalizedName = CategoryValidator.normalizeName(name);
    final existingId = _nameIndex[normalizedName];

    if (existingId == null) return false;

    final existingCategory = _categoryBox.get(existingId);
    if (existingCategory == null || existingCategory.isDeleted) return false;

    return CategoryType.fromString(existingCategory.type) == type;
  }

  /// Adds a new category
  Future<void> addCategory(CategoryModel category) async {
    _ensureInitialized();

    // Validate category
    final validationResult = CategoryValidator.validateCategory(
      id: category.id,
      name: category.name,
      type: category.type,
      iconCodePoint: category.iconCodePoint,
      colorValue: category.colorValue,
    );

    if (validationResult.isFailure) {
      throw validationResult.failure!;
    }

    // Check for duplicates
    final type = CategoryType.fromString(category.type);
    if (categoryExists(category.name, type)) {
      throw DuplicateFailure(categoryName: category.name, type: type);
    }

    await _categoryBox.put(category.id, category);
    _updateIndexes(category);
  }

  /// Updates an existing category
  Future<void> updateCategory(CategoryModel category) async {
    _ensureInitialized();

    // Validate category
    final validationResult = CategoryValidator.validateCategory(
      id: category.id,
      name: category.name,
      type: category.type,
      iconCodePoint: category.iconCodePoint,
      colorValue: category.colorValue,
    );

    if (validationResult.isFailure) {
      throw validationResult.failure!;
    }

    // Check if category exists
    final existing = _categoryBox.get(category.id);
    if (existing == null) {
      throw NotFoundFailure(category.id);
    }

    // Check for duplicates (excluding current category)
    final type = CategoryType.fromString(category.type);
    final normalizedName = CategoryValidator.normalizeName(category.name);
    final existingId = _nameIndex[normalizedName];

    if (existingId != null && existingId != category.id) {
      throw DuplicateFailure(categoryName: category.name, type: type);
    }

    await _categoryBox.put(category.id, category);
    _updateIndexes(category);
  }

  /// Soft deletes a category
  Future<void> deleteCategory(String id) async {
    _ensureInitialized();

    final category = _categoryBox.get(id);
    if (category == null) {
      throw NotFoundFailure(id);
    }

    final updatedCategory = category.withSoftDelete();
    await _categoryBox.put(id, updatedCategory);
    _updateIndexes(updatedCategory);
  }

  /// Restores a soft-deleted category
  Future<void> restoreCategory(String id) async {
    _ensureInitialized();

    final category = _categoryBox.get(id);
    if (category == null) {
      throw NotFoundFailure(id);
    }

    final updatedCategory = category.withRestore();
    await _categoryBox.put(id, updatedCategory);
    _updateIndexes(updatedCategory);
  }

  /// Hard deletes a category (for cleanup purposes)
  Future<void> hardDeleteCategory(String id) async {
    _ensureInitialized();

    final category = _categoryBox.get(id);
    if (category != null) {
      _updateIndexes(category); // Will remove from indexes
    }

    await _categoryBox.delete(id);
  }

  /// Gets paginated categories
  List<CategoryModel> getPaginatedCategories({
    required int page,
    required int pageSize,
    CategoryType? type,
  }) {
    _ensureInitialized();

    List<CategoryModel> categories;
    if (type != null) {
      categories = getCategoriesByType(type);
    } else {
      categories = getAllCategories();
    }

    final startIndex = page * pageSize;
    final endIndex = startIndex + pageSize;

    if (startIndex >= categories.length) {
      return [];
    }

    return categories.sublist(
      startIndex,
      endIndex > categories.length ? categories.length : endIndex,
    );
  }

  /// Searches categories by name
  List<CategoryModel> searchCategories(String query) {
    _ensureInitialized();

    final normalizedQuery = CategoryValidator.normalizeName(query);

    return _categoryBox.values
        .where(
          (category) =>
              !category.isDeleted &&
              CategoryValidator.normalizeName(
                category.name,
              ).contains(normalizedQuery),
        )
        .toList();
  }

  /// Gets the total count of active categories
  int getActiveCategoryCount() {
    _ensureInitialized();
    return _categoryBox.values.where((c) => !c.isDeleted).length;
  }

  /// Gets the count of active categories by type
  int getActiveCategoryCountByType(CategoryType type) {
    _ensureInitialized();
    return _typeIndex[type]?.length ?? 0;
  }

  /// Clears all categories (for testing purposes)
  Future<void> clearAll() async {
    _ensureInitialized();
    await _categoryBox.clear();
    _buildIndexes();
  }

  /// Gets the current schema version
  int get schemaVersion => currentSchemaVersion;
}
