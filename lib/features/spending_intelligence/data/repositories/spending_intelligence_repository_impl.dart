import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_expense_tracker/core/constants/app_constants.dart';
import '../../domain/repositories/spending_intelligence_repository.dart';
import '../../data/datasources/spending_intelligence_local_data_source.dart';
import '../../domain/entities/insight.dart';
import '../../data/models/insight_model.dart';
import '../../domain/algorithms/spending_algorithms.dart';
import '../../../expenses/data/local/expense_local_data_source.dart';

class SpendingIntelligenceRepositoryImpl
    implements SpendingIntelligenceRepository {
  final SpendingIntelligenceLocalDataSource _localDataSource;
  final ExpenseLocalDataSource _expenseDataSource;

  SpendingIntelligenceRepositoryImpl(
    this._localDataSource,
    this._expenseDataSource,
  );

  @override
  Future<void> generateDailyInsights() async {
    // 1. Get Expenses
    // We assume data sources are initialized by the caller
    final expenses = _expenseDataSource.getAllExpenses();
    final expenseEntities = expenses.map((e) => e.toEntity()).toList();

    // 2. Get Budget
    var budgetBox = Hive.isBoxOpen(AppConstants.budgetBoxName)
        ? Hive.box(AppConstants.budgetBoxName)
        : await Hive.openBox(AppConstants.budgetBoxName);

    final monthlyBudget = budgetBox.get('monthly_limit', defaultValue: 0.0);
    final budgetAmount = (monthlyBudget is int)
        ? monthlyBudget.toDouble()
        : (monthlyBudget as double);

    // 3. Run Algorithms
    final insights = <Insight>[];

    // Anomaly
    insights.addAll(SpendingAlgorithms.detectAnomalies(expenseEntities));

    // Budget
    final monthExpenses = expenseEntities
        .where((e) => e.isCurrentMonth)
        .toList();
    final budgetInsight = SpendingAlgorithms.predictBudgetBurn(
      monthExpenses,
      budgetAmount,
    );
    if (budgetInsight != null) insights.add(budgetInsight);

    // Category Shift
    final now = DateTime.now();
    final prevMonthDate = DateTime(now.year, now.month - 1, 1);
    final prevMonthStart = DateTime(prevMonthDate.year, prevMonthDate.month, 1);
    final prevMonthEnd = DateTime(
      now.year,
      now.month,
      0,
      23,
      59,
      59,
    ); // Last day of prev month

    final prevMonthExpenses = expenseEntities
        .where(
          (e) =>
              e.date.isAfter(prevMonthStart) && e.date.isBefore(prevMonthEnd),
        )
        .toList();

    final catInsight = SpendingAlgorithms.detectCategoryShift(
      monthExpenses,
      prevMonthExpenses,
    );
    if (catInsight != null) insights.add(catInsight);

    // 4. Save
    await _localDataSource.saveInsights(
      insights.map((e) => InsightModel.fromEntity(e)).toList(),
    );
  }

  @override
  Future<List<Insight>> getInsights() async {
    final models = _localDataSource.getInsights();
    return models.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> markAsRead(String id) async {
    await _localDataSource.markAsRead(id);
  }

  @override
  Future<void> clearAllInsights() async {
    await _localDataSource.clearAll();
  }
}
