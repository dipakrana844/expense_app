import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_expense_tracker/features/categories/data/datasource/category_local_data_source.dart';
import 'package:smart_expense_tracker/features/categories/data/models/category_model.dart';
import 'package:smart_expense_tracker/features/categories/domain/enums/category_type.dart';
import 'package:smart_expense_tracker/features/categories/domain/failures/category_failure.dart';

void main() {
  group('CategoryLocalDataSource', () {
    late CategoryLocalDataSource dataSource;

    setUp(() async {
      // Initialize Hive for testing
      await Hive.initFlutter();
      Hive.registerAdapter(CategoryModelAdapter());

      // Create a new instance for each test
      dataSource = CategoryLocalDataSource();
      await dataSource.init();

      // Clear any existing data
      await dataSource.clearAll();
    });

    tearDown(() async {
      // Clean up after each test
      await dataSource.clearAll();
    });

    group('init', () {
      test('should initialize successfully', () async {
        final newDataSource = CategoryLocalDataSource();
        expect(() => newDataSource.init(), returnsNormally);
      });

      test('should not initialize twice', () async {
        await dataSource.init();
        expect(() => dataSource.init(), returnsNormally);
      });
    });

    group('addCategory', () {
      test('should add category successfully', () async {
        final category = CategoryModel(
          id: '550e8400-e29b-41d4-a716-446655440000',
          name: 'Food',
          type: 'expense',
          iconCodePoint: 0xe5cc,
          colorValue: 0xFF2196F3,
          createdAt: DateTime.now(),
        );

        await dataSource.addCategory(category);

        final retrieved = dataSource.getCategoryById(category.id);
        expect(retrieved, isNotNull);
        expect(retrieved!.id, category.id);
        expect(retrieved.name, category.name);
      });

      test('should throw DuplicateFailure for duplicate category', () async {
        final category = CategoryModel(
          id: '550e8400-e29b-41d4-a716-446655440000',
          name: 'Food',
          type: 'expense',
          iconCodePoint: 0xe5cc,
          colorValue: 0xFF2196F3,
          createdAt: DateTime.now(),
        );

        await dataSource.addCategory(category);

        final duplicate = CategoryModel(
          id: '660e8400-e29b-41d4-a716-446655440001',
          name: 'Food',
          type: 'expense',
          iconCodePoint: 0xe5cc,
          colorValue: 0xFF2196F3,
          createdAt: DateTime.now(),
        );

        expect(
          () => dataSource.addCategory(duplicate),
          throwsA(isA<DuplicateFailure>()),
        );
      });

      test('should throw ValidationFailure for invalid category', () async {
        final invalidCategory = CategoryModel(
          id: 'invalid-id',
          name: '',
          type: 'invalid',
          iconCodePoint: -1,
          colorValue: -1,
          createdAt: DateTime.now(),
        );

        expect(
          () => dataSource.addCategory(invalidCategory),
          throwsA(isA<ValidationFailure>()),
        );
      });
    });

    group('getCategoryById', () {
      test('should return category when exists', () async {
        final category = CategoryModel(
          id: '550e8400-e29b-41d4-a716-446655440000',
          name: 'Food',
          type: 'expense',
          iconCodePoint: 0xe5cc,
          colorValue: 0xFF2196F3,
          createdAt: DateTime.now(),
        );

        await dataSource.addCategory(category);

        final retrieved = dataSource.getCategoryById(category.id);
        expect(retrieved, isNotNull);
        expect(retrieved!.id, category.id);
      });

      test('should return null when not exists', () {
        final retrieved = dataSource.getCategoryById('non-existent-id');
        expect(retrieved, isNull);
      });
    });

    group('getAllCategories', () {
      test('should return all non-deleted categories', () async {
        final category1 = CategoryModel(
          id: '550e8400-e29b-41d4-a716-446655440000',
          name: 'Food',
          type: 'expense',
          iconCodePoint: 0xe5cc,
          colorValue: 0xFF2196F3,
          createdAt: DateTime.now(),
        );

        final category2 = CategoryModel(
          id: '660e8400-e29b-41d4-a716-446655440001',
          name: 'Transport',
          type: 'expense',
          iconCodePoint: 0xe5cc,
          colorValue: 0xFF2196F3,
          createdAt: DateTime.now(),
          isDeleted: true,
        );

        await dataSource.addCategory(category1);
        await dataSource.addCategory(category2);

        final categories = dataSource.getAllCategories();
        expect(categories.length, 1);
        expect(categories.first.id, category1.id);
      });

      test('should return empty list when no categories', () {
        final categories = dataSource.getAllCategories();
        expect(categories, isEmpty);
      });
    });

    group('getCategoriesByType', () {
      test('should return categories of specified type', () async {
        final expenseCategory = CategoryModel(
          id: '550e8400-e29b-41d4-a716-446655440000',
          name: 'Food',
          type: 'expense',
          iconCodePoint: 0xe5cc,
          colorValue: 0xFF2196F3,
          createdAt: DateTime.now(),
        );

        final incomeCategory = CategoryModel(
          id: '660e8400-e29b-41d4-a716-446655440001',
          name: 'Salary',
          type: 'income',
          iconCodePoint: 0xe5cc,
          colorValue: 0xFF4CAF50,
          createdAt: DateTime.now(),
        );

        await dataSource.addCategory(expenseCategory);
        await dataSource.addCategory(incomeCategory);

        final expenseCategories = dataSource.getCategoriesByType(
          CategoryType.expense,
        );
        expect(expenseCategories.length, 1);
        expect(expenseCategories.first.id, expenseCategory.id);

        final incomeCategories = dataSource.getCategoriesByType(
          CategoryType.income,
        );
        expect(incomeCategories.length, 1);
        expect(incomeCategories.first.id, incomeCategory.id);
      });

      test('should return empty list for type with no categories', () {
        final categories = dataSource.getCategoriesByType(CategoryType.expense);
        expect(categories, isEmpty);
      });
    });

    group('updateCategory', () {
      test('should update category successfully', () async {
        final category = CategoryModel(
          id: '550e8400-e29b-41d4-a716-446655440000',
          name: 'Food',
          type: 'expense',
          iconCodePoint: 0xe5cc,
          colorValue: 0xFF2196F3,
          createdAt: DateTime.now(),
        );

        await dataSource.addCategory(category);

        final updated = category.copyWith(name: 'Updated Food');
        await dataSource.updateCategory(updated);

        final retrieved = dataSource.getCategoryById(category.id);
        expect(retrieved!.name, 'Updated Food');
      });

      test('should throw NotFoundFailure for non-existent category', () async {
        final category = CategoryModel(
          id: '550e8400-e29b-41d4-a716-446655440000',
          name: 'Food',
          type: 'expense',
          iconCodePoint: 0xe5cc,
          colorValue: 0xFF2196F3,
          createdAt: DateTime.now(),
        );

        expect(
          () => dataSource.updateCategory(category),
          throwsA(isA<NotFoundFailure>()),
        );
      });

      test('should throw DuplicateFailure for duplicate name', () async {
        final category1 = CategoryModel(
          id: '550e8400-e29b-41d4-a716-446655440000',
          name: 'Food',
          type: 'expense',
          iconCodePoint: 0xe5cc,
          colorValue: 0xFF2196F3,
          createdAt: DateTime.now(),
        );

        final category2 = CategoryModel(
          id: '660e8400-e29b-41d4-a716-446655440001',
          name: 'Transport',
          type: 'expense',
          iconCodePoint: 0xe5cc,
          colorValue: 0xFF2196F3,
          createdAt: DateTime.now(),
        );

        await dataSource.addCategory(category1);
        await dataSource.addCategory(category2);

        final updated = category2.copyWith(name: 'Food');
        expect(
          () => dataSource.updateCategory(updated),
          throwsA(isA<DuplicateFailure>()),
        );
      });
    });

    group('deleteCategory', () {
      test('should soft delete category', () async {
        final category = CategoryModel(
          id: '550e8400-e29b-41d4-a716-446655440000',
          name: 'Food',
          type: 'expense',
          iconCodePoint: 0xe5cc,
          colorValue: 0xFF2196F3,
          createdAt: DateTime.now(),
        );

        await dataSource.addCategory(category);
        await dataSource.deleteCategory(category.id);

        final retrieved = dataSource.getCategoryById(category.id);
        expect(retrieved, isNotNull);
        expect(retrieved!.isDeleted, true);

        final allCategories = dataSource.getAllCategories();
        expect(allCategories, isEmpty);
      });

      test('should throw NotFoundFailure for non-existent category', () {
        expect(
          () => dataSource.deleteCategory('non-existent-id'),
          throwsA(isA<NotFoundFailure>()),
        );
      });
    });

    group('restoreCategory', () {
      test('should restore soft-deleted category', () async {
        final category = CategoryModel(
          id: '550e8400-e29b-41d4-a716-446655440000',
          name: 'Food',
          type: 'expense',
          iconCodePoint: 0xe5cc,
          colorValue: 0xFF2196F3,
          createdAt: DateTime.now(),
          isDeleted: true,
        );

        await dataSource.addCategory(category);
        await dataSource.restoreCategory(category.id);

        final retrieved = dataSource.getCategoryById(category.id);
        expect(retrieved!.isDeleted, false);

        final allCategories = dataSource.getAllCategories();
        expect(allCategories.length, 1);
      });

      test('should throw NotFoundFailure for non-existent category', () {
        expect(
          () => dataSource.restoreCategory('non-existent-id'),
          throwsA(isA<NotFoundFailure>()),
        );
      });
    });

    group('hardDeleteCategory', () {
      test('should permanently delete category', () async {
        final category = CategoryModel(
          id: '550e8400-e29b-41d4-a716-446655440000',
          name: 'Food',
          type: 'expense',
          iconCodePoint: 0xe5cc,
          colorValue: 0xFF2196F3,
          createdAt: DateTime.now(),
        );

        await dataSource.addCategory(category);
        await dataSource.hardDeleteCategory(category.id);

        final retrieved = dataSource.getCategoryById(category.id);
        expect(retrieved, isNull);
      });
    });

    group('searchCategories', () {
      test('should find categories by name', () async {
        final category1 = CategoryModel(
          id: '550e8400-e29b-41d4-a716-446655440000',
          name: 'Food',
          type: 'expense',
          iconCodePoint: 0xe5cc,
          colorValue: 0xFF2196F3,
          createdAt: DateTime.now(),
        );

        final category2 = CategoryModel(
          id: '660e8400-e29b-41d4-a716-446655440001',
          name: 'Transport',
          type: 'expense',
          iconCodePoint: 0xe5cc,
          colorValue: 0xFF2196F3,
          createdAt: DateTime.now(),
        );

        await dataSource.addCategory(category1);
        await dataSource.addCategory(category2);

        final results = dataSource.searchCategories('food');
        expect(results.length, 1);
        expect(results.first.id, category1.id);
      });

      test('should be case-insensitive', () async {
        final category = CategoryModel(
          id: '550e8400-e29b-41d4-a716-446655440000',
          name: 'Food',
          type: 'expense',
          iconCodePoint: 0xe5cc,
          colorValue: 0xFF2196F3,
          createdAt: DateTime.now(),
        );

        await dataSource.addCategory(category);

        final results = dataSource.searchCategories('FOOD');
        expect(results.length, 1);
      });

      test('should return empty list for no matches', () async {
        final category = CategoryModel(
          id: '550e8400-e29b-41d4-a716-446655440000',
          name: 'Food',
          type: 'expense',
          iconCodePoint: 0xe5cc,
          colorValue: 0xFF2196F3,
          createdAt: DateTime.now(),
        );

        await dataSource.addCategory(category);

        final results = dataSource.searchCategories('xyz');
        expect(results, isEmpty);
      });
    });

    group('getPaginatedCategories', () {
      test('should return paginated results', () async {
        for (var i = 0; i < 25; i++) {
          final category = CategoryModel(
            id: '550e8400-e29b-41d4-a716-44665544${i.toString().padLeft(4, '0')}',
            name: 'Category $i',
            type: 'expense',
            iconCodePoint: 0xe5cc,
            colorValue: 0xFF2196F3,
            createdAt: DateTime.now(),
          );
          await dataSource.addCategory(category);
        }

        final page1 = dataSource.getPaginatedCategories(page: 0, pageSize: 10);
        expect(page1.length, 10);

        final page2 = dataSource.getPaginatedCategories(page: 1, pageSize: 10);
        expect(page2.length, 10);

        final page3 = dataSource.getPaginatedCategories(page: 2, pageSize: 10);
        expect(page3.length, 5);
      });

      test('should return empty list for out of range page', () async {
        final category = CategoryModel(
          id: '550e8400-e29b-41d4-a716-446655440000',
          name: 'Food',
          type: 'expense',
          iconCodePoint: 0xe5cc,
          colorValue: 0xFF2196F3,
          createdAt: DateTime.now(),
        );

        await dataSource.addCategory(category);

        final results = dataSource.getPaginatedCategories(
          page: 10,
          pageSize: 10,
        );
        expect(results, isEmpty);
      });
    });

    group('getActiveCategoryCount', () {
      test('should return count of non-deleted categories', () async {
        final category1 = CategoryModel(
          id: '550e8400-e29b-41d4-a716-446655440000',
          name: 'Food',
          type: 'expense',
          iconCodePoint: 0xe5cc,
          colorValue: 0xFF2196F3,
          createdAt: DateTime.now(),
        );

        final category2 = CategoryModel(
          id: '660e8400-e29b-41d4-a716-446655440001',
          name: 'Transport',
          type: 'expense',
          iconCodePoint: 0xe5cc,
          colorValue: 0xFF2196F3,
          createdAt: DateTime.now(),
          isDeleted: true,
        );

        await dataSource.addCategory(category1);
        await dataSource.addCategory(category2);

        final count = dataSource.getActiveCategoryCount();
        expect(count, 1);
      });

      test('should return 0 when no categories', () {
        final count = dataSource.getActiveCategoryCount();
        expect(count, 0);
      });
    });

    group('getActiveCategoryCountByType', () {
      test('should return count of non-deleted categories by type', () async {
        final expenseCategory = CategoryModel(
          id: '550e8400-e29b-41d4-a716-446655440000',
          name: 'Food',
          type: 'expense',
          iconCodePoint: 0xe5cc,
          colorValue: 0xFF2196F3,
          createdAt: DateTime.now(),
        );

        final incomeCategory = CategoryModel(
          id: '660e8400-e29b-41d4-a716-446655440001',
          name: 'Salary',
          type: 'income',
          iconCodePoint: 0xe5cc,
          colorValue: 0xFF4CAF50,
          createdAt: DateTime.now(),
        );

        await dataSource.addCategory(expenseCategory);
        await dataSource.addCategory(incomeCategory);

        final expenseCount = dataSource.getActiveCategoryCountByType(
          CategoryType.expense,
        );
        expect(expenseCount, 1);

        final incomeCount = dataSource.getActiveCategoryCountByType(
          CategoryType.income,
        );
        expect(incomeCount, 1);
      });

      test('should return 0 for type with no categories', () {
        final count = dataSource.getActiveCategoryCountByType(
          CategoryType.expense,
        );
        expect(count, 0);
      });
    });

    group('categoryExists', () {
      test('should return true when category exists', () async {
        final category = CategoryModel(
          id: '550e8400-e29b-41d4-a716-446655440000',
          name: 'Food',
          type: 'expense',
          iconCodePoint: 0xe5cc,
          colorValue: 0xFF2196F3,
          createdAt: DateTime.now(),
        );

        await dataSource.addCategory(category);

        final exists = dataSource.categoryExists('Food', CategoryType.expense);
        expect(exists, true);
      });

      test('should return false when category does not exist', () {
        final exists = dataSource.categoryExists('Food', CategoryType.expense);
        expect(exists, false);
      });

      test('should be case-insensitive', () async {
        final category = CategoryModel(
          id: '550e8400-e29b-41d4-a716-446655440000',
          name: 'Food',
          type: 'expense',
          iconCodePoint: 0xe5cc,
          colorValue: 0xFF2196F3,
          createdAt: DateTime.now(),
        );

        await dataSource.addCategory(category);

        final exists = dataSource.categoryExists('FOOD', CategoryType.expense);
        expect(exists, true);
      });

      test('should not match different types', () async {
        final category = CategoryModel(
          id: '550e8400-e29b-41d4-a716-446655440000',
          name: 'Food',
          type: 'expense',
          iconCodePoint: 0xe5cc,
          colorValue: 0xFF2196F3,
          createdAt: DateTime.now(),
        );

        await dataSource.addCategory(category);

        final exists = dataSource.categoryExists('Food', CategoryType.income);
        expect(exists, false);
      });
    });
  });
}
