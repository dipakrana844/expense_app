import '../repository.dart';
import '../entities/budget_entity.dart';
import 'package:smart_expense_tracker/core/domain/usecases/base_usecase.dart';

class GetBudgetUseCase extends BaseUseCase<BudgetEntity, NoParams> {
  final BudgetRepository repository;

  GetBudgetUseCase(this.repository);

  @override
  UseCaseResult<BudgetEntity> call(NoParams params) async {
    final (budget, failure) = await repository.getBudget();
    if (failure != null) {
      return (null, failure);
    }
    // budget may be null if no budget set
    return (budget, null);
  }
}
