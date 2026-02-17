import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/income/presentation/providers/income_providers.dart';
import '../../features/expenses/presentation/providers/expense_providers.dart';
import '../../features/transfer/presentation/providers/transfer_providers.dart';
import '../../features/transfer/domain/entities/transfer_entity.dart';
import '../domain/interfaces/transaction_interface.dart';

/// Service: AccountBalanceService
///
/// Purpose: Manages individual account balances for transfer validation
/// - Tracks balances for different accounts (Cash, Bank, UPI, Wallet, etc.)
/// - Validates transfer amounts against available balances
/// - Calculates account-specific financial metrics
/// - Provides real-time balance updates
class AccountBalanceService {
  final Ref _ref;

  AccountBalanceService(this._ref);

  /// Get current balance for a specific account
  /// 
  /// Parameters:
  /// - accountName: Name of the account to check balance for
  /// 
  /// Returns: Current balance for the specified account
  Future<double> getAccountBalance(String accountName) async {
    // Get all transactions that affect this account
    final incomes = await _getIncomesForAccount(accountName);
    final expenses = await _getExpensesForAccount(accountName);
    final transfers = await _getTransfersForAccount(accountName);
    
    double balance = 0.0;
    
    // Add income amounts for this account
    for (final income in incomes) {
      balance += income.amount;
    }
    
    // Subtract expense amounts for this account
    for (final expense in expenses) {
      balance -= expense.amount;
    }
    
    // Handle transfers (inflows and outflows)
    for (final transfer in transfers) {
      if (transfer.toAccount == accountName) {
        // This account received money
        balance += transfer.amount;
      } else if (transfer.fromAccount == accountName) {
        // This account sent money
        balance -= transfer.amount + transfer.fee;
      }
    }
    
    return balance;
  }

  /// Validate if a transfer can be made from an account
  /// 
  /// Parameters:
  /// - fromAccount: Account to transfer from
  /// - amount: Amount to transfer
  /// - fee: Transfer fee (default: 0)
  /// 
  /// Returns: Validation result with success status and message
  Future<AccountTransferValidation> validateTransfer({
    required String fromAccount,
    required double amount,
    double fee = 0.0,
  }) async {
    // Validate inputs
    if (amount <= 0) {
      return AccountTransferValidation(
        isValid: false,
        message: 'Transfer amount must be greater than 0',
      );
    }
    
    if (fee < 0) {
      return AccountTransferValidation(
        isValid: false,
        message: 'Transfer fee cannot be negative',
      );
    }
    
    if (fromAccount.isEmpty) {
      return AccountTransferValidation(
        isValid: false,
        message: 'From account is required',
      );
    }
    
    // Get current balance
    final balance = await getAccountBalance(fromAccount);
    final totalRequired = amount + fee;
    
    if (balance < totalRequired) {
      return AccountTransferValidation(
        isValid: false,
        message: 'Insufficient balance. Available: ₹${balance.toStringAsFixed(2)}, Required: ₹${totalRequired.toStringAsFixed(2)}',
        availableBalance: balance,
        requiredAmount: totalRequired,
      );
    }
    
    return AccountTransferValidation(
      isValid: true,
      message: 'Transfer is valid',
      availableBalance: balance,
      requiredAmount: totalRequired,
    );
  }

  /// Get all accounts with their current balances
  /// 
  /// Returns: Map of account names to their current balances
  Future<Map<String, double>> getAllAccountBalances() async {
    final allAccounts = await _getAllAccountNames();
    final balances = <String, double>{};
    
    for (final account in allAccounts) {
      balances[account] = await getAccountBalance(account);
    }
    
    return balances;
  }

  /// Get account summary including balance and transaction count
  /// 
  /// Parameters:
  /// - accountName: Name of the account to get summary for
  /// 
  /// Returns: AccountSummary with detailed information
  Future<AccountSummary> getAccountSummary(String accountName) async {
    final balance = await getAccountBalance(accountName);
    final incomes = await _getIncomesForAccount(accountName);
    final expenses = await _getExpensesForAccount(accountName);
    final transfers = await _getTransfersForAccount(accountName);
    
    final totalInflows = incomes.fold<double>(0.0, (sum, income) => sum + income.amount) +
                        transfers.where((t) => t.toAccount == accountName)
                                .fold<double>(0.0, (sum, transfer) => sum + transfer.amount);
    
    final totalOutflows = expenses.fold<double>(0.0, (sum, expense) => sum + expense.amount) +
                         transfers.where((t) => t.fromAccount == accountName)
                                 .fold<double>(0.0, (sum, transfer) => sum + transfer.amount + transfer.fee);
    
    return AccountSummary(
      accountName: accountName,
      currentBalance: balance,
      totalInflows: totalInflows,
      totalOutflows: totalOutflows,
      transactionCount: incomes.length + expenses.length + transfers.length,
      incomeCount: incomes.length,
      expenseCount: expenses.length,
      transferCount: transfers.length,
    );
  }

