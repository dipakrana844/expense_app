import '../enums/category_type.dart';

/// Sealed class for category-related failures.
/// Provides type-safe error handling throughout the application.
sealed class CategoryFailure {
  const CategoryFailure();

  /// User-friendly error message
  String get message;

  /// Technical error details for logging
  String get details;
}

/// Failure when network operations fail
class NetworkFailure extends CategoryFailure {
  @override
  final String message;
  final String? technicalDetails;

  const NetworkFailure({required this.message, this.technicalDetails});

  @override
  String get details => technicalDetails ?? message;
}

/// Failure when validation fails
class ValidationFailure extends CategoryFailure {
  @override
  final String message;
  final String field;

  const ValidationFailure({required this.message, required this.field});

  @override
  String get details => 'Validation failed for field "$field": $message';
}

/// Failure when a category is not found
class NotFoundFailure extends CategoryFailure {
  final String categoryId;

  const NotFoundFailure(this.categoryId);

  @override
  String get message => 'Category not found';

  @override
  String get details => 'Category with ID "$categoryId" does not exist';
}

/// Failure when a duplicate category is detected
class DuplicateFailure extends CategoryFailure {
  final String categoryName;
  final CategoryType type;

  const DuplicateFailure({required this.categoryName, required this.type});

  @override
  String get message =>
      'A ${type.displayName} category named "$categoryName" already exists';

  @override
  String get details =>
      'Duplicate category detected: $categoryName (${type.name})';
}

/// Failure when storage operations fail
class StorageFailure extends CategoryFailure {
  @override
  final String message;
  final String? technicalDetails;

  const StorageFailure({required this.message, this.technicalDetails});

  @override
  String get details => technicalDetails ?? message;
}

/// Failure when data migration is required
class MigrationFailure extends CategoryFailure {
  @override
  final String message;
  final int currentVersion;
  final int requiredVersion;

  const MigrationFailure({
    required this.message,
    required this.currentVersion,
    required this.requiredVersion,
  });

  @override
  String get details =>
      'Migration required from version $currentVersion to $requiredVersion: $message';
}

/// Failure when an unexpected error occurs
class UnexpectedFailure extends CategoryFailure {
  @override
  final String message;
  final Exception? exception;
  final StackTrace? stackTrace;

  const UnexpectedFailure({
    required this.message,
    this.exception,
    this.stackTrace,
  });

  @override
  String get details =>
      'Unexpected error: $message${exception != null ? " - ${exception.toString()}" : ""}';
}

/// Result type for operations that can fail
class Result<T> {
  final T? data;
  final CategoryFailure? failure;

  const Result._({this.data, this.failure});

  /// Creates a successful result
  factory Result.success(T data) => Result._(data: data);

  /// Creates a failed result
  factory Result.failure(CategoryFailure failure) => Result._(failure: failure);

  /// Returns true if the result is successful
  bool get isSuccess => failure == null;

  /// Returns true if the result is a failure
  bool get isFailure => failure != null;

  /// Returns the data if successful, throws otherwise
  T get dataOrThrow {
    if (failure != null) {
      throw Exception(failure!.message);
    }
    return data!;
  }

  /// Executes onSuccess if successful, onFailure if failed
  R fold<R>({
    required R Function(T data) onSuccess,
    required R Function(CategoryFailure failure) onFailure,
  }) {
    if (isSuccess) {
      return onSuccess(data as T);
    }
    return onFailure(failure!);
  }
}
