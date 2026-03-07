import '../entities/transaction_entity.dart';
import '../enums/transaction_type.dart';

/// Abstract contract — provides a seam for testing without a concrete data source.
abstract class TransactionRepository {
  Future<List<TransactionEntity>> getAllTransactions();
  Future<List<TransactionEntity>> getTransactionsByType(TransactionType? type);
  Future<List<TransactionEntity>> getMonthlyTransactions(DateTime month);
}

/// UseCase: GetTransactionsUseCase
///
/// Retrieves transactions filtered by optional type and month.
class GetTransactionsUseCase {
  final TransactionRepository _repository;

  const GetTransactionsUseCase(this._repository);

  Future<List<TransactionEntity>> call({
    TransactionType? type,
    DateTime? month,
  }) async {
    if (type != null) {
      return _repository.getTransactionsByType(type);
    }
    if (month != null) {
      return _repository.getMonthlyTransactions(month);
    }
    return _repository.getAllTransactions();
  }
}
