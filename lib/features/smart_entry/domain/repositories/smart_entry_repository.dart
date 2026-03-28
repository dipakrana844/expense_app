import '../entities/smart_entry_entity.dart';
import '../enums/transaction_mode.dart';

/// Repository interface for smart entry operations.
/// Follows the dependency inversion principle - domain depends on abstraction.
abstract class SmartEntryRepository {
  /// Saves a smart entry (create or update)
  /// Returns the saved entry or throws a Failure
  Future<SmartEntryEntity> saveEntry(SmartEntryEntity entry);

  /// Gets an entry by ID
  /// Returns null if not found
  Future<SmartEntryEntity?> getEntryById(String id);

  /// Gets all entries within a date range
  Future<List<SmartEntryEntity>> getEntriesByDateRange(
    DateTime start,
    DateTime end,
  );

  /// Deletes an entry by ID
  Future<void> deleteEntry(String id);

  /// Checks for duplicate entries (same amount, category/source, within time window)
  /// Returns true if a duplicate exists
  Future<bool> checkDuplicate({
    required double amount,
    required TransactionMode mode,
    String? category,
    String? source,
    String? fromAccount,
    String? toAccount,
    Duration timeWindow = const Duration(hours: 2),
  });

  /// Gets recent entries for suggestions
  Future<List<SmartEntryEntity>> getRecentEntries({int limit = 10});
}
