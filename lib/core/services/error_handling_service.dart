import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Comprehensive error handling service for the expense tracking application
class ErrorHandlingService {
  static final ErrorHandlingService _instance = ErrorHandlingService._internal();
  factory ErrorHandlingService() => _instance;
  ErrorHandlingService._internal();

  /// Handle different types of errors with appropriate user feedback
  Future<void> handleError(
    Object error,
    StackTrace stackTrace, {
    required BuildContext? context,
    String? userMessage,
    bool showSnackBar = true,
    bool logError = true,
  }) async {
    if (logError) {
      _logError(error, stackTrace);
    }

    if (showSnackBar && context != null && context.mounted) {
      final message = userMessage ?? _getUserFriendlyMessage(error);
      _showErrorSnackBar(context, message);
    }
  }

  /// Handle validation errors with specific formatting
  void handleValidationError(
    List<String> errors, {
    required BuildContext context,
  }) {
    if (errors.isEmpty) return;

    final message = errors.length == 1 
        ? errors.first 
        : 'Please fix the following issues:\n• ${errors.join('\n• ')}';

    _showErrorSnackBar(context, message);
  }

  /// Handle network errors with retry capability
  Future<bool> handleNetworkError({
    required BuildContext context,
    required Future<void> Function() retryFunction,
    String? customMessage,
  }) async {
    final message = customMessage ?? 'Network connection failed. Please check your internet connection.';
    
    return _showRetryDialog(
      context: context,
      message: message,
      retryFunction: retryFunction,
    );
  }

  /// Handle database/storage errors
  void handleStorageError(
    Object error,
    StackTrace stackTrace, {
    required BuildContext context,
    String? operation,
  }) {
    _logError(error, stackTrace);
    
    final message = operation != null 
        ? 'Failed to $operation. Please try again.'
        : 'Data storage error occurred. Please restart the app.';
    
    _showErrorSnackBar(context, message);
  }

  /// Handle critical errors that require app restart
  void handleCriticalError({
    required BuildContext context,
    required Object error,
    required StackTrace stackTrace,
  }) {
    _logError(error, stackTrace);
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Critical Error'),
        content: const Text(
          'An unexpected error occurred that requires the app to restart. '
          'Please restart the application and try again.'
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // In a real app, this would trigger app restart
              // SystemNavigator.pop(); // For example
            },
            child: const Text('Restart App'),
          ),
        ],
      ),
    );
  }

  /// Get user-friendly error messages based on error type
  String _getUserFriendlyMessage(Object error) {
    if (error is TimeoutException) {
      return 'Request timed out. Please try again.';
    } else if (error is FormatException) {
      return 'Invalid data format. Please check your input.';
    } else if (error is RangeError) {
      return 'Value is out of acceptable range.';
    } else if (error is ArgumentError) {
      return 'Invalid argument provided.';
    } else if (error is StateError) {
      return 'Application state error. Please try again.';
    } else if (error is Exception) {
      return error.toString().replaceAll('Exception:', '').trim();
    } else {
      return 'An unexpected error occurred. Please try again.';
    }
  }

  /// Log error to console and analytics
  void _logError(Object error, StackTrace stackTrace) {
    // In production, this would send to error reporting service
    if (kDebugMode) {
      debugPrint('ERROR: $error');
      debugPrint('STACK TRACE: $stackTrace');
    }
    
    // TODO: Integrate with error reporting service like Sentry/Firebase Crashlytics
    // Example: FirebaseCrashlytics.instance.recordError(error, stackTrace);
  }

  /// Show error snackbar with consistent styling
  void _showErrorSnackBar(BuildContext context, String message) {
    if (!context.mounted) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  /// Show retry dialog for recoverable errors
  Future<bool> _showRetryDialog({
    required BuildContext context,
    required String message,
    required Future<void> Function() retryFunction,
  }) async {
    if (!context.mounted) return false;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Connection Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Retry'),
          ),
        ],
      ),
    );

    if (result == true) {
      try {
        await retryFunction();
        return true;
      } catch (e, s) {
        await handleError(e, s, context: context);
        return false;
      }
    }
    
    return false;
  }

  /// Handle form validation errors with field-specific feedback
  void handleFormErrors({
    required Map<String, String> fieldErrors,
    required BuildContext context,
  }) {
    if (fieldErrors.isEmpty) return;

    final errorList = fieldErrors.entries
        .map((entry) => '${entry.key}: ${entry.value}')
        .toList();

    handleValidationError(errorList, context: context);
  }

  /// Handle transaction-specific errors
  void handleTransactionError({
    required Object error,
    required BuildContext context,
    String? transactionType,
  }) {
    String userMessage;
    
    if (error.toString().contains('balance') || error.toString().contains('insufficient')) {
      userMessage = 'Insufficient account balance for this transaction.';
    } else if (error.toString().contains('duplicate') || error.toString().contains('exists')) {
      userMessage = 'This transaction already exists.';
    } else if (error.toString().contains('validation')) {
      userMessage = 'Transaction validation failed. Please check your inputs.';
    } else {
      userMessage = transactionType != null
          ? 'Failed to save $transactionType. Please try again.'
          : 'Failed to save transaction. Please try again.';
    }

    handleError(
      error,
      StackTrace.current,
      context: context,
      userMessage: userMessage,
    );
  }

  /// Handle account-related errors
  void handleAccountError({
    required Object error,
    required BuildContext context,
    String? accountName,
  }) {
    String userMessage;
    
    if (error.toString().contains('not found')) {
      userMessage = accountName != null 
          ? 'Account "$accountName" not found.'
          : 'Account not found.';
    } else if (error.toString().contains('already exists')) {
      userMessage = 'Account already exists.';
    } else {
      userMessage = 'Account operation failed. Please try again.';
    }

    handleError(
      error,
      StackTrace.current,
      context: context,
      userMessage: userMessage,
    );
  }
}

/// Extension to add error handling capabilities to BuildContext
extension ErrorHandlingContext on BuildContext {
  /// Quick access to error handling service
  ErrorHandlingService get errorService => ErrorHandlingService();
  
  /// Handle error with current context
  Future<void> handleError(
    Object error,
    StackTrace stackTrace, {
    String? userMessage,
    bool showSnackBar = true,
    bool logError = true,
  }) async {
    await ErrorHandlingService().handleError(
      error,
      stackTrace,
      context: this,
      userMessage: userMessage,
      showSnackBar: showSnackBar,
      logError: logError,
    );
  }
  
  /// Handle validation errors
  void handleValidationErrors(List<String> errors) {
    ErrorHandlingService().handleValidationError(errors, context: this);
  }
  
  /// Handle network errors with retry
  Future<bool> handleNetworkError({
    required Future<void> Function() retryFunction,
    String? customMessage,
  }) async {
    return ErrorHandlingService().handleNetworkError(
      context: this,
      retryFunction: retryFunction,
      customMessage: customMessage,
    );
  }
}