import 'package:flutter_test/flutter_test.dart';
import 'package:smart_expense_tracker/features/categories/domain/enums/category_type.dart';

void main() {
  group('CategoryType', () {
    group('fromString', () {
      test('should return CategoryType.income for "income"', () {
        expect(CategoryType.fromString('income'), CategoryType.income);
      });

      test('should return CategoryType.income for "INCOME"', () {
        expect(CategoryType.fromString('INCOME'), CategoryType.income);
      });

      test('should return CategoryType.income for "Income"', () {
        expect(CategoryType.fromString('Income'), CategoryType.income);
      });

      test('should return CategoryType.expense for "expense"', () {
        expect(CategoryType.fromString('expense'), CategoryType.expense);
      });

      test('should return CategoryType.expense for "EXPENSE"', () {
        expect(CategoryType.fromString('EXPENSE'), CategoryType.expense);
      });

      test('should throw ArgumentError for invalid type', () {
        expect(
          () => CategoryType.fromString('invalid'),
          throwsA(isA<ArgumentError>()),
        );
      });

      test('should throw ArgumentError for empty string', () {
        expect(
          () => CategoryType.fromString(''),
          throwsA(isA<ArgumentError>()),
        );
      });
    });

    group('toLowerCaseString', () {
      test('should return "income" for CategoryType.income', () {
        expect(CategoryType.income.toLowerCaseString(), 'income');
      });

      test('should return "expense" for CategoryType.expense', () {
        expect(CategoryType.expense.toLowerCaseString(), 'expense');
      });
    });

    group('displayName', () {
      test('should return "Income" for CategoryType.income', () {
        expect(CategoryType.income.displayName, 'Income');
      });

      test('should return "Expense" for CategoryType.expense', () {
        expect(CategoryType.expense.displayName, 'Expense');
      });
    });
  });
}
