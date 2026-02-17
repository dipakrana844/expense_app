import 'package:flutter_test/flutter_test.dart';
import 'package:smart_expense_tracker/features/smart_entry/presentation/providers/smart_entry_controller.dart';
import 'package:smart_expense_tracker/core/constants/app_constants.dart';

void main() {
  group('SmartEntryState Validation Tests', () {
    group('Enhanced Validation Logic', () {
      test('validationErrors returns empty list for valid state', () {
        final state = SmartEntryState(
          mode: TransactionMode.expense,
          amountString: '100',
          category: 'Grocery',
        );
        
        final errors = state.validationErrors;
        expect(errors, isEmpty);
      });

      test('validationErrors returns amount error for zero amount', () {
        final state = SmartEntryState(
          mode: TransactionMode.expense,
          amountString: '0',
          category: 'Grocery',
        );
        
        final errors = state.validationErrors;
        expect(errors, contains('Amount must be greater than 0'));
      });

      test('validationErrors returns amount error for negative amount', () {
        final state = SmartEntryState(
          mode: TransactionMode.expense,
          amountString: '-50',
          category: 'Grocery',
        );
        
        final errors = state.validationErrors;
        expect(errors, contains('Amount must be greater than 0'));
      });

      test('validationErrors returns max amount error for excessive amount', () {
        final state = SmartEntryState(
          mode: TransactionMode.expense,
          amountString: '1000001', // Above max limit
          category: 'Grocery',
        );
        
        final errors = state.validationErrors;
        expect(errors, contains('Amount exceeds maximum limit of ₹10,00,000.00'));
      });

      test('validationErrors returns category error for expense without category', () {
        final state = SmartEntryState(
          mode: TransactionMode.expense,
          amountString: '100',
          category: null,
        );
        
        final errors = state.validationErrors;
        expect(errors, contains('Category is required for expense'));
      });

      test('validationErrors returns source error for income without source', () {
        final state = SmartEntryState(
          mode: TransactionMode.income,
          amountString: '1000',
          source: null,
        );
        
        final errors = state.validationErrors;
        expect(errors, contains('Source is required for income'));
      });

      test('validationErrors returns account errors for transfer with missing accounts', () {
        final state = SmartEntryState(
          mode: TransactionMode.transfer,
          amountString: '500',
          fromAccount: null,
          toAccount: null,
        );
        
        final errors = state.validationErrors;
        expect(errors, contains('From account is required for transfer'));
        expect(errors, contains('To account is required for transfer'));
      });

      test('validationErrors returns same account error for transfer', () {
        final state = SmartEntryState(
          mode: TransactionMode.transfer,
          amountString: '500',
          fromAccount: 'Bank',
          toAccount: 'Bank',
        );
        
        final errors = state.validationErrors;
        expect(errors, contains('Cannot transfer to the same account'));
      });

      test('validationErrors returns future date error', () {
        final futureDate = DateTime.now().add(const Duration(days: 2));
        final state = SmartEntryState(
          mode: TransactionMode.expense,
          amountString: '100',
          category: 'Grocery',
          date: futureDate,
        );
        
        final errors = state.validationErrors;
        expect(errors, contains('Date cannot be in the future'));
      });

      test('validationErrors returns note length error', () {
        final longNote = 'x' * (AppConstants.maxNoteLength + 1);
        final state = SmartEntryState(
          mode: TransactionMode.expense,
          amountString: '100',
          category: 'Grocery',
          note: longNote,
        );
        
        final errors = state.validationErrors;
        expect(errors, contains('Note is too long (maximum ${AppConstants.maxNoteLength} characters)'));
      });

      test('validationErrors returns multiple errors for invalid state', () {
        final state = SmartEntryState(
          mode: TransactionMode.expense,
          amountString: '0',
          category: null,
          note: 'x' * (AppConstants.maxNoteLength + 100),
        );
        
        final errors = state.validationErrors;
        expect(errors.length, greaterThan(1));
        expect(errors, contains('Amount must be greater than 0'));
        expect(errors, contains('Category is required for expense'));
        expect(errors, contains('Note is too long (maximum ${AppConstants.maxNoteLength} characters)'));
      });
    });

    group('isReadyForSubmission Tests', () {
      test('isReadyForSubmission returns true for valid complete state', () {
        final state = SmartEntryState(
          mode: TransactionMode.expense,
          amountString: '100',
          category: 'Grocery',
        );
        
        expect(state.isReadyForSubmission, true);
      });

      test('isReadyForSubmission returns false for invalid state', () {
        final state = SmartEntryState(
          mode: TransactionMode.expense,
          amountString: '0',
          category: 'Grocery',
        );
        
        expect(state.isReadyForSubmission, false);
      });

      test('isReadyForSubmission returns false when loading', () {
        final state = SmartEntryState(
          mode: TransactionMode.expense,
          amountString: '100',
          category: 'Grocery',
          isLoading: true,
        );
        
        expect(state.isReadyForSubmission, false);
      });

      test('isReadyForSubmission returns false for income without source', () {
        final state = SmartEntryState(
          mode: TransactionMode.income,
          amountString: '1000',
          source: null,
        );
        
        expect(state.isReadyForSubmission, false);
      });

      test('isReadyForSubmission returns false for transfer with same accounts', () {
        final state = SmartEntryState(
          mode: TransactionMode.transfer,
          amountString: '500',
          fromAccount: 'Bank',
          toAccount: 'Bank',
        );
        
        expect(state.isReadyForSubmission, false);
      });

      test('isReadyForSubmission returns false for transfer with zero amount', () {
        final state = SmartEntryState(
          mode: TransactionMode.transfer,
          amountString: '0',
          fromAccount: 'Bank',
          toAccount: 'Wallet',
        );
        
        expect(state.isReadyForSubmission, false);
      });
    });

    group('Edge Cases', () {
      test('validation handles empty strings gracefully', () {
        final state = SmartEntryState(
          mode: TransactionMode.expense,
          amountString: '',
          category: '',
        );
        
        final errors = state.validationErrors;
        expect(errors, contains('Amount must be greater than 0'));
        expect(errors, contains('Category is required for expense'));
      });

      test('validation handles whitespace strings', () {
        final state = SmartEntryState(
          mode: TransactionMode.expense,
          amountString: '100', // Valid amount
          category: '   ', // Whitespace only
        );
        
        final errors = state.validationErrors;
        expect(errors, contains('Category is required for expense'));
      });

      test('validation handles very large numbers', () {
        final state = SmartEntryState(
          mode: TransactionMode.expense,
          amountString: '999999999999', // Very large number
          category: 'Grocery',
        );
        
        final errors = state.validationErrors;
        expect(errors, contains('Amount exceeds maximum limit of ₹10,00,000.00'));
      });

      test('validation handles exact max amount', () {
        final state = SmartEntryState(
          mode: TransactionMode.expense,
          amountString: AppConstants.maxExpenseAmount.toString(),
          category: 'Grocery',
        );
        
        final errors = state.validationErrors;
        expect(errors, isEmpty); // Should be valid at exactly the limit
      });

      test('validation handles note at maximum length', () {
        final maxNote = 'x' * AppConstants.maxNoteLength;
        final state = SmartEntryState(
          mode: TransactionMode.expense,
          amountString: '100',
          category: 'Grocery',
          note: maxNote,
        );
        
        final errors = state.validationErrors;
        expect(errors, isEmpty); // Should be valid at exactly the limit
      });
    });
  });
}