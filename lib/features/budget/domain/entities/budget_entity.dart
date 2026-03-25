import 'package:freezed_annotation/freezed_annotation.dart';

part 'budget_entity.freezed.dart';

@freezed
class BudgetEntity with _$BudgetEntity {
  const BudgetEntity._();

  const factory BudgetEntity({
    required double amount,
    @Default('₹') String currency,
    @Default(false) bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _BudgetEntity;

  // Helper method to check if budget is set
  bool get isSet => amount > 0;
}
