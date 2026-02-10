/// Interface: TransactionInterface
///
/// Purpose: Define common contract for all transaction-like entities
/// - Enables generic aggregation services
/// - Provides consistent property access across income/expense/transaction entities
/// - Supports polymorphic operations
///
/// Implementation Notes:
/// - IncomeEntity, ExpenseEntity, and TransactionEntity should implement this
/// - All implementing classes must provide these core properties
/// - Business logic methods should be consistent across implementations
abstract class TransactionInterface {
  /// Unique identifier for the transaction
  String get id;

  /// Monetary amount of the transaction
  double get amount;

  /// Date when the transaction occurred
  DateTime get date;

  /// Optional note or description
  String? get note;

  /// Creation timestamp
  DateTime get createdAt;

  /// Last modification timestamp (nullable)
  DateTime? get updatedAt;

  /// Additional metadata (implementation-specific)
  Map<String, dynamic>? get metadata;

  /// Get category or source name (unified accessor)
  String get categoryOrSource;

  /// Check if this is an income transaction
  bool get isIncome;

  /// Check if this is an expense transaction
  bool get isExpense;

  /// Get formatted date key for grouping (YYYY-MM-DD)
  String get dateKey;

  /// Get month key for analytics (YYYY-MM)
  String get monthKey;

  /// Check if transaction is from current month
  bool get isCurrentMonth;

  /// Check if transaction was recently modified
  bool get wasModified;

  /// Get amount as positive value for display purposes
  double get displayAmount;

  /// Validate transaction data
  /// Returns null if valid, error message if invalid
  String? validate();
}