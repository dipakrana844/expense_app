/// Constants for budget-related thresholds and limits.
class BudgetConstants {
  /// Threshold percentage (0.0 - 1.0) for near-budget warning
  static const double nearBudgetThreshold = 0.8; // 80%

  /// Threshold percentage (0.0 - 1.0) for over-budget alert
  static const double overBudgetThreshold = 1.0; // 100%

  /// Maximum allowed budget amount (10 crore)
  static const double maxBudgetAmount = 10000000;

  /// Minimum allowed budget amount (0)
  static const double minBudgetAmount = 0.0;

  /// Default currency symbol
  static const String defaultCurrency = '₹';

  /// Debounce delay in milliseconds for budget updates
  static const int budgetUpdateDebounceMs = 500;
}
