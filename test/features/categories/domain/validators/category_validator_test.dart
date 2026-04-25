import 'package:flutter_test/flutter_test.dart';
import 'package:smart_expense_tracker/features/categories/domain/validators/category_validator.dart';
import 'package:smart_expense_tracker/features/categories/domain/failures/category_failure.dart';

void main() {
  group('CategoryValidator', () {
    const validId = '550e8400-e29b-41d4-a716-446655440000';
    const validName = 'Food';
    const validType = 'expense';
    const validIconCodePoint = 0xe5cc;
    const validColorValue = 0xFF2196F3;

    group('validateName', () {
      test('should succeed with valid name', () {
        final result = CategoryValidator.validateName(validName);
        expect(result.isSuccess, true);
      });

      test('should fail with empty name', () {
        final result = CategoryValidator.validateName('');
        expect(result.isFailure, true);
        expect(result.failure, isA<ValidationFailure>());
        expect(result.failure!.message, contains('empty'));
      });

      test('should fail with whitespace only', () {
        final result = CategoryValidator.validateName('   ');
        expect(result.isFailure, true);
      });

      test('should fail with name exceeding max length', () {
        final longName = 'a' * 51;
        final result = CategoryValidator.validateName(longName);
        expect(result.isFailure, true);
        expect(result.failure!.message, contains('exceed'));
      });

      test('should fail with invalid characters', () {
        final result = CategoryValidator.validateName('Food@#\$');
        expect(result.isFailure, true);
        expect(result.failure!.message, contains('invalid'));
      });

      test('should succeed with valid special characters', () {
        final result = CategoryValidator.validateName('Food & Drinks');
        expect(result.isSuccess, true);
      });

      test('should trim whitespace', () {
        final result = CategoryValidator.validateName('  Food  ');
        expect(result.isSuccess, true);
      });
    });

    group('validateType', () {
      test('should succeed with "income"', () {
        final result = CategoryValidator.validateType('income');
        expect(result.isSuccess, true);
      });

      test('should succeed with "expense"', () {
        final result = CategoryValidator.validateType('expense');
        expect(result.isSuccess, true);
      });

      test('should succeed with uppercase', () {
        final result = CategoryValidator.validateType('INCOME');
        expect(result.isSuccess, true);
      });

      test('should fail with invalid type', () {
        final result = CategoryValidator.validateType('invalid');
        expect(result.isFailure, true);
        expect(result.failure, isA<ValidationFailure>());
      });

      test('should fail with empty string', () {
        final result = CategoryValidator.validateType('');
        expect(result.isFailure, true);
      });
    });

    group('validateIconCodePoint', () {
      test('should succeed with valid icon code point', () {
        final result = CategoryValidator.validateIconCodePoint(
          validIconCodePoint,
        );
        expect(result.isSuccess, true);
      });

      test('should fail with negative value', () {
        final result = CategoryValidator.validateIconCodePoint(-1);
        expect(result.isFailure, true);
      });

      test('should fail with value exceeding Unicode range', () {
        final result = CategoryValidator.validateIconCodePoint(0x10000);
        expect(result.isFailure, true);
      });

      test('should succeed with zero', () {
        final result = CategoryValidator.validateIconCodePoint(0);
        expect(result.isSuccess, true);
      });
    });

    group('validateColorValue', () {
      test('should succeed with valid color value', () {
        final result = CategoryValidator.validateColorValue(validColorValue);
        expect(result.isSuccess, true);
      });

      test('should fail with negative value', () {
        final result = CategoryValidator.validateColorValue(-1);
        expect(result.isFailure, true);
      });

      test('should fail with value exceeding 32-bit range', () {
        final result = CategoryValidator.validateColorValue(0x100000000);
        expect(result.isFailure, true);
      });

      test('should succeed with minimum value', () {
        final result = CategoryValidator.validateColorValue(0);
        expect(result.isSuccess, true);
      });

      test('should succeed with maximum value', () {
        final result = CategoryValidator.validateColorValue(0xFFFFFFFF);
        expect(result.isSuccess, true);
      });
    });

    group('validateId', () {
      test('should succeed with valid UUID', () {
        final result = CategoryValidator.validateId(validId);
        expect(result.isSuccess, true);
      });

      test('should fail with empty string', () {
        final result = CategoryValidator.validateId('');
        expect(result.isFailure, true);
      });

      test('should fail with invalid UUID format', () {
        final result = CategoryValidator.validateId('invalid-uuid');
        expect(result.isFailure, true);
      });

      test('should fail with partial UUID', () {
        final result = CategoryValidator.validateId('550e8400-e29b-41d4');
        expect(result.isFailure, true);
      });
    });

    group('validateCategory', () {
      test('should succeed with all valid fields', () {
        final result = CategoryValidator.validateCategory(
          id: validId,
          name: validName,
          type: validType,
          iconCodePoint: validIconCodePoint,
          colorValue: validColorValue,
        );
        expect(result.isSuccess, true);
      });

      test('should fail with invalid name', () {
        final result = CategoryValidator.validateCategory(
          id: validId,
          name: '',
          type: validType,
          iconCodePoint: validIconCodePoint,
          colorValue: validColorValue,
        );
        expect(result.isFailure, true);
      });

      test('should fail with invalid type', () {
        final result = CategoryValidator.validateCategory(
          id: validId,
          name: validName,
          type: 'invalid',
          iconCodePoint: validIconCodePoint,
          colorValue: validColorValue,
        );
        expect(result.isFailure, true);
      });

      test('should fail with invalid icon code point', () {
        final result = CategoryValidator.validateCategory(
          id: validId,
          name: validName,
          type: validType,
          iconCodePoint: -1,
          colorValue: validColorValue,
        );
        expect(result.isFailure, true);
      });

      test('should fail with invalid color value', () {
        final result = CategoryValidator.validateCategory(
          id: validId,
          name: validName,
          type: validType,
          iconCodePoint: validIconCodePoint,
          colorValue: -1,
        );
        expect(result.isFailure, true);
      });
    });

    group('normalizeName', () {
      test('should convert to lowercase', () {
        expect(CategoryValidator.normalizeName('FOOD'), 'food');
      });

      test('should trim whitespace', () {
        expect(CategoryValidator.normalizeName('  Food  '), 'food');
      });

      test('should handle mixed case and whitespace', () {
        expect(
          CategoryValidator.normalizeName('  Food & Drinks  '),
          'food & drinks',
        );
      });
    });

    group('namesMatch', () {
      test('should match identical names', () {
        expect(CategoryValidator.namesMatch('Food', 'Food'), true);
      });

      test('should match case-insensitive', () {
        expect(CategoryValidator.namesMatch('Food', 'FOOD'), true);
      });

      test('should match with different whitespace', () {
        expect(CategoryValidator.namesMatch('Food', '  Food  '), true);
      });

      test('should not match different names', () {
        expect(CategoryValidator.namesMatch('Food', 'Drinks'), false);
      });
    });
  });
}
