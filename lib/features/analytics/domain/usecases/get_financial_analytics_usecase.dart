import 'package:smart_expense_tracker/features/analytics/domain/entities/analytics_entity.dart';
import 'package:smart_expense_tracker/features/analytics/domain/repositories/analytics_repository.dart';
import 'package:smart_expense_tracker/features/expenses/domain/entities/expense_entity.dart';
import 'package:smart_expense_tracker/features/income/domain/entities/income_entity.dart';

/// Usecase for getting comprehensive financial analytics
class GetFinancialAnalyticsUsecase {
  final AnalyticsRepository repository;

  GetFinancialAnalyticsUsecase(this.repository);

  Future<FinancialAnalyticsEntity> call({
    required List<IncomeEntity> incomes,
    required List<ExpenseEntity> expenses,
  }) {
    return repository.getFinancialAnalytics(
      incomes: incomes,
      expenses: expenses,
    );
  }
}
