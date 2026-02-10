import '../constants/app_constants.dart';

/// Utility class: SharedValidationUtils
///
/// Purpose: Centralize validation logic that was duplicated across features
/// - Amount validation with consistent rules
/// - Date validation with proper constraints
/// - Note/content validation with length limits
/// - Entity-specific validations
///
/// Design Principles:
/// 1. Single source of truth for validation rules
/// 2. Reusable across all features and entities
/// 3. Configurable thresholds via AppConstants
/// 4. Clear error messages for user feedback
class SharedValidationUtils {
  SharedValidationUtils._();

  /// Validate monetary amount
  ///
  /// Parameters:
  /// - value: String value to validate
  /// - fieldName: Name of field for error messages (default: 'Amount')
  /// - allowNull: Whether null/empty values are acceptable (default: false)
  ///
  /// Returns: null if valid, error message if invalid
  static String? validateAmount(
    String? value, {
    String fieldName = 'Amount',
    bool allowNull = false,
  }) {
    if (value == null || value.trim().isEmpty) {
      return allowNull ? null : '$fieldName is required';
    }

    final amount = _parseAmount(value);
    if (amount == null) {
      return 'Invalid $fieldName format';
    }

    if (amount <= 0) {
      return '$fieldName must be greater than 0';
    }

    if (amount > AppConstants.maxExpenseAmount) {
      return '$fieldName is too large (maximum ${AppConstants.maxExpenseAmount})';
    }

    return null;
  }

  /// Validate category or source name
  ///
  /// Parameters:
  /// - value: String value to validate
  /// - fieldName: Name of field for error messages (default: 'Category')
  /// - allowNull: Whether null/empty values are acceptable (default: false)
  ///
  /// Returns: null if valid, error message if invalid
  static String? validateCategoryOrSource(
    String? value, {
    String fieldName = 'Category',
    bool allowNull = false,
  }) {
    if (value == null || value.trim().isEmpty) {
      return allowNull ? null : '$fieldName is required';
    }

    return null;
  }

  /// Validate note or description
  ///
  /// Parameters:
  /// - value: String value to validate
  /// - fieldName: Name of field for error messages (default: 'Note')
  /// - maxLength: Maximum allowed length (default: AppConstants.maxNoteLength)
  /// - allowNull: Whether null/empty values are acceptable (default: true)
  ///
  /// Returns: null if valid, error message if invalid
  static String? validateNote(
    String? value, {
    String fieldName = 'Note',
    int? maxLength,
    bool allowNull = true,
  }) {
    if (value == null || value.isEmpty) {
      return allowNull ? null : '$fieldName is required';
    }

    final maxLen = maxLength ?? AppConstants.maxNoteLength;
    if (value.length > maxLen) {
      return '$fieldName is too long (maximum $maxLen characters)';
    }

    return null;
  }

  /// Validate date
  ///
  /// Parameters:
  /// - value: DateTime value to validate
  /// - fieldName: Name of field for error messages (default: 'Date')
  /// - allowFuture: Whether future dates are acceptable (default: false)
  /// - maxFutureDays: Maximum days in future allowed (default: 1)
  ///
  /// Returns: null if valid, error message if invalid
  static String? validateDate(
    DateTime? value, {
    String fieldName = 'Date',
    bool allowFuture = false,
    int maxFutureDays = 1,
  }) {
    if (value == null) {
      return '$fieldName is required';
    }

    if (!allowFuture && value.isAfter(DateTime.now())) {
      return '$fieldName cannot be in the future';
    }

    if (allowFuture && value.isAfter(DateTime.now().add(Duration(days: maxFutureDays)))) {
      return '$fieldName cannot be more than $maxFutureDays days in the future';
    }

    return null;
  }

  /// Validate ID
  ///
  /// Parameters:
  /// - value: String value to validate
  /// - fieldName: Name of field for error messages (default: 'ID')
  ///
  /// Returns: null if valid, error message if invalid
  static String? validateId(
    String? value, {
    String fieldName = 'ID',
  }) {
    if (value == null || value.isEmpty) {
      return '$fieldName cannot be empty';
    }

    return null;
  }

  /// Parse amount string to double
  ///
  /// Parameters:
  /// - text: String containing numeric value
  ///
  /// Returns: Parsed double value or null if invalid
  static double? _parseAmount(String text) {
    try {
      // Remove currency symbol and commas
      final cleaned = text
          .replaceAll(AppConstants.currencySymbol, '')
          .replaceAll(',', '')
          .trim();
      return double.parse(cleaned);
    } catch (e) {
      return null;
    }
  }

  /// Validate entity data using TransactionInterface
  ///
  /// Parameters:
  /// - entity: TransactionInterface implementation to validate
  ///
  /// Returns: List of validation errors (empty if valid)
  static List<String> validateEntity(dynamic entity) {
    final errors = <String>[];
    
    // Check if entity has validate method
    if (entity is dynamic && entity.runtimeType.toString().contains('Entity')) {
      try {
        final result = entity.validate();
        if (result != null) {
          errors.add(result);
        }
      } catch (e) {
        errors.add('Validation failed: ${e.toString()}');
      }
    }
    
    return errors;
  }

  /// Combine multiple validation results
  ///
  /// Parameters:
  /// - validations: Map of field names to validation functions
  ///
  /// Returns: Map of field names to error messages (empty if all valid)
  static Map<String, String> validateMultiple(Map<String, String? Function()> validations) {
    final errors = <String, String>{};
    
    validations.forEach((field, validator) {
      final result = validator();
      if (result != null) {
        errors[field] = result;
      }
    });
    
    return errors;
  }
}