import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/entities/expense_entity.dart';

part 'expense_model.freezed.dart';
part 'expense_model.g.dart';

/// Data Model: ExpenseModel
///
/// Purpose: Data transfer object for Hive persistence
/// - Handles serialization/deserialization to Hive
/// - Converts between domain entity and persisted data
/// - Annotated with Hive type adapters for efficient storage
///
/// Design Decision: Separate model from entity to:
/// 1. Keep domain layer free from persistence concerns
/// 2. Allow different serialization strategies if needed
/// 3. Enable easy migration if storage mechanism changes
@freezed
@HiveType(typeId: 0) // Hive type ID for expense model
class ExpenseModel with _$ExpenseModel {
  const ExpenseModel._();

  const factory ExpenseModel({
    @HiveField(0) required String id,
    @HiveField(1) required double amount,
    @HiveField(2) required String category,
    @HiveField(3) required DateTime date,
    @HiveField(4) String? note,
    @HiveField(5) required DateTime createdAt,
    @HiveField(6) DateTime? updatedAt,
    @HiveField(7) Map<String, dynamic>? metadata,
  }) = _ExpenseModel;

  /// Convert from JSON (future-proofing for API sync)
  factory ExpenseModel.fromJson(Map<String, dynamic> json) =>
      _$ExpenseModelFromJson(json);

  /// Convert ExpenseModel to ExpenseEntity (Data -> Domain)
  /// This is where we translate from persistence layer to business logic layer
  ExpenseEntity toEntity() {
    return ExpenseEntity(
      id: id,
      amount: amount,
      category: category,
      date: date,
      note: note,
      createdAt: createdAt,
      updatedAt: updatedAt,
      metadata: metadata,
    );
  }

  /// Convert ExpenseEntity to ExpenseModel (Domain -> Data)
  /// Used when saving domain objects to Hive
  factory ExpenseModel.fromEntity(ExpenseEntity entity) {
    return ExpenseModel(
      id: entity.id,
      amount: entity.amount,
      category: entity.category,
      date: entity.date,
      note: entity.note,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      metadata: entity.metadata,
    );
  }

  /// Create a copy with updated timestamp
  /// Used when modifying existing expenses
  ExpenseModel withUpdateTimestamp() {
    return copyWith(updatedAt: DateTime.now());
  }
}
