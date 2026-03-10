import '../../../income/data/local/income_local_data_source.dart';
import '../../../expenses/data/local/expense_local_data_source.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/entities/transaction_summary.dart';
import '../../domain/enums/transaction_type.dart';
import '../../shared/utils/transaction_utils.dart';

/// Repository for combining and managing transaction data
///
/// This repository acts as a facade that combines data from both
/// IncomeLocalDataSource and ExpenseLocalDataSource into a unified
/// transaction stream.
///
/// DEPENDENCY RULE: This class is pure data — it has NO dependency on
/// Riverpod providers or the presentation layer. The Riverpod provider
/// that instantiates this class lives in transaction_infrastructure_providers.dart.
class TransactionRepository {
  final IncomeLocalDataSource _incomeDataSource;
  final ExpenseLocalDataSource _expenseDataSource;

  TransactionRepository({
    required IncomeLocalDataSource incomeDataSource,
    required ExpenseLocalDataSource expenseDataSource,
  }) : _incomeDataSource = incomeDataSource,
       _expenseDataSource = expenseDataSource;

  /// Get all transactions (both income and expenses) sorted by date
  Future<List<TransactionEntity>> getAllTransactions() async {
    try {
      final incomes = await _incomeDataSource.getAllIncomes();
      final expenses = _expenseDataSource.getAllExpenses();
      return TransactionUtils.mergeTransactions(incomes, expenses);
    } catch (e) {
      return [];
    }
  }

  /// Get transactions filtered by type
  Future<List<TransactionEntity>> getTransactionsByType(
    TransactionType? type,
  ) async {
    final allTransactions = await getAllTransactions();
    return TransactionUtils.filterByType(allTransactions, type);
  }

  /// Get transactions for a specific month
  Future<List<TransactionEntity>> getMonthlyTransactions(DateTime month) async {
    final allTransactions = await getAllTransactions();
    return allTransactions.where((transaction) {
      return transaction.date.year == month.year &&
          transaction.date.month == month.month;
    }).toList();
  }

  /// Get transactions within a date range
  Future<List<TransactionEntity>> getTransactionsInRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
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
    DateTime month,
  ) async {
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
