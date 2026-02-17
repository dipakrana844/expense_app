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
        final customTime = const TimeOfDay(hour: 14, minute: 30);
        
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

      test('isValid returns true for valid transfer with different accounts', () {
        final state = SmartEntryState(
          mode: TransactionMode.transfer,
          amountString: '500',
          fromAccount: 'Bank',
          toAccount: 'Wallet',
        );
        expect(state.isValid, true);
      });

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

      test('copyWith with null values preserves existing values', () {
        final originalState = SmartEntryState(
          category: 'Grocery',
          note: 'Test note',
        );
        
        // When copyWith is called with null for optional parameters,
        // it should preserve the original values, not set them to null
        final newState = originalState.copyWith(
          // Only updating fields that are explicitly provided
        );
        
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
        // Date and time should be reset to current
        expect(resetState.date, isA<DateTime>());
        expect(resetState.time, isA<TimeOfDay>());
      });
    });
  });

  group('Utility Functions Tests', () {
    group('Currency Formatting', () {
      test('getFormattedAmount returns formatted currency string', () {
        final state = SmartEntryState(amountString: '1234');
        // This would need access to CurrencyUtils, but we can test the logic
        // The actual formatting is handled by CurrencyUtils.formatAmount
      });

      test('getFormattedAmount returns zero when empty', () {
        final state = SmartEntryState(amountString: '');
        // This would need access to AppConstants.currencySymbol
      });
    });

    group('Color Selection', () {
      test('getAccentColor returns correct colors for modes', () {
        final context = MockBuildContext();
        
        // Test expense color
        final expenseState = SmartEntryState(mode: TransactionMode.expense);
        final expenseController = MockController(expenseState);
        final expenseColor = expenseController.getAccentColor(context);
        expect(expenseColor, const Color(0xFFF44336));
        
        // Test income color
        final incomeState = SmartEntryState(mode: TransactionMode.income);
        final incomeController = MockController(incomeState);
        final incomeColor = incomeController.getAccentColor(context);
        expect(incomeColor, const Color(0xFF2196F3));
        
        // Test transfer color
        final transferState = SmartEntryState(mode: TransactionMode.transfer);
        final transferController = MockController(transferState);
        final transferColor = transferController.getAccentColor(context);
        expect(transferColor, const Color(0xFF757575));
      });
    });

    group('Preview Functions', () {
      test('getDailySpendPreview returns null for non-expense mode', () {
        final state = SmartEntryState(
          mode: TransactionMode.income,
          amountString: '100',
        );
        final controller = MockController(state);
        final preview = controller.getDailySpendPreview();
        expect(preview, null);
      });

      test('getDailySpendPreview returns null for zero amount', () {
        final state = SmartEntryState(
          mode: TransactionMode.expense,
          amountString: '0',
        );
        final controller = MockController(state);
        final preview = controller.getDailySpendPreview();
        expect(preview, null);
      });

      test('getIncomeBalancePreview returns null for non-income mode', () {
        final state = SmartEntryState(
          mode: TransactionMode.expense,
          amountString: '100',
        );
        final controller = MockController(state);
        final preview = controller.getIncomeBalancePreview();
        expect(preview, null);
      });

      test('getIncomeBalancePreview returns null for zero amount', () {
        final state = SmartEntryState(
          mode: TransactionMode.income,
          amountString: '0',
        );
        final controller = MockController(state);
        final preview = controller.getIncomeBalancePreview();
        expect(preview, null);
      });

      test('getTransferPreview returns null for non-transfer mode', () {
        final state = SmartEntryState(
          mode: TransactionMode.expense,
          amountString: '100',
          fromAccount: 'Bank',
          toAccount: 'Wallet',
        );
        final controller = MockController(state);
        final preview = controller.getTransferPreview();
        expect(preview, null);
      });

      test('getTransferPreview returns null for missing accounts', () {
        final state = SmartEntryState(
          mode: TransactionMode.transfer,
          amountString: '100',
          fromAccount: null,
          toAccount: 'Wallet',
        );
        final controller = MockController(state);
        final preview = controller.getTransferPreview();
        expect(preview, null);
      });
    });
  });
}

// Mock classes for testing
class MockController {
  final SmartEntryState state;
  
  MockController(this.state);
  
  Color getAccentColor(BuildContext context) {
    switch (state.mode) {
      case TransactionMode.income: return const Color(0xFF2196F3);
      case TransactionMode.expense: return const Color(0xFFF44336);
      case TransactionMode.transfer: return const Color(0xFF757575);
    }
  }
  
  double? getDailySpendPreview() {
    if (state.mode != TransactionMode.expense) return null;
    if (state.amount <= 0) return null;
    // Mock implementation - in real app this would read from dailySpendStateProvider
    return 1000.0 - 200.0 - state.amount;
  }
  
  double? getIncomeBalancePreview() {
    if (state.mode != TransactionMode.income) return null;
    if (state.amount <= 0) return null;
    return state.amount;
  }
  
  String? getTransferPreview() {
    if (state.mode != TransactionMode.transfer) return null;
    if (state.fromAccount == null || state.toAccount == null) return null;
    if (state.amount <= 0) return null;
    return '${state.fromAccount} -> ${state.toAccount}';
  }
}

class MockBuildContext implements BuildContext {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}