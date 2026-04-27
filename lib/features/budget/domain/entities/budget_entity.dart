import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_expense_tracker/core/constants/budget_constants.dart';

part 'budget_entity.freezed.dart';

@freezed
abstract class BudgetEntity with _$BudgetEntity {
  const BudgetEntity._();

  const factory BudgetEntity({
    required double amount,
    @Default(BudgetConstants.defaultCurrency) String currency,
    @Default(false) bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _BudgetEntity;

  /// Helper method to check if budget is set
  bool get isSet => amount > 0;

  /// Validates the budget entity
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

  /// Calculates the remaining budget based on spent amount
  double getRemaining(double spent) {
    return (amount - spent).clamp(0.0, amount);
  }

  /// Calculates the progress percentage (0.0 - 1.0+)
  double getProgress(double spent) {
    return amount > 0 ? (spent / amount) : 0.0;
  }

  /// Checks if budget is near limit (>= 80%)
  bool isNearBudget(double spent) {
    return getProgress(spent) >= BudgetConstants.nearBudgetThreshold;
  }

  /// Checks if budget is exceeded (> 100%)
  bool isOverBudget(double spent) {
    return getProgress(spent) > BudgetConstants.overBudgetThreshold;
  }
}
