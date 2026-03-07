import 'transaction_entity.dart';

/// Domain Entity: TransactionSummary
///
/// Aggregate value object representing summary statistics for a set of
/// transactions. Belongs in the domain layer — no data or UI concerns.
class TransactionSummary {
  final double totalIncome;
  final double totalExpenses;
  final double netBalance;
  final int transactionCount;
  final int incomeCount;
  final int expenseCount;

  const TransactionSummary({
    required this.totalIncome,
    required this.totalExpenses,
    required this.netBalance,
    required this.transactionCount,
    required this.incomeCount,
    required this.expenseCount,
  });

  /// Factory: build summary from a list of mixed transactions.
  factory TransactionSummary.fromTransactions(
    List<TransactionEntity> transactions,
  ) {
    final incomeTransactions = transactions.where((t) => t.isIncome).toList();
    final expenseTransactions = transactions.where((t) => t.isExpense).toList();

    final totalIncome = incomeTransactions.fold(
      0.0,
      (sum, t) => sum + t.amount,
    );
    final totalExpenses = expenseTransactions.fold(
      0.0,
      (sum, t) => sum + t.amount,
    );

    return TransactionSummary(
      totalIncome: totalIncome,
      totalExpenses: totalExpenses,
      netBalance: totalIncome - totalExpenses,
      transactionCount: transactions.length,
      incomeCount: incomeTransactions.length,
      expenseCount: expenseTransactions.length,
    );
  }

  /// Empty sentinel.
  factory TransactionSummary.empty() => const TransactionSummary(
    totalIncome: 0,
    totalExpenses: 0,
    netBalance: 0,
    transactionCount: 0,
    incomeCount: 0,
    expenseCount: 0,
  );

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
