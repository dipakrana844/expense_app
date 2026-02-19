import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/category_model.dart';

class CategoryLocalDataSource {
  static const String boxName = 'categories_box';
  late Box<CategoryModel> _categoryBox;
  bool _isInitialized = false;

  Future<void> init() async {
    if (_isInitialized) return;

    try {
      await Hive.initFlutter();

      // Register adapter if not already registered
      if (!Hive.isAdapterRegistered(14)) {
        Hive.registerAdapter(CategoryModelAdapter());
      }

      _categoryBox = await Hive.openBox<CategoryModel>(boxName);
      _isInitialized = true;
    } catch (e) {
      debugPrint('Failed to initialize Categories Hive box: $e');
      rethrow;
    }
  }

  void _ensureInitialized() {
    if (!_isInitialized) {
      throw Exception('CategoryLocalDataSource not initialized. Call init() first.');
    }
  }

  // Get all categories (excluding soft-deleted ones)
  List<CategoryModel> getAllCategories() {
    _ensureInitialized();
    return _categoryBox.values.where((category) => !category.isDeleted).toList();
  }

  // Get categories by type
  List<CategoryModel> getCategoriesByType(String type) {
    _ensureInitialized();
    return _categoryBox.values
        .where((category) => category.type.toLowerCase() == type.toLowerCase() && !category.isDeleted)
        .toList();
  }

  // Get category by ID
  CategoryModel? getCategoryById(String id) {
    _ensureInitialized();
    return _categoryBox.get(id);
  }

  // Add category
  Future<void> addCategory(CategoryModel category) async {
    _ensureInitialized();
    await _categoryBox.put(category.id, category);
  }

  // Update category
  Future<void> updateCategory(CategoryModel category) async {
    _ensureInitialized();
    await _categoryBox.put(category.id, category);
  }

  // Soft delete category
  Future<void> deleteCategory(String id) async {
    _ensureInitialized();
    final category = _categoryBox.get(id);
    if (category != null) {
      final updatedCategory = category.copyWith(isDeleted: true);
      await _categoryBox.put(id, updatedCategory);
    }
  }

  // Hard delete category (for cleanup purposes)
  Future<void> hardDeleteCategory(String id) async {
    _ensureInitialized();
    await _categoryBox.delete(id);
  }
}
