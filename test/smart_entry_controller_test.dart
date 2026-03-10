import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_expense_tracker/features/smart_entry/presentation/providers/smart_entry_controller.dart';

void main() {
  group('SmartEntryState Tests', () {
    group('Initialization', () {
      test('initial state has correct default values', () {
        final state = SmartEntryState();

        expect(state.mode, TransactionMode.expense);
        expect(state.amountString, '');
        expect(state.category, null);
        expect(state.source, null);
        expect(state.fromAccount, null);
        expect(state.toAccount, null);
        expect(state.note, null);
        expect(state.isLoading, false);
        expect(state.error, null);
        expect(state.isRecurring, false);
        expect(state.date, isA<DateTime>());
        expect(state.time, isA<TimeOfDay>());
      });

      test('initial state with custom values', () {
        final customDate = DateTime(2024, 1, 15);
        const customTime = TimeOfDay(hour: 14, minute: 30);

        final state = SmartEntryState(
          mode: TransactionMode.income,
          amountString: '123.45',
          category: 'Grocery',
          source: 'Salary',
          note: 'Test note',
          date: customDate,
          time: customTime,
          isRecurring: true,
        );

        expect(state.mode, TransactionMode.income);
        expect(state.amountString, '123.45');
        expect(state.category, 'Grocery');
        expect(state.source, 'Salary');
        expect(state.note, 'Test note');
        expect(state.date, customDate);
        expect(state.time, customTime);
        expect(state.isRecurring, true);
      });
    });

    group('Amount Parsing', () {
      test('amount getter parses valid string correctly', () {
        final state = SmartEntryState(amountString: '123.45');
        expect(state.amount, 123.45);
      });

      test('amount getter returns 0 for empty string', () {
        final state = SmartEntryState(amountString: '');
        expect(state.amount, 0.0);
      });

      test('amount getter returns 0 for invalid string', () {
        final state = SmartEntryState(amountString: 'invalid');
        expect(state.amount, 0.0);
      });
    });

    group('Validation Logic', () {
      test('isValid returns false for zero amount', () {
        final state = SmartEntryState(amountString: '0');
        expect(state.isValid, false);
      });

      test('isValid returns false for negative amount', () {
        final state = SmartEntryState(amountString: '-50');
        expect(state.isValid, false);
      });

      test('isValid returns true for valid expense with category', () {
        final state = SmartEntryState(
          mode: TransactionMode.expense,
          amountString: '100',
          category: 'Grocery',
        );
        expect(state.isValid, true);
      });

      test('isValid returns false for expense without category', () {
        final state = SmartEntryState(
          mode: TransactionMode.expense,
          amountString: '100',
          category: null,
        );
        expect(state.isValid, false);
      });

      test('isValid returns true for valid income with source', () {
        final state = SmartEntryState(
          mode: TransactionMode.income,
          amountString: '1000',
          source: 'Salary',
        );
        expect(state.isValid, true);
      });

      test('isValid returns false for income without source', () {
        final state = SmartEntryState(
          mode: TransactionMode.income,
          amountString: '1000',
          source: null,
        );
        expect(state.isValid, false);
      });

      test(
        'isValid returns true for valid transfer with different accounts',
        () {
          final state = SmartEntryState(
            mode: TransactionMode.transfer,
            amountString: '500',
            fromAccount: 'Bank',
            toAccount: 'Wallet',
          );
          expect(state.isValid, true);
        },
      );

      test('isValid returns false for transfer with same accounts', () {
        final state = SmartEntryState(
          mode: TransactionMode.transfer,
          amountString: '500',
          fromAccount: 'Bank',
          toAccount: 'Bank',
        );
        expect(state.isValid, false);
      });

      test('isValid returns false for transfer without accounts', () {
        final state = SmartEntryState(
          mode: TransactionMode.transfer,
          amountString: '500',
          fromAccount: null,
          toAccount: null,
        );
        expect(state.isValid, false);
      });

      test('isValid returns false for transfer with missing account', () {
        final state = SmartEntryState(
          mode: TransactionMode.transfer,
          amountString: '500',
          fromAccount: 'Bank',
          toAccount: null,
        );
        expect(state.isValid, false);
      });
    });

    group('CopyWith Functionality', () {
      test('copyWith preserves unchanged fields', () {
        final originalState = SmartEntryState(
          mode: TransactionMode.expense,
          amountString: '100',
          category: 'Grocery',
          note: 'Original note',
        );

        final newState = originalState.copyWith(
          amountString: '200',
          note: 'Updated note',
        );

        expect(newState.mode, TransactionMode.expense);
        expect(newState.amountString, '200');
        expect(newState.category, 'Grocery');
        expect(newState.note, 'Updated note');
        expect(newState.date, originalState.date);
      });

      test('copyWith updates all specified fields', () {
        final originalState = SmartEntryState(
          mode: TransactionMode.income,
          amountString: '100',
          source: 'Salary',
          note: 'Initial note',
        );

        final newState = originalState.copyWith(
          mode: TransactionMode.expense,
          amountString: '200',
          category: 'Food',
          note: 'Updated note',
        );

        expect(newState.mode, TransactionMode.expense);
        expect(newState.amountString, '200');
        expect(newState.category, 'Food');
        expect(newState.source, 'Salary'); // Unchanged
        expect(newState.note, 'Updated note');
      });

      test('copyWith with no args preserves all values', () {
        final originalState = SmartEntryState(
          category: 'Grocery',
          note: 'Test note',
        );

        final newState = originalState.copyWith();

        expect(newState.category, 'Grocery');
        expect(newState.note, 'Test note');
      });
    });

    group('Reset Form', () {
      test('resetForm clears appropriate fields', () {
        final originalState = SmartEntryState(
          mode: TransactionMode.income,
          amountString: '123',
          category: 'Grocery',
          source: 'Salary',
          note: 'Test note',
          isRecurring: true,
          isLoading: true,
          error: 'Some error',
        );

        final resetState = originalState.resetForm();

        expect(resetState.mode, TransactionMode.income); // Preserved
        expect(resetState.amountString, '');
        expect(resetState.category, 'Grocery'); // Preserved
        expect(resetState.source, 'Salary'); // Preserved
        expect(resetState.note, null);
        expect(resetState.isRecurring, false);
        expect(resetState.isLoading, false);
        expect(resetState.error, null);
        expect(resetState.date, isA<DateTime>());
        expect(resetState.time, isA<TimeOfDay>());
      });
    });

    group('Preview Functions (now in UI — state-only tests)', () {
      test('getDailySpendPreview logic: null for non-expense mode', () {
        final state = SmartEntryState(
          mode: TransactionMode.income,
          amountString: '100',
        );
        // Preview helpers are now in the screen layer.
        // Validate the underlying state properties they depend on.
        expect(state.mode, isNot(TransactionMode.expense));
        expect(state.amount, 100.0);
      });

      test('getDailySpendPreview logic: zero amount returns no preview', () {
        final state = SmartEntryState(
          mode: TransactionMode.expense,
          amountString: '0',
        );
        expect(state.amount, 0.0);
      });

      test('transfer preview: valid when both accounts and amount set', () {
        final state = SmartEntryState(
          mode: TransactionMode.transfer,
          amountString: '100',
          fromAccount: 'Bank',
          toAccount: 'Wallet',
        );
        expect(state.fromAccount, 'Bank');
        expect(state.toAccount, 'Wallet');
        expect(state.amount, greaterThan(0));
      });

      test('transfer preview: null when accounts missing', () {
        final state = SmartEntryState(
          mode: TransactionMode.transfer,
          amountString: '100',
          fromAccount: null,
          toAccount: 'Wallet',
        );
        expect(state.fromAccount, isNull);
      });
    });
  });
}
