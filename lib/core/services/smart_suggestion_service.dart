import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/income/presentation/providers/income_providers.dart';
import '../../features/expenses/presentation/providers/expense_providers.dart';
import '../../features/transfer/presentation/providers/transfer_providers.dart';
import '../constants/app_constants.dart';

/// Service: SmartSuggestionService
///
/// Purpose: Provides intelligent suggestions for transaction entry
/// - Auto-select last used category
/// - Auto-select last used account
/// - Pattern detection for recurring transactions
class SmartSuggestionService {
  final Ref _ref;

  SmartSuggestionService(this._ref);

  /// Get last used category for expense mode
  String? getLastExpenseCategory() {
    final expensesState = _ref.read(expensesProvider);
    return expensesState.maybeWhen(
      data: (expenses) => expenses.isNotEmpty ? expenses.first.category : null,
      orElse: () => null,
    );
  }

  /// Get last used source for income mode
  String? getLastIncomeSource() {
    final incomesState = _ref.read(incomesProvider);
    return incomesState.maybeWhen(
      data: (incomes) => incomes.isNotEmpty ? incomes.first.source : null,
      orElse: () => null,
    );
  }

  /// Get frequently used expense categories (sorted by usage count)
  List<String> getFrequentExpenseCategories({int limit = 5}) {
    final expensesState = _ref.read(expensesProvider);
    return expensesState.maybeWhen(
      data: (expenses) {
        if (expenses.isEmpty) {
          return AppConstants.expenseCategories.take(limit).toList();
        }
        
        // Count category occurrences
        final categoryCount = <String, int>{};
        for (final expense in expenses) {
          categoryCount[expense.category] = 
              (categoryCount[expense.category] ?? 0) + 1;
        }

        // Sort by count and return top categories
        final sorted = categoryCount.entries.toList()
          ..sort((a, b) => b.value.compareTo(a.value));
        
        return sorted.take(limit).map((e) => e.key).toList();
      },
      orElse: () => AppConstants.expenseCategories.take(limit).toList(),
    );
  }

  /// Get frequently used income sources (sorted by usage count)
  List<String> getFrequentIncomeSources({int limit = 5}) {
    final incomesState = _ref.read(incomesProvider);
    return incomesState.maybeWhen(
      data: (incomes) {
        if (incomes.isEmpty) {
          return ['Salary', 'Freelance', 'Investment', 'Gift', 'Others'].take(limit).toList();
        }

        // Count source occurrences
        final sourceCount = <String, int>{};
        for (final income in incomes) {
          sourceCount[income.source] = 
              (sourceCount[income.source] ?? 0) + 1;
        }

        // Sort by count and return top sources
        final sorted = sourceCount.entries.toList()
          ..sort((a, b) => b.value.compareTo(a.value));
        
        return sorted.take(limit).map((e) => e.key).toList();
      },
      orElse: () => ['Salary', 'Freelance', 'Investment', 'Gift', 'Others'].take(limit).toList(),
    );
  }

  /// Get last used accounts for transfer
  ({String? from, String? to}) getLastTransferAccounts() {
    final transfersState = _ref.read(transfersProvider);
    return transfersState.maybeWhen(
      data: (transfers) {
        if (transfers.isEmpty) {
          return (from: null, to: null);
        }
        final lastTransfer = transfers.first;
        return (from: lastTransfer.fromAccount, to: lastTransfer.toAccount);
      },
      orElse: () => (from: null, to: null),
    );
  }

  /// Get all unique accounts from transfers
  List<String> getAllAccounts() {
    final transfersState = _ref.read(transfersProvider);
    return transfersState.maybeWhen(
      data: (transfers) {
        final accounts = <String>{};
        
        for (final transfer in transfers) {
          accounts.add(transfer.fromAccount);
          accounts.add(transfer.toAccount);
        }

        // Add default accounts if none exist
        if (accounts.isEmpty) {
          accounts.addAll(['Cash', 'Bank', 'UPI', 'Wallet']);
        }

        final accountList = accounts.toList()..sort();
        return accountList;
      },
      orElse: () => ['Cash', 'Bank', 'UPI', 'Wallet'],
    );
  }

  /// Detect if transaction might be recurring based on pattern
  bool isRecurringPattern({
    required String category,
    required double amount,
    required int dayOfMonth,
  }) {
    final expensesState = _ref.read(expensesProvider);
    return expensesState.maybeWhen(
      data: (expenses) {
        // Check if similar expense exists on same day for last 3 months
        int matchCount = 0;
        for (final expense in expenses) {
          if (expense.category == category &&
              expense.amount == amount &&
              expense.date.day == dayOfMonth) {
            matchCount++;
          }
        }
        
        return matchCount >= 2;
      },
      orElse: () => false,
    );
  }

  /// Get suggested recurring schedule if pattern detected
  String? getRecurringSuggestion({
    required String category,
    required double amount,
  }) {
    // This would analyze patterns and suggest frequency
    // For now, return null as this is a simple implementation
    return null;
  }
}

/// Provider for SmartSuggestionService
final smartSuggestionServiceProvider = Provider<SmartSuggestionService>((ref) {
  return SmartSuggestionService(ref);
});
