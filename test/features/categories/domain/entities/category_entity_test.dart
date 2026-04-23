import 'package:flutter_test/flutter_test.dart';
import 'package:smart_expense_tracker/features/categories/domain/entities/category_entity.dart';
import 'package:smart_expense_tracker/features/categories/domain/enums/category_type.dart';

void main() {
  group('CategoryEntity', () {
    final testCategory = CategoryEntity(
      id: '550e8400-e29b-41d4-a716-446655440000',
      name: 'Food',
      type: CategoryType.expense,
      iconCodePoint: 0xe5cc,
      colorValue: 0xFF2196F3,
      createdAt: DateTime(2024, 1, 1),
    );

    group('isIncome', () {
      test('should return true for income category', () {
        final incomeCategory = testCategory.copyWith(type: CategoryType.income);
        expect(incomeCategory.isIncome, true);
      });

      test('should return false for expense category', () {
        expect(testCategory.isIncome, false);
      });
    });

    group('isExpense', () {
      test('should return true for expense category', () {
        expect(testCategory.isExpense, true);
      });

      test('should return false for income category', () {
        final incomeCategory = testCategory.copyWith(type: CategoryType.income);
        expect(incomeCategory.isExpense, false);
      });
    });

    group('typeString', () {
      test('should return lowercase string for income', () {
        final incomeCategory = testCategory.copyWith(type: CategoryType.income);
        expect(incomeCategory.typeString, 'income');
      });

      test('should return lowercase string for expense', () {
        expect(testCategory.typeString, 'expense');
      });
    });

    group('typeDisplayName', () {
      test('should return "Income" for income category', () {
        final incomeCategory = testCategory.copyWith(type: CategoryType.income);
        expect(incomeCategory.typeDisplayName, 'Income');
      });

      test('should return "Expense" for expense category', () {
        expect(testCategory.typeDisplayName, 'Expense');
      });
    });

    group('withUpdatedTimestamp', () {
      test('should update updatedAt timestamp', () {
        final before = DateTime.now();
        final updated = testCategory.withUpdatedTimestamp();
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
        final updated = testCategory.withUpdatedTimestamp();
        expect(updated.id, testCategory.id);
        expect(updated.name, testCategory.name);
        expect(updated.type, testCategory.type);
        expect(updated.iconCodePoint, testCategory.iconCodePoint);
        expect(updated.colorValue, testCategory.colorValue);
        expect(updated.createdAt, testCategory.createdAt);
        expect(updated.isDeleted, testCategory.isDeleted);
      });
    });

    group('withSoftDelete', () {
      test('should set isDeleted to true', () {
        final deleted = testCategory.withSoftDelete();
        expect(deleted.isDeleted, true);
      });

      test('should update updatedAt timestamp', () {
        final deleted = testCategory.withSoftDelete();
        expect(deleted.updatedAt, isNotNull);
      });

      test('should preserve other fields', () {
        final deleted = testCategory.withSoftDelete();
        expect(deleted.id, testCategory.id);
        expect(deleted.name, testCategory.name);
        expect(deleted.type, testCategory.type);
        expect(deleted.iconCodePoint, testCategory.iconCodePoint);
        expect(deleted.colorValue, testCategory.colorValue);
        expect(deleted.createdAt, testCategory.createdAt);
      });
    });

    group('withRestore', () {
      test('should set isDeleted to false', () {
        final deleted = testCategory.copyWith(isDeleted: true);
        final restored = deleted.withRestore();
        expect(restored.isDeleted, false);
      });

      test('should update updatedAt timestamp', () {
        final deleted = testCategory.copyWith(isDeleted: true);
        final restored = deleted.withRestore();
        expect(restored.updatedAt, isNotNull);
      });

      test('should preserve other fields', () {
        final deleted = testCategory.copyWith(isDeleted: true);
        final restored = deleted.withRestore();
        expect(restored.id, deleted.id);
        expect(restored.name, deleted.name);
        expect(restored.type, deleted.type);
        expect(restored.iconCodePoint, deleted.iconCodePoint);
        expect(restored.colorValue, deleted.colorValue);
        expect(restored.createdAt, deleted.createdAt);
      });
    });

    group('copyWith', () {
      test('should create copy with updated name', () {
        final updated = testCategory.copyWith(name: 'Transport');
        expect(updated.name, 'Transport');
        expect(updated.id, testCategory.id);
      });

      test('should create copy with updated type', () {
        final updated = testCategory.copyWith(type: CategoryType.income);
        expect(updated.type, CategoryType.income);
        expect(updated.name, testCategory.name);
      });

      test('should create copy with multiple updates', () {
        final updated = testCategory.copyWith(
          name: 'Transport',
          type: CategoryType.income,
          colorValue: 0xFFFF0000,
        );
        expect(updated.name, 'Transport');
        expect(updated.type, CategoryType.income);
        expect(updated.colorValue, 0xFFFF0000);
        expect(updated.id, testCategory.id);
      });
    });

    group('equality', () {
      test('should be equal with same values', () {
        final category1 = testCategory;
        final category2 = CategoryEntity(
          id: testCategory.id,
          name: testCategory.name,
          type: testCategory.type,
          iconCodePoint: testCategory.iconCodePoint,
          colorValue: testCategory.colorValue,
          createdAt: testCategory.createdAt,
          updatedAt: testCategory.updatedAt,
          isDeleted: testCategory.isDeleted,
        );
        expect(category1, equals(category2));
      });

      test('should not be equal with different id', () {
        final different = testCategory.copyWith(id: 'different-id');
        expect(testCategory, isNot(equals(different)));
      });

      test('should not be equal with different name', () {
        final different = testCategory.copyWith(name: 'Different');
        expect(testCategory, isNot(equals(different)));
      });
    });
  });
}
