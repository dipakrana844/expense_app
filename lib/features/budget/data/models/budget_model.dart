import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/entities/budget_entity.dart';
import 'package:smart_expense_tracker/core/constants/budget_constants.dart';

part 'budget_model.freezed.dart';
part 'budget_model.g.dart';

@freezed
@HiveType(typeId: 15) // Unique type ID for budget model
class BudgetModel with _$BudgetModel {
  const BudgetModel._();

  const factory BudgetModel({
    @HiveField(0) required double amount,
    @HiveField(1) @Default(BudgetConstants.defaultCurrency) String currency,
    @HiveField(2) @Default(false) bool isActive,
    @HiveField(3) DateTime? createdAt,
    @HiveField(4) DateTime? updatedAt,
  }) = _BudgetModel;

  factory BudgetModel.fromJson(Map<String, dynamic> json) =>
      _$BudgetModelFromJson(json);

  /// Convert from entity
  factory BudgetModel.fromEntity(BudgetEntity entity) => BudgetModel(
    amount: entity.amount,
    currency: entity.currency,
    isActive: entity.isActive,
    createdAt: entity.createdAt,
    updatedAt: entity.updatedAt,
  );

  /// Convert to entity
  BudgetEntity toEntity() => BudgetEntity(
    amount: amount,
    currency: currency,
    isActive: isActive,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );

  /// Validates the budget model
  /// Returns null if valid, otherwise returns an error message
  String? validate() {
    if (amount < BudgetConstants.minBudgetAmount) {
      return 'Budget amount cannot be negative';
    }
    if (amount > BudgetConstants.maxBudgetAmount) {
      return 'Budget amount exceeds maximum limit';
    }
    if (currency.isEmpty) {
      return 'Currency cannot be empty';
    }
    return null;
  }
}