  /// Get all unique account names from all transaction types
  Future<Set<String>> _getAllAccountNames() async {
    final accounts = <String>{};
    
    // Get accounts from incomes (destination accounts)
    final incomesState = _ref.read(incomesProvider);
    incomesState.maybeWhen(
      data: (incomes) {
        for (final income in incomes) {
          if (income.metadata?['account'] != null) {
            accounts.add(income.metadata!['account'] as String);
          }
        }
      },
      orElse: () {},
    );
    
    // Get accounts from expenses (source accounts)
    final expensesState = _ref.read(expensesProvider);
    expensesState.maybeWhen(
      data: (expenses) {
        for (final expense in expenses) {
          if (expense.metadata?['account'] != null) {
            accounts.add(expense.metadata!['account'] as String);
          }
        }
      },
      orElse: () {},
    );
    
    // Get accounts from transfers
    final transfersState = _ref.read(transfersProvider);
    transfersState.maybeWhen(
      data: (transfers) {
        for (final transfer in transfers) {
          accounts.add(transfer.fromAccount);
          accounts.add(transfer.toAccount);
        }
      },
      orElse: () {},
    );
    
    // Add default accounts if none exist
    if (accounts.isEmpty) {
      accounts.addAll(['Cash', 'Bank', 'UPI', 'Wallet']);
    }
    
    return accounts;
  }

  /// Get incomes that affect a specific account
  Future<List<TransactionInterface>> _getIncomesForAccount(String accountName) async {
    final incomesState = _ref.read(incomesProvider);
    final incomes = <TransactionInterface>[];
    
    incomesState.maybeWhen(
      data: (incomeList) {
        for (final income in incomeList) {
          // Check if income is specifically for this account
          if (income.metadata?['account'] == accountName) {
            incomes.add(income);
          }
        }
      },
      orElse: () {},
    );
    
    return incomes;
  }

  /// Get expenses that affect a specific account
  Future<List<TransactionInterface>> _getExpensesForAccount(String accountName) async {
    final expensesState = _ref.read(expensesProvider);
    final expenses = <TransactionInterface>[];
    
    expensesState.maybeWhen(
      data: (expenseList) {
        for (final expense in expenseList) {
          // Check if expense is specifically from this account
          if (expense.metadata?['account'] == accountName) {
            expenses.add(expense);
          }
        }
      },
      orElse: () {},
    );
    
    return expenses;
  }

  /// Get transfers that involve a specific account
  Future<List<TransferEntity>> _getTransfersForAccount(String accountName) async {
    final transfersState = _ref.read(transfersProvider);
    final transfers = <TransferEntity>[];
    
    transfersState.maybeWhen(
      data: (transferList) {
        for (final transfer in transferList) {
          if (transfer.fromAccount == accountName || transfer.toAccount == accountName) {
            transfers.add(transfer);
          }
        }
      },
      orElse: () {},
    );
    
    return transfers;
  }
}

/// Validation result for account transfers
class AccountTransferValidation {
  final bool isValid;
  final String message;
  final double? availableBalance;
  final double? requiredAmount;

  AccountTransferValidation({
    required this.isValid,
    required this.message,
    this.availableBalance,
    this.requiredAmount,
  });
}

/// Detailed account summary
class AccountSummary {
  final String accountName;
  final double currentBalance;
  final double totalInflows;
  final double totalOutflows;
  final int transactionCount;
  final int incomeCount;
  final int expenseCount;
  final int transferCount;

  AccountSummary({
    required this.accountName,
    required this.currentBalance,
    required this.totalInflows,
    required this.totalOutflows,
    required this.transactionCount,
    required this.incomeCount,
    required this.expenseCount,
    required this.transferCount,
  });

  /// Calculate net flow (inflows - outflows)
  double get netFlow => totalInflows - totalOutflows;

  /// Calculate account activity ratio (transactions per day)
  double get activityRatio {
    // This would need date range information to calculate properly
    // For now, return a simple ratio
    return transactionCount > 0 ? transactionCount.toDouble() : 0.0;
  }
}

/// Provider for AccountBalanceService
final accountBalanceServiceProvider = Provider<AccountBalanceService>((ref) {
  return AccountBalanceService(ref);
});