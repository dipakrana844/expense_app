import 'package:hive/hive.dart';
import 'package:smart_expense_tracker/core/error/failures.dart';

import '../../domain/entities/smart_entry_entity.dart';
import '../../domain/enums/transaction_mode.dart';
import '../../domain/repositories/smart_entry_repository.dart';
import '../models/smart_entry_model.dart';

/// Implementation of SmartEntryRepository using Hive for local storage
class SmartEntryRepositoryImpl implements SmartEntryRepository {
  static const String _boxName = 'smart_entries';

  late Box<SmartEntryModel> _box;

  /// Initializes the Hive box
  Future<void> init() async {
    _box = await Hive.openBox<SmartEntryModel>(_boxName);
  }

  @override
  Future<SmartEntryEntity> saveEntry(SmartEntryEntity entry) async {
    try {
      await init();
      final model = SmartEntryModel.fromEntity(entry);
      await _box.put(entry.id, model);
      return entry;
    } catch (e) {
      throw Failure.storage(
        message: 'Failed to save smart entry: ${e.toString()}',
        error: e,
      );
    }
  }

  @override
  Future<SmartEntryEntity?> getEntryById(String id) async {
    try {
      await init();
      final model = _box.get(id);
      return model?.toEntity();
    } catch (e) {
      throw Failure.storage(
        message: 'Failed to get smart entry: ${e.toString()}',
        error: e,
      );
    }
  }

  @override
  Future<List<SmartEntryEntity>> getEntriesByDateRange(
    DateTime start,
    DateTime end,
  ) async {
    try {
      await init();
      final allEntries = _box.values.toList();
      final filtered = allEntries.where((model) {
        final date = model.date;
        return !date.isBefore(start) && !date.isAfter(end);
      }).toList();

      return filtered.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Failure.storage(
        message: 'Failed to get entries by date range: ${e.toString()}',
        error: e,
      );
    }
  }

  @override
  Future<void> deleteEntry(String id) async {
    try {
      await init();
      await _box.delete(id);
    } catch (e) {
      throw Failure.storage(
        message: 'Failed to delete smart entry: ${e.toString()}',
        error: e,
      );
    }
  }

  @override
  Future<bool> checkDuplicate({
    required double amount,
    required TransactionMode mode,
    String? category,
    String? source,
    String? fromAccount,
    String? toAccount,
    Duration timeWindow = const Duration(hours: 2),
  }) async {
    try {
      await init();
      final now = DateTime.now();
      final cutoff = now.subtract(timeWindow);

      final allEntries = _box.values.toList();

      for (final model in allEntries) {
        final entry = model.toEntity();

        // Check if entry is within time window
        if (entry.date.isBefore(cutoff)) continue;

        // Check if amount matches (with tolerance for floating point)
        if ((entry.amount - amount).abs() > 0.001) continue;

        // Check if mode matches
        if (entry.mode != mode) continue;

        // Mode-specific checks
        switch (mode) {
          case TransactionMode.expense:
            if (entry.category == category) return true;
            break;
          case TransactionMode.income:
            if (entry.source == source) return true;
            break;
          case TransactionMode.transfer:
            if (entry.fromAccount == fromAccount &&
                entry.toAccount == toAccount) {
              return true;
            }
            break;
        }
      }

      return false;
    } catch (e) {
      throw Failure.storage(
        message: 'Failed to check duplicate: ${e.toString()}',
        error: e,
      );
    }
  }

  @override
  Future<List<SmartEntryEntity>> getRecentEntries({int limit = 10}) async {
    try {
      await init();
      final allEntries = _box.values.toList();

      // Sort by date descending (most recent first)
      allEntries.sort((a, b) => b.date.compareTo(a.date));

      final limited = allEntries.take(limit).toList();
      return limited.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Failure.storage(
        message: 'Failed to get recent entries: ${e.toString()}',
        error: e,
      );
    }
  }

  /// Clears all entries (for testing/debugging)
  Future<void> clearAll() async {
    try {
      await init();
      await _box.clear();
    } catch (e) {
      throw Failure.storage(
        message: 'Failed to clear entries: ${e.toString()}',
        error: e,
      );
    }
  }
}
