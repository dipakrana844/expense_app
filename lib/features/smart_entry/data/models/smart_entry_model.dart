import 'package:hive/hive.dart';

import '../../domain/entities/smart_entry_entity.dart';
import '../../domain/enums/transaction_mode.dart';

part 'smart_entry_model.g.dart';

/// Data model for Hive storage
/// Maps between domain entity and persistence model
@HiveType(typeId: 100) // Use a unique typeId
class SmartEntryModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final int modeIndex; // Store enum as index

  @HiveField(2)
  final double amount;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final String? note;

  @HiveField(5)
  final String? category;

  @HiveField(6)
  final String? source;

  @HiveField(7)
  final String? fromAccount;

  @HiveField(8)
  final String? toAccount;

  @HiveField(9)
  final double? transferFee;

  @HiveField(10)
  final bool isRecurring;

  @HiveField(11)
  final DateTime createdAt;

  @HiveField(12)
  final DateTime updatedAt;

  @HiveField(13)
  final Map<String, dynamic> metadata;

  SmartEntryModel({
    required this.id,
    required this.modeIndex,
    required this.amount,
    required this.date,
    this.note,
    this.category,
    this.source,
    this.fromAccount,
    this.toAccount,
    this.transferFee,
    required this.isRecurring,
    required this.createdAt,
    required this.updatedAt,
    required this.metadata,
  });

  /// Converts domain entity to data model
  factory SmartEntryModel.fromEntity(SmartEntryEntity entity) {
    return SmartEntryModel(
      id: entity.id,
      modeIndex: entity.mode.index,
      amount: entity.amount,
      date: entity.date,
      note: entity.note,
      category: entity.category,
      source: entity.source,
      fromAccount: entity.fromAccount,
      toAccount: entity.toAccount,
      transferFee: entity.transferFee,
      isRecurring: entity.isRecurring,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      metadata: entity.metadata,
    );
  }

  /// Converts data model to domain entity
  SmartEntryEntity toEntity() {
    return SmartEntryEntity(
      id: id,
      mode: TransactionMode.values[modeIndex],
      amount: amount,
      date: date,
      note: note,
      category: category,
      source: source,
      fromAccount: fromAccount,
      toAccount: toAccount,
      transferFee: transferFee,
      isRecurring: isRecurring,
      createdAt: createdAt,
      updatedAt: updatedAt,
      metadata: metadata,
    );
  }

  /// Creates a copy with updated values
  SmartEntryModel copyWith({
    String? id,
    int? modeIndex,
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
    return SmartEntryModel(
      id: id ?? this.id,
      modeIndex: modeIndex ?? this.modeIndex,
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
}
