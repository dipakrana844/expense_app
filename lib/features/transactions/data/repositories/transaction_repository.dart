import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../income/data/local/income_local_data_source.dart';
import '../../../expenses/data/local/expense_local_data_source.dart';
import '../../../income/presentation/providers/income_providers.dart';
import '../../../expenses/presentation/providers/expense_providers.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/enums/transaction_type.dart';
import '../../shared/utils/transaction_utils.dart';

/// Repository for combining and managing transaction data
///
/// This repository acts as a facade that combines data from both
/// IncomeLocalDataSource and ExpenseLocalDataSource into a unified
/// transaction stream.
class TransactionRepository {
  final IncomeLocalDataSource _incomeDataSource;
  final ExpenseLocalDataSource _expenseDataSource;

  TransactionRepository({
    required IncomeLocalDataSource incomeDataSource,
    required ExpenseLocalDataSource expenseDataSource,
  })  : _incomeDataSource = incomeDataSource,
        _expenseDataSource = expenseDataSource;

  /// Get all transactions (both income and expenses) sorted by date
  Future<List<TransactionEntity>> getAllTransactions() async {
    try {
      final incomes = await _incomeDataSource.getAllIncomes();
      final expenses = await _expenseDataSource.getAllExpenses();
      
      return TransactionUtils.mergeTransactions(incomes, expenses);
    } catch (e) {
      // Return empty list on error
      return [];
    }
  }

  /// Get transactions filtered by type
  Future<List<TransactionEntity>> getTransactionsByType(
      TransactionType? type) async {
    final allTransactions = await getAllTransactions();
    return TransactionUtils.filterByType(allTransactions, type);
  }

  /// Get transactions for a specific month
  Future<List<TransactionEntity>> getMonthlyTransactions(
      DateTime month) async {
    final allTransactions = await getAllTransactions();
    
    return allTransactions.where((transaction) {
      return transaction.date.year == month.year &&
          transaction.date.month == month.month;
    }).toList();
  }

  /// Get transactions within a date range
  Future<List<TransactionEntity>> getTransactionsInRange(
      DateTime startDate, DateTime endDate) async {
    final allTransactions = await getAllTransactions();
    
    return allTransactions.where((transaction) {
      return !transaction.date.isBefore(startDate) &&
          !transaction.date.isAfter(endDate);
    }).toList();
  }

  /// Get summary statistics for current month
  Future<TransactionSummary> getCurrentMonthSummary() async {
    final now = DateTime.now();
    final monthlyTransactions = await getMonthlyTransactions(now);
    
    return TransactionSummary.fromTransactions(monthlyTransactions);
  }

  /// Get summary statistics for a specific month
  Future<TransactionSummary> getMonthSummary(DateTime month) async {
    final monthlyTransactions = await getMonthlyTransactions(month);
    return TransactionSummary.fromTransactions(monthlyTransactions);
  }

  /// Get transactions grouped by date
  Future<Map<String, List<TransactionEntity>>> getGroupedTransactions() async {
    final transactions = await getAllTransactions();
    return TransactionUtils.groupByDate(transactions);
  }

  /// Get transactions grouped by date for a specific month
  Future<Map<String, List<TransactionEntity>>> getMonthlyGroupedTransactions(
      DateTime month) async {
    final monthlyTransactions = await getMonthlyTransactions(month);
    return TransactionUtils.groupByDate(monthlyTransactions);
  }

  /// Search transactions by category/source or note
  Future<List<TransactionEntity>> searchTransactions(String query) async {
    final allTransactions = await getAllTransactions();
    final lowerQuery = query.toLowerCase();
    
    return allTransactions.where((transaction) {
      return transaction.categoryOrSource.toLowerCase().contains(lowerQuery) ||
          (transaction.note != null &&
              transaction.note!.toLowerCase().contains(lowerQuery));
    }).toList();
  }

  /// Get recent transactions (last N items)
  Future<List<TransactionEntity>> getRecentTransactions(int limit) async {
    final allTransactions = await getAllTransactions();
    return allTransactions.take(limit).toList();
  }
}

/// Summary statistics for transactions
class TransactionSummary {
  final double totalIncome;
  final double totalExpenses;
  final double netBalance;
  final int transactionCount;
  final int incomeCount;
  final int expenseCount;

  TransactionSummary({
    required this.totalIncome,
    required this.totalExpenses,
    required this.netBalance,
    required this.transactionCount,
    required this.incomeCount,
    required this.expenseCount,
  });

  /// Create summary from list of transactions
  factory TransactionSummary.fromTransactions(
      List<TransactionEntity> transactions) {
    final incomeTransactions =
        transactions.where((t) => t.isIncome).toList();
    final expenseTransactions =
        transactions.where((t) => t.isExpense).toList();

    final totalIncome = incomeTransactions
        .fold(0.0, (sum, transaction) => sum + transaction.amount);
    final totalExpenses = expenseTransactions
        .fold(0.0, (sum, transaction) => sum + transaction.amount);
    final netBalance = totalIncome - totalExpenses;

    return TransactionSummary(
      totalIncome: totalIncome,
      totalExpenses: totalExpenses,
      netBalance: netBalance,
      transactionCount: transactions.length,
      incomeCount: incomeTransactions.length,
      expenseCount: expenseTransactions.length,
    );
  }

  /// Copy with new values
  TransactionSummary copyWith({
    double? totalIncome,
    double? totalExpenses,
    double? netBalance,
    int? transactionCount,
    int? incomeCount,
    int? expenseCount,
  }) {
    return TransactionSummary(
      totalIncome: totalIncome ?? this.totalIncome,
      totalExpenses: totalExpenses ?? this.totalExpenses,
      netBalance: netBalance ?? this.netBalance,
      transactionCount: transactionCount ?? this.transactionCount,
      incomeCount: incomeCount ?? this.incomeCount,
      expenseCount: expenseCount ?? this.expenseCount,
    );
  }
}

/// Provider for TransactionRepository
final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  final incomeDataSource = ref.watch(incomeLocalDataSourceProvider);
  final expenseDataSource = ref.watch(expenseLocalDataSourceProvider);
  
  return TransactionRepository(
    incomeDataSource: incomeDataSource,
    expenseDataSource: expenseDataSource,
  );
});