import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_expense_tracker/features/expenses/presentation/providers/expense_providers.dart';
import 'package:smart_expense_tracker/features/quick_expense/data/datasources/quick_expense_local_data_source.dart';
import 'package:smart_expense_tracker/features/quick_expense/data/repositories/quick_expense_repository_impl.dart';
import 'package:smart_expense_tracker/features/quick_expense/domain/repositories/quick_expense_repository.dart';
import 'package:smart_expense_tracker/features/quick_expense/domain/usecases/get_last_used_category_usecase.dart';
import 'package:smart_expense_tracker/features/quick_expense/domain/usecases/save_last_used_category_usecase.dart';
import 'package:smart_expense_tracker/features/quick_expense/domain/usecases/save_quick_expense_usecase.dart';

/// Provider for QuickExpenseLocalDataSource
final quickExpenseLocalDataSourceProvider =
    Provider<QuickExpenseLocalDataSource>((ref) {
  return QuickExpenseLocalDataSource();
});

/// Provider for QuickExpenseRepository
final quickExpenseRepositoryProvider = Provider<QuickExpenseRepository>((ref) {
  final localDataSource = ref.watch(quickExpenseLocalDataSourceProvider);
  final expenseRepository = ref.watch(expenseRepositoryProvider);
  return QuickExpenseRepositoryImpl(
    localDataSource: localDataSource,
    expenseRepository: expenseRepository,
  );
});

/// Provider for SaveQuickExpenseUseCase
final saveQuickExpenseUseCaseProvider = Provider<SaveQuickExpenseUseCase>((ref) {
  final repository = ref.watch(quickExpenseRepositoryProvider);
  return SaveQuickExpenseUseCase(repository);
});

/// Provider for GetLastUsedCategoryUseCase
final getLastUsedCategoryUseCaseProvider =
    Provider<GetLastUsedCategoryUseCase>((ref) {
  final repository = ref.watch(quickExpenseRepositoryProvider);
  return GetLastUsedCategoryUseCase(repository);
});

/// Provider for SaveLastUsedCategoryUseCase
final saveLastUsedCategoryUseCaseProvider =
    Provider<SaveLastUsedCategoryUseCase>((ref) {
  final repository = ref.watch(quickExpenseRepositoryProvider);
  return SaveLastUsedCategoryUseCase(repository);
});