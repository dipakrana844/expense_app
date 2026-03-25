import '../repository.dart';
import '../entities/budget_entity.dart';
import 'package:smart_expense_tracker/core/error/failures.dart';

class UpdateBudgetUseCase {
  final BudgetRepository repository;

  UpdateBudgetUseCase(this.repository);

  Future<Failure?> call(BudgetEntity budget) async {
    return await repository.updateBudget(budget);
  }
}
