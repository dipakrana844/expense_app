import 'package:smart_expense_tracker/features/expenses/domain/entities/expense_entity.dart';
import 'package:smart_expense_tracker/features/expenses/data/repositories/expense_repository.dart';
import '../../domain/repositories/quick_expense_repository.dart';
import '../datasources/quick_expense_local_data_source.dart';

/// Implementation of the QuickExpenseRepository
///
/// This class implements the repository interface and coordinates
/// between local data sources and the expense repository.
class QuickExpenseRepositoryImpl implements QuickExpenseRepository {
  final QuickExpenseLocalDataSource _localDataSource;
  final ExpenseRepository _expenseRepository;

  QuickExpenseRepositoryImpl({
    required QuickExpenseLocalDataSource localDataSource,
    required ExpenseRepository expenseRepository,
  })  : _localDataSource = localDataSource,
        _expenseRepository = expenseRepository;

  @override
  Future<bool> saveQuickExpense(ExpenseEntity expense) async {
    try {
      final (expenseEntity, failure) = await _expenseRepository.createExpense(
        amount: expense.amount,
        category: expense.category,
        date: expense.date,
        note: expense.note,
        metadata: expense.metadata,
      );
      return failure == null;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<String?> getLastUsedCategory() async {
    return await _localDataSource.getLastUsedCategory();
  }

  @override
  Future<void> saveLastUsedCategory(String category) async {
    await _localDataSource.saveLastUsedCategory(category);
  }

  /// Initialize the repository
  ///
  /// Call this method during app startup to initialize data sources
  Future<void> initialize() async {
    await _localDataSource.initialize();
  }

  /// Close the repository
  ///
  /// Call this method during app shutdown to free resources
  Future<void> close() async {
    await _localDataSource.close();
  }
}