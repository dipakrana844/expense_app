import '../enums/category_type.dart';
import '../failures/category_failure.dart';

/// Validation rules for category operations.
/// Provides centralized validation logic with detailed error messages.
class CategoryValidator {
  /// Minimum length for category name
  static const int minNameLength = 1;

  /// Maximum length for category name
  static const int maxNameLength = 50;

  /// Valid characters pattern for category name (letters, numbers, spaces, and common symbols)
  static final RegExp _validNamePattern = RegExp(
    r'^[\p{L}\p{N}\s\-_.,&()]+$',
    unicode: true,
  );

  /// Validates a category name
  static Result<void> validateName(String name) {
    final trimmedName = name.trim();

    if (trimmedName.isEmpty) {
      return Result.failure(
        const ValidationFailure(
          message: 'Category name cannot be empty',
          field: 'name',
        ),
      );
    }

    if (trimmedName.length < minNameLength) {
      return Result.failure(
        ValidationFailure(
          message: 'Category name must be at least $minNameLength character(s)',
          field: 'name',
        ),
      );
    }

    if (trimmedName.length > maxNameLength) {
      return Result.failure(
        ValidationFailure(
          message: 'Category name cannot exceed $maxNameLength characters',
          field: 'name',
        ),
      );
    }

    if (!_validNamePattern.hasMatch(trimmedName)) {
      return Result.failure(
        const ValidationFailure(
          message: 'Category name contains invalid characters',
          field: 'name',
        ),
      );
    }

    return Result.success(null);
  }

  /// Validates a category type
  static Result<void> validateType(String type) {
    try {
      CategoryType.fromString(type);
      return Result.success(null);
    } catch (e) {
      return Result.failure(
        ValidationFailure(
          message: 'Invalid category type. Must be "income" or "expense"',
          field: 'type',
        ),
      );
    }
  }

  /// Validates a category type (enum version)
  static Result<void> validateTypeEnum(CategoryType type) {
    // Enum is always valid, but this method exists for consistency
    return Result.success(null);
  }

  /// Validates icon code point
  static Result<void> validateIconCodePoint(int iconCodePoint) {
    if (iconCodePoint < 0) {
      return Result.failure(
        const ValidationFailure(
          message: 'Icon code point must be a positive integer',
          field: 'iconCodePoint',
        ),
      );
    }

    // Check if it's within valid Unicode range (basic multilingual plane)
    if (iconCodePoint > 0xFFFF) {
      return Result.failure(
        const ValidationFailure(
          message: 'Icon code point exceeds valid Unicode range',
          field: 'iconCodePoint',
        ),
      );
    }

    return Result.success(null);
  }

  /// Validates color value
  static Result<void> validateColorValue(int colorValue) {
    if (colorValue < 0 || colorValue > 0xFFFFFFFF) {
      return Result.failure(
        const ValidationFailure(
          message: 'Color value must be a valid 32-bit ARGB color',
          field: 'colorValue',
        ),
      );
    }

    return Result.success(null);
  }

  /// Validates category ID
  static Result<void> validateId(String id) {
    if (id.isEmpty) {
      return Result.failure(
        const ValidationFailure(
          message: 'Category ID cannot be empty',
          field: 'id',
        ),
      );
    }

    // Check for valid UUID format (basic validation)
    final uuidPattern = RegExp(
      r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$',
    );

    if (!uuidPattern.hasMatch(id)) {
      return Result.failure(
        const ValidationFailure(
          message: 'Category ID must be a valid UUID',
          field: 'id',
        ),
      );
    }

    return Result.success(null);
  }

  /// Validates all category fields
  static Result<void> validateCategory({
    required String id,
    required String name,
    required String type,
    required int iconCodePoint,
    required int colorValue,
  }) {
    final idResult = validateId(id);
    if (idResult.isFailure) return idResult;

    final nameResult = validateName(name);
    if (nameResult.isFailure) return nameResult;

    final typeResult = validateType(type);
    if (typeResult.isFailure) return typeResult;

    final iconResult = validateIconCodePoint(iconCodePoint);
    if (iconResult.isFailure) return iconResult;

    final colorResult = validateColorValue(colorValue);
    if (colorResult.isFailure) return colorResult;

    return Result.success(null);
  }

  /// Normalizes a category name for comparison
  static String normalizeName(String name) {
    return name.trim().toLowerCase();
  }

  /// Checks if two category names are equivalent (case-insensitive, trimmed)
  static bool namesMatch(String name1, String name2) {
    return normalizeName(name1) == normalizeName(name2);
  }
}
