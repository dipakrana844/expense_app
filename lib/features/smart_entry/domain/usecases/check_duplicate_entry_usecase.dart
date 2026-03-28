import '../enums/transaction_mode.dart';
import '../repositories/smart_entry_repository.dart';

/// Use case for checking duplicate entries
/// Encapsulates duplicate detection business logic
class CheckDuplicateEntryUseCase {
  final SmartEntryRepository repository;

  CheckDuplicateEntryUseCase(this.repository);

  /// Checks if a similar entry exists within the time window
  Future<bool> execute({
    required double amount,
    required TransactionMode mode,
    String? category,
    String? source,
    String? fromAccount,
    String? toAccount,
    Duration timeWindow = const Duration(hours: 2),
  }) async {
    return await repository.checkDuplicate(
      amount: amount,
      mode: mode,
      category: category,
      source: source,
      fromAccount: fromAccount,
      toAccount: toAccount,
      timeWindow: timeWindow,
    );
  }
}
