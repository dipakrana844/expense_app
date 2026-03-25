import 'package:smart_expense_tracker/features/budget/domain/entities/budget_entity.dart';
import 'package:smart_expense_tracker/core/error/failures.dart';

abstract class BudgetRepository {
  Future<(BudgetEntity?, Failure?)> getBudget();
  Future<Failure?> updateBudget(BudgetEntity budget);
  Future<Failure?> clearBudget();
}
