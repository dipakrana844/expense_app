import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/domain/interfaces/transaction_interface.dart';

part 'transfer_entity.freezed.dart';

/// Domain Entity: Transfer
///
/// Pure business logic representation of a transfer between accounts.
/// - Immutable: Uses Freezed to ensure state cannot be mutated accidentally
/// - No dependencies on data layer or frameworks
/// - Contains only business rules and data
///
/// Design Decision: Keep entity separate from data model to maintain clean architecture
/// boundaries and allow independent evolution of domain and data layers
@freezed
class TransferEntity with _$TransferEntity implements TransactionInterface {
  const TransferEntity._();

  const factory TransferEntity({
    required String id,
    required double amount,
    required String fromAccount,
    required String toAccount,
    required DateTime date,
    @Default(0.0) double fee,
    String? note,
    required DateTime createdAt,
    DateTime? updatedAt,
    Map<String, dynamic>? metadata,
  }) = _TransferEntity;

  /// Business Logic: Check if transfer is from today
  bool get isToday {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// Business Logic: Check if transfer is from current month
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

  /// Business Logic: Check if transfer was recently modified
  @override
  bool get wasModified => updatedAt != null;

  /// Business Logic: Get source (returns fromAccount for consistent interface)
  @override
  String get categoryOrSource => '$fromAccount → $toAccount';

  /// Business Logic: Check if this is an income transaction (false for transfer)
  @override
  bool get isIncome => false;

  /// Business Logic: Check if this is an expense transaction (false for transfer)
  @override
  bool get isExpense => false;

  /// Business Logic: Get amount as positive value for display
  @override
  double get displayAmount => amount.abs();

  /// Business Logic: Get total amount including fee
  double get totalAmount => amount + fee;

  /// Business Logic: Validate transfer data
  /// Returns null if valid, error message if invalid
  @override
  String? validate() {
    if (id.isEmpty) return 'ID cannot be empty';
    if (amount <= 0) return 'Amount must be greater than 0';
    if (fromAccount.isEmpty) return 'From account is required';
    if (toAccount.isEmpty) return 'To account is required';
    if (fromAccount == toAccount) return 'Cannot transfer to the same account';
    if (fee < 0) return 'Fee cannot be negative';
    if (date.isAfter(DateTime.now().add(const Duration(days: 1)))) {
      return 'Date cannot be too far in the future';
    }
    if (note != null && note!.length > 500) return 'Note is too long';

    return null; // Valid
  }
}
