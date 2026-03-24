import 'package:smart_expense_tracker/features/analytics/domain/entities/analytics_entity.dart';
import 'package:smart_expense_tracker/features/analytics/domain/repositories/analytics_repository.dart';
import 'package:smart_expense_tracker/features/expenses/domain/entities/expense_entity.dart';

/// Usecase for getting daily snapshot analytics
class GetDailySnapshotUsecase {
  final AnalyticsRepository repository;

  GetDailySnapshotUsecase(this.repository);

  Future<DailySnapshotEntity> call(List<ExpenseEntity> expenses) {
    return repository.getDailySnapshot(expenses);
  }
}
