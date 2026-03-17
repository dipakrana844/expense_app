import 'transaction_entity.dart';

/// Domain Entity: TransactionSummary
///
/// Aggregate value object representing summary statistics for a set of
/// transactions. Belongs in the domain layer — no data or UI concerns.
class TransactionSummary {
  final double totalIncome;
  final double totalExpenses;
  final double totalTransfers;
  final double netBalance;
  final int transactionCount;
  final int incomeCount;
  final int expenseCount;
  final int transferCount;

  const TransactionSummary({
    required this.totalIncome,
    required this.totalExpenses,
    required this.totalTransfers,
    required this.netBalance,
    required this.transactionCount,
    required this.incomeCount,
    required this.expenseCount,
    required this.transferCount,
  });

  /// Factory: build summary from a list of mixed transactions.
  factory TransactionSummary.fromTransactions(
    List<TransactionEntity> transactions,
  ) {
    final incomeTransactions = transactions.where((t) => t.isIncome).toList();
    final expenseTransactions = transactions.where((t) => t.isExpense).toList();
    final transferTransactions = transactions.where((t) => t.isTransfer).toList();

    final totalIncome = incomeTransactions.fold(
      0.0,
      (sum, t) => sum + t.amount,
    );
    final totalExpenses = expenseTransactions.fold(
      0.0,
      (sum, t) => sum + t.amount,
    );
    final totalTransfers = transferTransactions.fold(
      0.0,
      (sum, t) => sum + t.amount,
    );

    return TransactionSummary(
      totalIncome: totalIncome,
      totalExpenses: totalExpenses,
      totalTransfers: totalTransfers,
      netBalance: totalIncome - totalExpenses,
      transactionCount: transactions.length,
      incomeCount: incomeTransactions.length,
      expenseCount: expenseTransactions.length,
      transferCount: transferTransactions.length,
    );
  }

  /// Empty sentinel.
  factory TransactionSummary.empty() => const TransactionSummary(
    totalIncome: 0,
    totalExpenses: 0,
    totalTransfers: 0,
    netBalance: 0,
    transactionCount: 0,
    incomeCount: 0,
    expenseCount: 0,
    transferCount: 0,
  );

  TransactionSummary copyWith({
    double? totalIncome,
    double? totalExpenses,
    double? totalTransfers,
    double? netBalance,
    int? transactionCount,
    int? incomeCount,
    int? expenseCount,
    int? transferCount,
  }) {
    return TransactionSummary(
      totalIncome: totalIncome ?? this.totalIncome,
      totalExpenses: totalExpenses ?? this.totalExpenses,
      totalTransfers: totalTransfers ?? this.totalTransfers,
      netBalance: netBalance ?? this.netBalance,
      transactionCount: transactionCount ?? this.transactionCount,
      incomeCount: incomeCount ?? this.incomeCount,
      expenseCount: expenseCount ?? this.expenseCount,
      transferCount: transferCount ?? this.transferCount,
    );
  }
}
