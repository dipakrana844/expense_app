import 'package:smart_expense_tracker/features/analytics/domain/entities/analytics_entity.dart';
import 'package:smart_expense_tracker/features/analytics/domain/repositories/analytics_repository.dart';
import 'package:smart_expense_tracker/features/expenses/domain/entities/expense_entity.dart';

/// Usecase for getting monthly analytics
class GetMonthlyAnalyticsUsecase {
  final AnalyticsRepository repository;

  GetMonthlyAnalyticsUsecase(this.repository);

  Future<MonthlyAnalyticsEntity> call(List<ExpenseEntity> expenses) {
    return repository.getMonthlyAnalytics(expenses);
  }
}
