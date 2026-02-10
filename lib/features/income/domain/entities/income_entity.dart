import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/domain/interfaces/transaction_interface.dart';

part 'income_entity.freezed.dart';

/// Domain Entity: Income
///
/// Pure business logic representation of an income record.
/// - Immutable: Uses Freezed to ensure state cannot be mutated accidentally
/// - No dependencies on data layer or frameworks
/// - Contains only business rules and data
///
/// Design Decision: Keep entity separate from data model to maintain clean architecture
/// boundaries and allow independent evolution of domain and data layers
@freezed
class IncomeEntity with _$IncomeEntity implements TransactionInterface {
  const IncomeEntity._(); // Private constructor for custom methods

  const factory IncomeEntity({
    required String id,
    required double amount,
    required String source,
    required DateTime date,
    String? note,
    required DateTime createdAt,
    DateTime? updatedAt,
    Map<String, dynamic>? metadata,
  }) = _IncomeEntity;

  /// Business Logic: Check if income is from today
  bool get isToday {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// Business Logic: Check if income is from current month
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

  /// Business Logic: Check if income was recently modified
  @override
  bool get wasModified => updatedAt != null;

  /// Business Logic: Get source (alias for consistent interface)
  String get categoryOrSource => source;

  /// Business Logic: Check if this is an income transaction
  @override
  bool get isIncome => true;

  /// Business Logic: Check if this is an expense transaction
  @override
  bool get isExpense => false;

  /// Business Logic: Get amount as positive value for display
  @override
  double get displayAmount => amount.abs();

  /// Business Logic: Validate income data
  /// Returns null if valid, error message if invalid
  @override
  String? validate() {
    if (id.isEmpty) return 'ID cannot be empty';
    if (amount <= 0) return 'Amount must be greater than 0';
    if (source.isEmpty) return 'Source is required';
    if (date.isAfter(DateTime.now().add(const Duration(days: 1)))) return 'Date cannot be too far in the future';
    if (note != null && note!.length > 500) return 'Note is too long';

    return null; // Valid
  }
}