import '../../../../core/error/failures.dart';
import '../entities/smart_entry_entity.dart';
import '../enums/transaction_mode.dart';

/// Use case for validating a smart entry
/// Encapsulates validation business logic
class ValidateSmartEntryUseCase {
  /// Validates the entry and returns a list of error messages
  /// Returns empty list if valid
  List<String> execute(SmartEntryEntity entry) {
    return entry.validate();
  }

  /// Validates the entry and throws ValidationFailure if invalid
  /// Returns nothing if valid
  void executeWithThrow(SmartEntryEntity entry) {
    final errors = entry.validate();
    if (errors.isNotEmpty) {
      throw Failure.validation(message: errors.join(', '), field: null);
    }
  }

  /// Validates entry parameters without creating an entity
  List<String> validateParameters({
    required TransactionMode mode,
    required double amount,
    DateTime? date,
    String? note,
    String? category,
    String? source,
    String? fromAccount,
    String? toAccount,
  }) {
    final errors = <String>[];

    if (amount <= 0) {
      errors.add('Amount must be greater than 0');
    }

    if (amount > 1000000) {
      errors.add('Amount exceeds maximum limit');
    }

    switch (mode) {
      case TransactionMode.expense:
        if (category == null || category.isEmpty) {
          errors.add('Category is required for expense');
        }
        break;
      case TransactionMode.income:
        if (source == null || source.isEmpty) {
          errors.add('Source is required for income');
        }
        break;
      case TransactionMode.transfer:
        if (fromAccount == null || fromAccount.isEmpty) {
          errors.add('From account is required for transfer');
        }
        if (toAccount == null || toAccount.isEmpty) {
          errors.add('To account is required for transfer');
        }
        if (fromAccount != null &&
            toAccount != null &&
            fromAccount == toAccount) {
          errors.add('Cannot transfer to the same account');
        }
        break;
    }

    final checkDate = date ?? DateTime.now();
    if (checkDate.isAfter(DateTime.now().add(const Duration(days: 1)))) {
      errors.add('Date cannot be in the future');
    }

    if (note != null && note.length > 500) {
      errors.add('Note is too long (maximum 500 characters)');
    }

    return errors;
  }
}
