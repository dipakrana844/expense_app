import 'package:flutter/foundation.dart';
import '../domain/repository.dart';
import '../domain/entities/budget_entity.dart';
import 'local/budget_local_data_source.dart';
import 'models/budget_model.dart';
import 'package:smart_expense_tracker/core/error/failures.dart';

class BudgetRepositoryImpl implements BudgetRepository {
  final BudgetLocalDataSource dataSource;

  BudgetRepositoryImpl(this.dataSource);

  @override
  Future<(BudgetEntity?, Failure?)> getBudget() async {
    try {
      final model = dataSource.getBudget();
      if (model == null) {
        // No budget set - valid empty state
        debugPrint('BudgetRepositoryImpl: No budget set');
        return (null, null);
      }
      final entity = model.toEntity();
      debugPrint(
        'BudgetRepositoryImpl: Loaded budget: ${model.amount} ${model.currency}',
      );
      return (entity, null);
    } catch (e) {
      debugPrint('BudgetRepositoryImpl: Error loading budget: $e');
      return (
        null,
        Failure.storage(message: 'Failed to load budget', error: e),
      );
    }
  }

  @override
  Future<Failure?> updateBudget(BudgetEntity budget) async {
    try {
      // Validate budget before updating
      final validationError = budget.validate();
      if (validationError != null) {
        debugPrint('BudgetRepositoryImpl: Validation error: $validationError');
        return Failure.validation(message: validationError);
      }

      debugPrint(
        'BudgetRepositoryImpl: Updating budget to ${budget.amount} ${budget.currency}',
      );
      final model = BudgetModel.fromEntity(budget);
      await dataSource.updateBudget(model);
      return null;
    } catch (e) {
      debugPrint('BudgetRepositoryImpl: Error updating budget: $e');
      return Failure.storage(message: 'Failed to update budget', error: e);
    }
  }

  @override
  Future<Failure?> clearBudget() async {
    try {
      debugPrint('BudgetRepositoryImpl: Clearing budget');
      await dataSource.updateMonthlyBudget(0.0);
      return null;
    } catch (e) {
      debugPrint('BudgetRepositoryImpl: Error clearing budget: $e');
      return Failure.storage(message: 'Failed to clear budget', error: e);
    }
  }
}
