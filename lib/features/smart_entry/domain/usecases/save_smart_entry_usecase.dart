import '../../../../core/error/failures.dart';
import '../entities/smart_entry_entity.dart';
import '../repositories/smart_entry_repository.dart';

/// Use case for saving a smart entry (create or update)
/// Encapsulates the business logic for saving transactions
class SaveSmartEntryUseCase {
  final SmartEntryRepository repository;

  SaveSmartEntryUseCase(this.repository);

  /// Executes the save operation
  /// Validates the entry before saving
  /// Returns the saved entry
  /// Throws Failure if validation fails or save operation fails
  Future<SmartEntryEntity> execute(SmartEntryEntity entry) async {
    // Validate the entry
    final validationErrors = entry.validate();
    if (validationErrors.isNotEmpty) {
      throw Failure.validation(
        message: validationErrors.join(', '),
        field: null,
      );
    }

    try {
      // Save to repository
      return await repository.saveEntry(entry);
    } catch (e) {
      // Convert repository exceptions to Failure
      throw Failure.unexpected(
        message: 'Failed to save entry: ${e.toString()}',
        error: e,
      );
    }
  }
}
