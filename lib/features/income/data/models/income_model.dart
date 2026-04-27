import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/income_entity.dart';

part 'income_model.freezed.dart';
part 'income_model.g.dart';

/// Data Model: IncomeModel
///
/// Purpose: Data transfer object for Hive persistence
/// - Handles serialization/deserialization to Hive
/// - Converts between domain entity and persisted data
/// - Uses manual TypeAdapter for efficient storage
///
/// Design Decision: Separate model from entity to:
/// 1. Keep domain layer free from persistence concerns
/// 2. Allow different serialization strategies if needed
/// 3. Enable easy migration if storage mechanism changes
@freezed
abstract class IncomeModel with _$IncomeModel {
  const IncomeModel._();

  const factory IncomeModel({
    required String id,
    required double amount,
    required String source,
    required DateTime date,
    String? note,
    required DateTime createdAt,
    DateTime? updatedAt,
    Map<String, dynamic>? metadata,
  }) = _IncomeModel;

  /// Convert from JSON (future-proofing for API sync)
  factory IncomeModel.fromJson(Map<String, dynamic> json) =>
      _$IncomeModelFromJson(json);

  /// Convert IncomeModel to IncomeEntity (Data -> Domain)
  /// This is where we translate from persistence layer to business logic layer
  IncomeEntity toEntity() {
    return IncomeEntity(
      id: id,
      amount: amount,
      source: source,
      date: date,
      note: note,
      createdAt: createdAt,
      updatedAt: updatedAt,
      metadata: metadata,
    );
  }

  /// Convert IncomeEntity to IncomeModel (Domain -> Data)
  /// Used when saving domain objects to Hive
  factory IncomeModel.fromEntity(IncomeEntity entity) {
    return IncomeModel(
      id: entity.id,
      amount: entity.amount,
      source: entity.source,
      date: entity.date,
      note: entity.note,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      metadata: entity.metadata,
    );
  }

  /// Create a copy with updated timestamp
  /// Used when modifying existing incomes
  IncomeModel withUpdateTimestamp() {
    return copyWith(updatedAt: DateTime.now());
  }
}
