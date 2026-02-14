import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import '../../domain/entities/transfer_entity.dart';

part 'transfer_model.freezed.dart';
part 'transfer_model.g.dart';

/// Data Model: TransferModel
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
@HiveType(typeId: 4) // Hive type ID for transfer model (0-3 are used)
class TransferModel with _$TransferModel {
  const TransferModel._();

  const factory TransferModel({
    @HiveField(0) required String id,
    @HiveField(1) required double amount,
    @HiveField(2) required String fromAccount,
    @HiveField(3) required String toAccount,
    @HiveField(4) required DateTime date,
    @HiveField(5) @Default(0.0) double fee,
    @HiveField(6) String? note,
    @HiveField(7) required DateTime createdAt,
    @HiveField(8) DateTime? updatedAt,
    @HiveField(9) Map<String, dynamic>? metadata,
  }) = _TransferModel;

  /// Convert from JSON (future-proofing for API sync)
  factory TransferModel.fromJson(Map<String, dynamic> json) =>
      _$TransferModelFromJson(json);

  /// Convert TransferModel to TransferEntity (Data -> Domain)
  TransferEntity toEntity() {
    return TransferEntity(
      id: id,
      amount: amount,
      fromAccount: fromAccount,
      toAccount: toAccount,
      date: date,
      fee: fee,
      note: note,
      createdAt: createdAt,
      updatedAt: updatedAt,
      metadata: metadata,
    );
  }

  /// Convert TransferEntity to TransferModel (Domain -> Data)
  /// Used when saving domain objects to Hive
  factory TransferModel.fromEntity(TransferEntity entity) {
    return TransferModel(
      id: entity.id,
      amount: entity.amount,
      fromAccount: entity.fromAccount,
      toAccount: entity.toAccount,
      date: entity.date,
      fee: entity.fee,
      note: entity.note,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      metadata: entity.metadata,
    );
  }

  /// Create a copy with updated timestamp
  /// Used when modifying existing transfers
  TransferModel withUpdateTimestamp() {
    return copyWith(updatedAt: DateTime.now());
  }
}
