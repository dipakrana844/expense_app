import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/budget_entity.dart';
import 'package:smart_expense_tracker/core/constants/budget_constants.dart';

part 'budget_model.freezed.dart';
part 'budget_model.g.dart';

@freezed
abstract class BudgetModel with _$BudgetModel {
  const BudgetModel._();

  const factory BudgetModel({
    required double amount,
    @Default(BudgetConstants.defaultCurrency) String currency,
    @Default(false) bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
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
