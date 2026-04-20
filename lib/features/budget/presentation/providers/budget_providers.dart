import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/get_budget_usecase.dart';
import '../../domain/usecases/update_budget_usecase.dart';
import '../../domain/entities/budget_entity.dart';
import '../../data/budget_infrastructure_provider.dart';
import 'package:smart_expense_tracker/core/domain/usecases/base_usecase.dart';
import 'package:smart_expense_tracker/core/error/failures.dart';
import 'package:smart_expense_tracker/features/settings/presentation/providers/settings_providers.dart';
import 'package:smart_expense_tracker/core/constants/budget_constants.dart';

// ---------------------------------------------------------------------------
// Use-case providers (depend only on abstract BudgetRepository)
// ---------------------------------------------------------------------------

final getBudgetUseCaseProvider = Provider<GetBudgetUseCase>((ref) {
  final repository = ref.watch(budgetRepositoryProvider);
  return GetBudgetUseCase(repository);
});

final updateBudgetUseCaseProvider = Provider<UpdateBudgetUseCase>((ref) {
  final repository = ref.watch(budgetRepositoryProvider);
  return UpdateBudgetUseCase(repository);
});

// ---------------------------------------------------------------------------
// BudgetController — AsyncNotifierProvider
// ---------------------------------------------------------------------------

final budgetControllerProvider =
    AsyncNotifierProvider<BudgetController, BudgetEntity?>(
      BudgetController.new,
    );

class BudgetController extends AsyncNotifier<BudgetEntity?> {
  late final GetBudgetUseCase _getBudgetUseCase;
  late final UpdateBudgetUseCase _updateBudgetUseCase;

  @override
  Future<BudgetEntity?> build() async {
    _getBudgetUseCase = ref.watch(getBudgetUseCaseProvider);
    _updateBudgetUseCase = ref.watch(updateBudgetUseCaseProvider);
    await _loadBudget();
    return null; // placeholder, will be overridden by _loadBudget
  }

  Future<void> _loadBudget() async {
    state = const AsyncValue.loading();
    final (budget, failure) = await _getBudgetUseCase.call(NoParams());
    if (failure != null) {
      state = AsyncValue.error(
        FailureX(failure).userMessage,
        StackTrace.current,
      );
      return;
    }
    state = AsyncValue.data(budget);
  }

  Future<void> updateBudget(double amount) async {
    // Validate input before creating entity
    if (amount < BudgetConstants.minBudgetAmount) {
      state = AsyncValue.error(
        'Budget amount cannot be negative',
        StackTrace.current,
      );
      return;
    }
    if (amount > BudgetConstants.maxBudgetAmount) {
      state = AsyncValue.error(
        'Budget amount exceeds maximum limit',
        StackTrace.current,
      );
      return;
    }

    final currency = ref.watch(defaultCurrencyProvider);
    final newBudget = BudgetEntity(
      amount: amount,
      currency: currency,
      isActive: true,
      createdAt: state.value?.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final (updatedBudget, failure) = await _updateBudgetUseCase.call(newBudget);
    if (failure != null) {
      state = AsyncValue.error(
        FailureX(failure).userMessage,
        StackTrace.current,
      );
      return;
    }
    state = AsyncValue.data(updatedBudget);
  }

  Future<void> clearBudget() async {
    await updateBudget(0.0);
  }
}

// ---------------------------------------------------------------------------
// Legacy provider for backward compatibility (returns double)
// ---------------------------------------------------------------------------

final monthlyBudgetProvider = Provider<AsyncValue<double>>((ref) {
  final asyncValue = ref.watch(budgetControllerProvider);
  return asyncValue.when(
    data: (budget) => AsyncValue.data(budget?.amount ?? 0.0),
    loading: () => const AsyncValue.loading(),
    error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
  );
});
