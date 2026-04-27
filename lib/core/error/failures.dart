import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

/// Base Failure class using Freezed for immutable error states
/// Supports pattern matching and exhaustive error handling
@freezed
abstract class Failure with _$Failure {
  /// Local storage operation failed (Hive read/write errors)
  const factory Failure.storage({required String message, Object? error}) =
      StorageFailure;

  /// Data validation failed (invalid input)
  const factory Failure.validation({required String message, String? field}) =
      ValidationFailure;

  /// Network-related failures (for future sync features)
  const factory Failure.network({required String message, Object? error}) =
      NetworkFailure;

  /// Unexpected errors
  const factory Failure.unexpected({
    required String message,
    Object? error,
    StackTrace? stackTrace,
  }) = UnexpectedFailure;

  /// Resource not found (e.g., expense ID doesn't exist)
  const factory Failure.notFound({
    required String message,
    String? resourceId,
  }) = NotFoundFailure;
}

/// Extension to provide user-friendly error messages
/// Separates technical errors from user-facing messages
extension FailureX on Failure {
  String get userMessage {
    return when(
      storage: (msg, _) => 'Storage error: $msg',
      validation: (msg, field) => field != null ? '$field: $msg' : msg,
      network: (msg, _) => 'Network error: $msg',
      unexpected: (msg, _, _) => 'An unexpected error occurred: $msg',
      notFound: (msg, _) => msg,
    );
  }

  /// Whether this failure should be logged for debugging
  bool get shouldLog {
    return when(
      storage: (_, _) => true,
      validation: (_, _) => false, // Validation errors are expected
      network: (_, _) => true,
      unexpected: (_, _, _) => true,
      notFound: (_, _) => false,
    );
  }
}
