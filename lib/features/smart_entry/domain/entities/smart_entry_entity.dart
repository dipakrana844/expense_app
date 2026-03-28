import '../enums/transaction_mode.dart';

/// Unified entity representing a transaction entry in the smart entry feature.
/// This entity abstracts the common properties across expense, income, and transfer.
class SmartEntryEntity {
  /// Unique identifier for the entry
  final String id;

  /// Type of transaction
  final TransactionMode mode;

  /// Transaction amount (positive)
  final double amount;

  /// Date of transaction
  final DateTime date;

  /// Optional note
  final String? note;

  /// For expense: category
  final String? category;

  /// For income: source
  final String? source;

  /// For transfer: from account
  final String? fromAccount;

  /// For transfer: to account
  final String? toAccount;

  /// For transfer: optional fee
  final double? transferFee;

  /// Whether this is a recurring transaction
  final bool isRecurring;

  /// When the entry was created
  final DateTime createdAt;

  /// When the entry was last updated
  final DateTime updatedAt;

  /// Additional metadata (JSON serializable)
  final Map<String, dynamic> metadata;

  const SmartEntryEntity({
    required this.id,
    required this.mode,
    required this.amount,
    required this.date,
    this.note,
    this.category,
    this.source,
    this.fromAccount,
    this.toAccount,
    this.transferFee,
    this.isRecurring = false,
    required this.createdAt,
    required this.updatedAt,
    this.metadata = const {},
  });

  /// Creates a new entry with current timestamps
  factory SmartEntryEntity.create({
    required TransactionMode mode,
    required double amount,
    required DateTime date,
    String? note,
    String? category,
    String? source,
    String? fromAccount,
    String? toAccount,
    double? transferFee,
    bool isRecurring = false,
    Map<String, dynamic> metadata = const {},
  }) {
    final now = DateTime.now();
    return SmartEntryEntity(
      id: 'entry_${now.millisecondsSinceEpoch}_${DateTime.now().microsecondsSinceEpoch}',
      mode: mode,
      amount: amount,
      date: date,
      note: note,
      category: category,
      source: source,
      fromAccount: fromAccount,
      toAccount: toAccount,
      transferFee: transferFee,
      isRecurring: isRecurring,
      createdAt: now,
      updatedAt: now,
      metadata: metadata,
    );
  }

  /// Validates the entity for business rules
  List<String> validate() {
    final errors = <String>[];

    if (amount <= 0) {
      errors.add('Amount must be greater than 0');
    }

    if (amount > 1000000) {
      // Reasonable maximum
      errors.add('Amount exceeds maximum limit');
    }

    switch (mode) {
      case TransactionMode.expense:
        if (category == null || category!.isEmpty) {
          errors.add('Category is required for expense');
        }
        break;
      case TransactionMode.income:
        if (source == null || source!.isEmpty) {
          errors.add('Source is required for income');
        }
        break;
      case TransactionMode.transfer:
        if (fromAccount == null || fromAccount!.isEmpty) {
          errors.add('From account is required for transfer');
        }
        if (toAccount == null || toAccount!.isEmpty) {
          errors.add('To account is required for transfer');
        }
        if (fromAccount != null &&
            toAccount != null &&
            fromAccount == toAccount) {
          errors.add('Cannot transfer to the same account');
        }
        break;
    }

    if (date.isAfter(DateTime.now().add(const Duration(days: 1)))) {
      errors.add('Date cannot be in the future');
    }

    if (note != null && note!.length > 500) {
      errors.add('Note is too long (maximum 500 characters)');
    }

    return errors;
  }

  /// Checks if the entity is valid
  bool get isValid => validate().isEmpty;

  /// Creates a copy with updated values
  SmartEntryEntity copyWith({
    String? id,
    TransactionMode? mode,
    double? amount,
    DateTime? date,
    String? note,
    String? category,
    String? source,
    String? fromAccount,
    String? toAccount,
    double? transferFee,
    bool? isRecurring,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, dynamic>? metadata,
  }) {
    return SmartEntryEntity(
      id: id ?? this.id,
      mode: mode ?? this.mode,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      note: note ?? this.note,
      category: category ?? this.category,
      source: source ?? this.source,
      fromAccount: fromAccount ?? this.fromAccount,
      toAccount: toAccount ?? this.toAccount,
      transferFee: transferFee ?? this.transferFee,
      isRecurring: isRecurring ?? this.isRecurring,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      metadata: metadata ?? this.metadata,
    );
  }

  /// Creates a copy with updated timestamp
  SmartEntryEntity withUpdate() {
    return copyWith(updatedAt: DateTime.now());
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SmartEntryEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'SmartEntryEntity(id: $id, mode: $mode, amount: $amount, date: $date)';
  }
}
