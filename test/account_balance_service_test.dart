import 'package:flutter_test/flutter_test.dart';
import 'package:smart_expense_tracker/core/services/account_balance_service.dart';
import 'package:smart_expense_tracker/features/transfer/domain/entities/transfer_entity.dart';

void main() {
  group('AccountTransferValidation Tests', () {
    test('valid transfer has correct properties', () {
      final validation = AccountTransferValidation(
        isValid: true,
        message: 'Transfer is valid',
        availableBalance: 1000.0,
        requiredAmount: 500.0,
      );
      
      expect(validation.isValid, true);
      expect(validation.message, 'Transfer is valid');
      expect(validation.availableBalance, 1000.0);
      expect(validation.requiredAmount, 500.0);
    });

    test('invalid transfer has error message', () {
      final validation = AccountTransferValidation(
        isValid: false,
        message: 'Insufficient balance',
        availableBalance: 100.0,
        requiredAmount: 500.0,
      );
      
      expect(validation.isValid, false);
      expect(validation.message, 'Insufficient balance');
      expect(validation.availableBalance, 100.0);
      expect(validation.requiredAmount, 500.0);
    });

    test('transfer with zero amount is invalid', () {
      final validation = AccountTransferValidation(
        isValid: false,
        message: 'Transfer amount must be greater than 0',
      );
      
      expect(validation.isValid, false);
      expect(validation.message, 'Transfer amount must be greater than 0');
    });
  });

  group('AccountSummary Tests', () {
    test('account summary calculates net flow correctly', () {
      final summary = AccountSummary(
        accountName: 'Bank',
        currentBalance: 1000.0,
        totalInflows: 500.0,
        totalOutflows: 300.0,
        transactionCount: 5,
        incomeCount: 2,
        expenseCount: 1,
        transferCount: 2,
      );
      
      expect(summary.accountName, 'Bank');
      expect(summary.currentBalance, 1000.0);
      expect(summary.totalInflows, 500.0);
      expect(summary.totalOutflows, 300.0);
      expect(summary.netFlow, 200.0); // 500 - 300
      expect(summary.transactionCount, 5);
      expect(summary.incomeCount, 2);
      expect(summary.expenseCount, 1);
      expect(summary.transferCount, 2);
    });

    test('account with more outflows has negative net flow', () {
      final summary = AccountSummary(
        accountName: 'Wallet',
        currentBalance: 200.0,
        totalInflows: 100.0,
        totalOutflows: 400.0,
        transactionCount: 3,
        incomeCount: 1,
        expenseCount: 1,
        transferCount: 1,
      );
      
      expect(summary.netFlow, -300.0); // 100 - 400
    });

    test('account activity ratio calculation', () {
      final summary = AccountSummary(
        accountName: 'Bank',
        currentBalance: 1000.0,
        totalInflows: 0.0,
        totalOutflows: 0.0,
        transactionCount: 10,
        incomeCount: 0,
        expenseCount: 0,
        transferCount: 0,
      );
      
      // For now, activity ratio returns transaction count as double
      expect(summary.activityRatio, 10.0);
    });
  });

  group('TransferEntity Integration Tests', () {
    test('transfer entity validation works correctly', () {
      final validTransfer = TransferEntity(
        id: 'transfer-1',
        amount: 500.0,
        fromAccount: 'Bank',
        toAccount: 'Wallet',
        date: DateTime.now(),
        fee: 10.0,
        note: 'Transfer to wallet',
        createdAt: DateTime.now(),
      );
      
      final validationError = validTransfer.validate();
      expect(validationError, null);
    });

    test('transfer with same accounts is invalid', () {
      final invalidTransfer = TransferEntity(
        id: 'transfer-1',
        amount: 500.0,
        fromAccount: 'Bank',
        toAccount: 'Bank',
        date: DateTime.now(),
        createdAt: DateTime.now(),
      );
      
      final validationError = invalidTransfer.validate();
      expect(validationError, 'Cannot transfer to the same account');
    });

    test('transfer with zero amount is invalid', () {
      final invalidTransfer = TransferEntity(
        id: 'transfer-1',
        amount: 0.0,
        fromAccount: 'Bank',
        toAccount: 'Wallet',
        date: DateTime.now(),
        createdAt: DateTime.now(),
      );
      
      final validationError = invalidTransfer.validate();
      expect(validationError, 'Amount must be greater than 0');
    });

    test('transfer with negative fee is invalid', () {
      final invalidTransfer = TransferEntity(
        id: 'transfer-1',
        amount: 500.0,
        fromAccount: 'Bank',
        toAccount: 'Wallet',
        date: DateTime.now(),
        fee: -10.0,
        createdAt: DateTime.now(),
      );
      
      final validationError = invalidTransfer.validate();
      expect(validationError, 'Fee cannot be negative');
    });

    test('transfer with future date is invalid', () {
      final futureDate = DateTime.now().add(const Duration(days: 5));
      final invalidTransfer = TransferEntity(
        id: 'transfer-1',
        amount: 500.0,
        fromAccount: 'Bank',
        toAccount: 'Wallet',
        date: futureDate,
        createdAt: DateTime.now(),
      );
      
      final validationError = invalidTransfer.validate();
      expect(validationError, 'Date cannot be too far in the future');
    });

    test('transfer properties are calculated correctly', () {
      final transfer = TransferEntity(
        id: 'transfer-1',
        amount: 500.0,
        fromAccount: 'Bank',
        toAccount: 'Wallet',
        date: DateTime.now(),
        fee: 10.0,
        note: 'Test transfer',
        createdAt: DateTime.now(),
      );
      
      expect(transfer.totalAmount, 510.0); // amount + fee
      expect(transfer.categoryOrSource, 'Bank → Wallet');
      expect(transfer.isIncome, false);
      expect(transfer.isExpense, false);
      expect(transfer.displayAmount, 500.0);
    });
  });
}