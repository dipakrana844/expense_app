import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_expense_tracker/features/categories/data/adapters/category_model_adapter.dart';
import 'package:smart_expense_tracker/features/categories/data/models/category_model.dart';
import 'package:smart_expense_tracker/features/categories/domain/entities/category_entity.dart';
import 'package:smart_expense_tracker/features/categories/domain/enums/category_type.dart';

void main() {
  group('CategoryModel', () {
    setUpAll(() async {
      // Initialize Hive for testing
      await Hive.initFlutter();
      Hive.registerAdapter(CategoryModelAdapter());
    });

    group('fromEntity', () {
      test('should convert entity to model correctly', () {
        final entity = CategoryEntity(
          id: '550e8400-e29b-41d4-a716-446655440000',
          name: 'Food',
          type: CategoryType.expense,
          iconCodePoint: 0xe5cc,
          colorValue: 0xFF2196F3,
          createdAt: DateTime(2024, 1, 1),
          updatedAt: DateTime(2024, 1, 2),
          isDeleted: false,
        );

        final model = CategoryModel.fromEntity(entity);

        expect(model.id, entity.id);
        expect(model.name, entity.name);
        expect(model.type, entity.type.toLowerCaseString());
        expect(model.iconCodePoint, entity.iconCodePoint);
        expect(model.colorValue, entity.colorValue);
        expect(model.createdAt, entity.createdAt);
        expect(model.updatedAt, entity.updatedAt);
        expect(model.isDeleted, entity.isDeleted);
      });

      test('should convert income entity to model', () {
        final entity = CategoryEntity(
          id: '550e8400-e29b-41d4-a716-446655440000',
          name: 'Salary',
          type: CategoryType.income,
          iconCodePoint: 0xe5cc,
          colorValue: 0xFF4CAF50,
          createdAt: DateTime(2024, 1, 1),
        );

        final model = CategoryModel.fromEntity(entity);

        expect(model.type, 'income');
      });
    });

    group('toEntity', () {
      test('should convert model to entity correctly', () {
        final model = CategoryModel(
          id: '550e8400-e29b-41d4-a716-446655440000',
          name: 'Food',
          type: 'expense',
          iconCodePoint: 0xe5cc,
          colorValue: 0xFF2196F3,
          createdAt: DateTime(2024, 1, 1),
          updatedAt: DateTime(2024, 1, 2),
          isDeleted: false,
        );

        final entity = model.toEntity();

        expect(entity.id, model.id);
        expect(entity.name, model.name);
        expect(entity.type, CategoryType.expense);
        expect(entity.iconCodePoint, model.iconCodePoint);
        expect(entity.colorValue, model.colorValue);
        expect(entity.createdAt, model.createdAt);
        expect(entity.updatedAt, model.updatedAt);
        expect(entity.isDeleted, model.isDeleted);
      });

      test('should convert income model to entity', () {
        final model = CategoryModel(
          id: '550e8400-e29b-41d4-a716-446655440000',
          name: 'Salary',
          type: 'income',
          iconCodePoint: 0xe5cc,
          colorValue: 0xFF4CAF50,
          createdAt: DateTime(2024, 1, 1),
        );

        final entity = model.toEntity();

        expect(entity.type, CategoryType.income);
      });
    });

    group('withUpdatedTimestamp', () {
      test('should update updatedAt timestamp', () {
        final model = CategoryModel(
          id: '550e8400-e29b-41d4-a716-446655440000',
          name: 'Food',
          type: 'expense',
          iconCodePoint: 0xe5cc,
          colorValue: 0xFF2196F3,
          createdAt: DateTime(2024, 1, 1),
        );

        final before = DateTime.now();
        final updated = model.withUpdatedTimestamp();
        final after = DateTime.now();

        expect(updated.updatedAt, isNotNull);
        expect(
          updated.updatedAt!.isAfter(before) ||
              updated.updatedAt!.isAtSameMomentAs(before),
          true,
        );
        expect(
          updated.updatedAt!.isBefore(after) ||
              updated.updatedAt!.isAtSameMomentAs(after),
          true,
        );
      });

      test('should preserve other fields', () {
        final model = CategoryModel(
          id: '550e8400-e29b-41d4-a716-446655440000',
          name: 'Food',
          type: 'expense',
          iconCodePoint: 0xe5cc,
          colorValue: 0xFF2196F3,
          createdAt: DateTime(2024, 1, 1),
        );

        final updated = model.withUpdatedTimestamp();

        expect(updated.id, model.id);
        expect(updated.name, model.name);
        expect(updated.type, model.type);
        expect(updated.iconCodePoint, model.iconCodePoint);
        expect(updated.colorValue, model.colorValue);
        expect(updated.createdAt, model.createdAt);
        expect(updated.isDeleted, model.isDeleted);
      });
    });

    group('withSoftDelete', () {
      test('should set isDeleted to true', () {
        final model = CategoryModel(
          id: '550e8400-e29b-41d4-a716-446655440000',
          name: 'Food',
          type: 'expense',
          iconCodePoint: 0xe5cc,
          colorValue: 0xFF2196F3,
          createdAt: DateTime(2024, 1, 1),
        );

        final deleted = model.withSoftDelete();

        expect(deleted.isDeleted, true);
      });

      test('should update updatedAt timestamp', () {
        final model = CategoryModel(
          id: '550e8400-e29b-41d4-a716-446655440000',
          name: 'Food',
          type: 'expense',
          iconCodePoint: 0xe5cc,
          colorValue: 0xFF2196F3,
          createdAt: DateTime(2024, 1, 1),
        );

        final deleted = model.withSoftDelete();

        expect(deleted.updatedAt, isNotNull);
      });
    });

    group('withRestore', () {
      test('should set isDeleted to false', () {
        final model = CategoryModel(
          id: '550e8400-e29b-41d4-a716-446655440000',
          name: 'Food',
          type: 'expense',
          iconCodePoint: 0xe5cc,
          colorValue: 0xFF2196F3,
          createdAt: DateTime(2024, 1, 1),
          isDeleted: true,
        );

        final restored = model.withRestore();

        expect(restored.isDeleted, false);
      });

      test('should update updatedAt timestamp', () {
        final model = CategoryModel(
          id: '550e8400-e29b-41d4-a716-446655440000',
          name: 'Food',
          type: 'expense',
          iconCodePoint: 0xe5cc,
          colorValue: 0xFF2196F3,
          createdAt: DateTime(2024, 1, 1),
          isDeleted: true,
        );

        final restored = model.withRestore();

        expect(restored.updatedAt, isNotNull);
      });
    });

    group('round-trip conversion', () {
      test('should preserve data through entity -> model -> entity', () {
        final originalEntity = CategoryEntity(
          id: '550e8400-e29b-41d4-a716-446655440000',
          name: 'Food',
          type: CategoryType.expense,
          iconCodePoint: 0xe5cc,
          colorValue: 0xFF2196F3,
          createdAt: DateTime(2024, 1, 1),
          updatedAt: DateTime(2024, 1, 2),
          isDeleted: false,
        );

        final model = CategoryModel.fromEntity(originalEntity);
        final restoredEntity = model.toEntity();

        expect(restoredEntity.id, originalEntity.id);
        expect(restoredEntity.name, originalEntity.name);
        expect(restoredEntity.type, originalEntity.type);
        expect(restoredEntity.iconCodePoint, originalEntity.iconCodePoint);
        expect(restoredEntity.colorValue, originalEntity.colorValue);
        expect(restoredEntity.createdAt, originalEntity.createdAt);
        expect(restoredEntity.updatedAt, originalEntity.updatedAt);
        expect(restoredEntity.isDeleted, originalEntity.isDeleted);
      });
    });
  });
}
