import '../repository.dart';
import '../entities/budget_entity.dart';
import 'package:smart_expense_tracker/core/domain/usecases/base_usecase.dart';

/// Use case for updating a budget.
/// Extends BaseUseCase for consistent pattern across the codebase.
class UpdateBudgetUseCase extends BaseUseCase<BudgetEntity, BudgetEntity> {
  final BudgetRepository repository;

  UpdateBudgetUseCase(this.repository);

  @override
  UseCaseResult<BudgetEntity> call(BudgetEntity params) async {
    final failure = await repository.updateBudget(params);
    if (failure != null) {
      return (null, failure);
    }
    return (params, null);
  }
}
