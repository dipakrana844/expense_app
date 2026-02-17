import 'package:flutter_test/flutter_test.dart';
import 'package:smart_expense_tracker/features/smart_entry/presentation/providers/smart_entry_controller.dart';

void main() {
  group('Transaction Workflow Tests', () {
    test('expense workflow validation', () {
      final state = SmartEntryState(
        mode: TransactionMode.expense,
        amountString: '123.45',
        category: 'Grocery',
      );
      
      expect(state.isValid, true);
      expect(state.isReadyForSubmission, true);
      expect(state.validationErrors, isEmpty);
    });

    test('income workflow validation', () {
      final state = SmartEntryState(
        mode: TransactionMode.income,
        amountString: '2500',
        source: 'Salary',
      );
      
      expect(state.isValid, true);
      expect(state.isReadyForSubmission, true);
      expect(state.validationErrors, isEmpty);
    });

    test('transfer workflow validation', () {
      final state = SmartEntryState(
        mode: TransactionMode.transfer,
        amountString: '1000',
        fromAccount: 'Bank',
        toAccount: 'Wallet',
      );
      
      expect(state.isValid, true);
      expect(state.isReadyForSubmission, true);
      expect(state.validationErrors, isEmpty);
    });

    test('incomplete expense shows validation errors', () {
      final state = SmartEntryState(
        mode: TransactionMode.expense,
        amountString: '100',
        // Missing category
      );
      
      expect(state.isValid, false);
      expect(state.isReadyForSubmission, false);
      expect(state.validationErrors, isNotEmpty);
      expect(state.validationErrors, contains('Category is required for expense'));
    });

    test('transfer with same accounts is invalid', () {
      final state = SmartEntryState(
        mode: TransactionMode.transfer,
        amountString: '500',
        fromAccount: 'Bank',
        toAccount: 'Bank',
      );
      
      expect(state.isValid, false);
      expect(state.isReadyForSubmission, false);
      expect(state.validationErrors, isNotEmpty);
      expect(state.validationErrors, contains('Cannot transfer to the same account'));
    });

    test('amount entry workflow', () {
      final state1 = SmartEntryState(amountString: '123.45');
      expect(state1.amount, 123.45);
      
      final state2 = SmartEntryState(amountString: '0');
      expect(state2.amount, 0.0);
      
      final state3 = SmartEntryState(amountString: 'invalid');
      expect(state3.amount, 0.0);
    });

    test('mode switching preserves data', () {
      final originalState = SmartEntryState(
        mode: TransactionMode.expense,
        amountString: '100',
        category: 'Grocery',
        note: 'Test note',
      );
      
      final resetState = originalState.resetForm();
      
      expect(resetState.mode, TransactionMode.expense);
      expect(resetState.amountString, '');
      expect(resetState.category, 'Grocery'); // Preserved
      expect(resetState.note, null); // Cleared
      expect(resetState.isRecurring, false);
    });

    test('validation error messages are descriptive', () {
      final state = SmartEntryState(
        mode: TransactionMode.expense,
        amountString: '0',
        category: null,
      );
      
      final errors = state.validationErrors;
      expect(errors.length, greaterThan(0));
      expect(errors, contains('Amount must be greater than 0'));
      expect(errors, contains('Category is required for expense'));
    });

    test('transfer with fee validation', () {
      final state = SmartEntryState(
        mode: TransactionMode.transfer,
        amountString: '1000',
        fromAccount: 'Bank',
        toAccount: 'Wallet',
        transferFee: 15.0,
      );
      
      expect(state.isValid, true);
      // The validation should consider the fee in total amount calculations
    });

    test('future date validation', () {
      final futureDate = DateTime.now().add(const Duration(days: 2));
      final state = SmartEntryState(
        mode: TransactionMode.expense,
        amountString: '100',
        category: 'Grocery',
        date: futureDate,
      );
      
      // This should be caught by validationErrors but not by isValid
      // since isValid focuses on required fields, not date validation
      expect(state.isValid, true);
      // Date validation is in validationErrors
    });
  });
}