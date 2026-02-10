import 'package:freezed_annotation/freezed_annotation.dart';
import '../enums/transaction_type.dart';
import '../../../../core/domain/interfaces/transaction_interface.dart';

part 'transaction_entity.freezed.dart';

/// Domain Entity: Unified Transaction
///
/// Represents both income and expense records in a single model.
/// This allows for seamless combination and sorting of all financial transactions.
///
/// Design Principles:
/// - Immutable: Uses Freezed for immutability and value equality
/// - Unified: Handles both income and expense types
/// - Clean: Contains only business logic, no UI or data layer concerns
@freezed
class TransactionEntity with _$TransactionEntity implements TransactionInterface {
  const TransactionEntity._(); // Private constructor for custom methods

  const factory TransactionEntity({
    required String id,
    required double amount,
    required TransactionType type,
    required String categoryOrSource,
    required DateTime date,
    String? note,
    required DateTime createdAt,
    DateTime? updatedAt,
    Map<String, dynamic>? metadata,
  }) = _TransactionEntity;

  /// Business Logic: Check if transaction is from today
  bool get isToday {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// Business Logic: Check if transaction is from current month
  @override
  bool get isCurrentMonth {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month;
  }

  /// Business Logic: Get formatted date key for grouping
  @override
  String get dateKey {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  /// Business Logic: Get month key for analytics
  @override
  String get monthKey {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}';
  }

  /// Business Logic: Check if transaction was recently modified
  @override
  bool get wasModified => updatedAt != null;

  /// Business Logic: Get display label for category/source
  String get displayCategory {
    return categoryOrSource;
  }

  /// Business Logic: Check if this is an income transaction
  @override
  bool get isIncome => type == TransactionType.income;

  /// Business Logic: Check if this is an expense transaction
  @override
  bool get isExpense => type == TransactionType.expense;

  /// Business Logic: Get amount as positive value for display
  @override
  double get displayAmount => amount.abs();

  /// Business Logic: Validate transaction data
  /// Returns null if valid, error message if invalid
  @override
  String? validate() {
    if (id.isEmpty) return 'ID cannot be empty';
    if (amount <= 0) return 'Amount must be greater than 0';
    if (categoryOrSource.isEmpty) return 'Category/Source is required';
    if (date.isAfter(DateTime.now().add(const Duration(days: 1)))) {
      return 'Date cannot be too far in the future';
    }
    if (note != null && note!.length > 500) return 'Note is too long';

    return null; // Valid
  }

  /// Business Logic: Compare transactions by date (most recent first)
  static int compareByDateDesc(TransactionEntity a, TransactionEntity b) {
    return b.date.compareTo(a.date);
  }

  /// Business Logic: Compare transactions by date (oldest first)
  static int compareByDateAsc(TransactionEntity a, TransactionEntity b) {
    return a.date.compareTo(b.date);
  }
}