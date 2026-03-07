import '../entities/transaction_summary.dart';
import '../entities/transaction_entity.dart';

/// UseCase: GetMonthlySummaryUseCase
///
/// Computes a TransactionSummary aggregate for a given list of transactions.
/// The summary calculation is pure domain logic — no IO required.
class GetMonthlySummaryUseCase {
  const GetMonthlySummaryUseCase();

  TransactionSummary call(List<TransactionEntity> transactions) {
    return TransactionSummary.fromTransactions(transactions);
  }
}
