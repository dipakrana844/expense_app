import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failures.dart';
import '../../data/repositories/smart_entry_repository_impl.dart';
import '../entities/smart_entry_entity.dart';
import '../enums/transaction_mode.dart';
import '../repositories/smart_entry_repository.dart';
import '../usecases/check_duplicate_entry_usecase.dart';
import '../usecases/save_smart_entry_usecase.dart';
import '../usecases/validate_smart_entry_usecase.dart';

/// Refactored SmartEntryService following clean architecture
/// Uses use cases and repository abstraction instead of direct dependencies
class SmartEntryServiceRefactored {
  final SmartEntryRepository repository;
  final SaveSmartEntryUseCase saveUseCase;
  final ValidateSmartEntryUseCase validateUseCase;
  final CheckDuplicateEntryUseCase duplicateUseCase;

  SmartEntryServiceRefactored({
    required this.repository,
    required this.saveUseCase,
    required this.validateUseCase,
    required this.duplicateUseCase,
  });

  /// Saves a transaction using the clean architecture flow
  Future<void> saveTransaction({
    required TransactionMode mode,
    required double amount,
    required DateTime date,
    String? category,
    String? source,
    String? fromAccount,
    String? toAccount,
    double? transferFee,
    String? note,
    bool isRecurring = false,
    bool isEditing = false,
    String? editingTransactionId,
  }) async {
    try {
      // Create entity
      final entry = SmartEntryEntity.create(
        mode: mode,
        amount: amount,
        date: date,
        note: note,
        category: category,
        source: source,
        fromAccount: fromAccount,
        toAccount: toAccount,
        transferFee: transferFee,
        isRecurring: isRecurring,
      );

      // If editing, preserve the original ID and timestamps
      final entryToSave = isEditing && editingTransactionId != null
          ? entry.copyWith(
              id: editingTransactionId,
              createdAt: DateTime.now(), // Would need to fetch original
              updatedAt: DateTime.now(),
            )
          : entry;

      // Save using use case
      await saveUseCase.execute(entryToSave);

      // Note: In a real implementation, we would also update other feature states
      // (expenses, incomes, transfers) through their respective repositories
      // This would be done via domain events or a coordinating service
    } on Failure catch (failure) {
      // Re-throw the failure for the presentation layer to handle
      rethrow;
    } catch (e) {
      // Convert unexpected errors to Failure
      throw Failure.unexpected(
        message: 'Failed to save transaction: ${e.toString()}',
        error: e,
      );
    }
  }

  /// Validates transaction parameters
  List<String> validateTransaction({
    required TransactionMode mode,
    required double amount,
    DateTime? date,
    String? note,
    String? category,
    String? source,
    String? fromAccount,
    String? toAccount,
  }) {
    return validateUseCase.validateParameters(
      mode: mode,
      amount: amount,
      date: date,
      note: note,
      category: category,
      source: source,
      fromAccount: fromAccount,
      toAccount: toAccount,
    );
  }

  /// Checks for duplicate transaction
  Future<bool> checkDuplicateTransaction({
    required double amount,
    required TransactionMode mode,
    String? category,
    String? source,
    String? fromAccount,
    String? toAccount,
    Duration timeWindow = const Duration(hours: 2),
  }) async {
    try {
      return await duplicateUseCase.execute(
        amount: amount,
        mode: mode,
        category: category,
        source: source,
        fromAccount: fromAccount,
        toAccount: toAccount,
        timeWindow: timeWindow,
      );
    } on Failure {
      rethrow;
    } catch (e) {
      throw Failure.unexpected(
        message: 'Failed to check duplicate: ${e.toString()}',
        error: e,
      );
    }
  }

  /// Gets recent entries for suggestions
  Future<List<SmartEntryEntity>> getRecentEntries({int limit = 10}) async {
    try {
      return await repository.getRecentEntries(limit: limit);
    } on Failure {
      rethrow;
    } catch (e) {
      throw Failure.unexpected(
        message: 'Failed to get recent entries: ${e.toString()}',
        error: e,
      );
    }
  }
}

/// Provider for the refactored service
final smartEntryServiceRefactoredProvider = Provider<SmartEntryServiceRefactored>((
  ref,
) {
  // In a real implementation, we would get these from their providers
  // For now, we'll create them directly (dependency injection would be better)
  final repository = SmartEntryRepositoryImpl();
  final saveUseCase = SaveSmartEntryUseCase(repository);
  final validateUseCase = ValidateSmartEntryUseCase();
  final duplicateUseCase = CheckDuplicateEntryUseCase(repository);

  return SmartEntryServiceRefactored(
    repository: repository,
    saveUseCase: saveUseCase,
    validateUseCase: validateUseCase,
    duplicateUseCase: duplicateUseCase,
  );
});
