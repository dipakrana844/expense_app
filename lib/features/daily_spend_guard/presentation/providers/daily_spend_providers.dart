import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_expense_tracker/core/constants/app_constants.dart';
import 'package:smart_expense_tracker/features/daily_spend_guard/data/local/daily_spend_local_data_source.dart';
import 'package:smart_expense_tracker/features/daily_spend_guard/data/repositories/daily_spend_repository_impl.dart';
import 'package:smart_expense_tracker/features/daily_spend_guard/domain/entities/daily_spend_state_entity.dart';
import 'package:smart_expense_tracker/features/daily_spend_guard/domain/repositories/daily_spend_repository.dart';
import 'package:smart_expense_tracker/features/daily_spend_guard/domain/usecases/calculate_daily_limit_usecase.dart';
import 'package:smart_expense_tracker/features/daily_spend_guard/domain/usecases/update_daily_spend_usecase.dart';
import 'package:smart_expense_tracker/features/expenses/presentation/providers/expense_providers.dart';

final dailySpendLocalDataSourceProvider = Provider<DailySpendLocalDataSource>((
  ref,
) {
  return DailySpendLocalDataSource();
});

final dailySpendBudgetBoxProvider = Provider<Box>((ref) {
  return Hive.box(AppConstants.budgetBoxName);
});

final dailySpendRepositoryProvider = Provider<DailySpendRepository>((ref) {
  final dataSource = ref.watch(dailySpendLocalDataSourceProvider);
  final expenseRepository = ref.watch(expenseRepositoryProvider);
  final budgetBox = ref.watch(dailySpendBudgetBoxProvider);

  return DailySpendRepositoryImpl(
    localDataSource: dataSource,
    expenseRepository: expenseRepository,
    budgetBox: budgetBox,
  );
});

final calculateDailyLimitUseCaseProvider = Provider<CalculateDailyLimitUseCase>(
  (ref) {
    final repository = ref.watch(dailySpendRepositoryProvider);
    return CalculateDailyLimitUseCase(repository);
  },
);

final updateDailySpendUseCaseProvider = Provider<UpdateDailySpendUseCase>((
  ref,
) {
  final repository = ref.watch(dailySpendRepositoryProvider);
  return UpdateDailySpendUseCase(repository);
});

final dailySpendStateProvider =
    StateNotifierProvider<
      DailySpendNotifier,
      AsyncValue<DailySpendStateEntity>
    >((ref) {
      final repository = ref.watch(dailySpendRepositoryProvider);
      final updateUseCase = ref.watch(updateDailySpendUseCaseProvider);
      final calculateUseCase = ref.watch(calculateDailyLimitUseCaseProvider);

      return DailySpendNotifier(
        repository: repository,
        updateUseCase: updateUseCase,
        calculateUseCase: calculateUseCase,
      );
    });

class DailySpendNotifier
    extends StateNotifier<AsyncValue<DailySpendStateEntity>> {
  final DailySpendRepository _repository;
  final UpdateDailySpendUseCase _updateUseCase;
  final CalculateDailyLimitUseCase _calculateUseCase;

  DailySpendNotifier({
    required DailySpendRepository repository,
    required UpdateDailySpendUseCase updateUseCase,
    required CalculateDailyLimitUseCase calculateUseCase,
  }) : _repository = repository,
       _updateUseCase = updateUseCase,
       _calculateUseCase = calculateUseCase,
       super(const AsyncValue.loading()) {
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      await _repository.init();

      final dailyLimit = await _calculateUseCase.calculateDailyLimit();
      var currentState = _repository.getCurrentState();

      if (currentState.dailyLimit != dailyLimit) {
        currentState = await _updateUseCase.recalculateState(dailyLimit);
      }

      state = AsyncValue.data(currentState);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> addSpending(double amount) async {
    try {
      final currentState = await _updateUseCase.addSpending(amount);
      state = AsyncValue.data(currentState);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> removeSpending(double amount) async {
    try {
      final currentState = await _updateUseCase.removeSpending(amount);
      state = AsyncValue.data(currentState);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> setSpending(double amount) async {
    try {
      final currentState = await _updateUseCase.setSpending(amount);
      state = AsyncValue.data(currentState);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> recalculateDailyLimit() async {
    try {
      final newDailyLimit = await _calculateUseCase.calculateDailyLimit();
      final currentState = await _updateUseCase.recalculateState(newDailyLimit);
      state = AsyncValue.data(currentState);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> resetDailyState() async {
    try {
      await _repository.resetDailyState();
      await _initialize();
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> refresh() async {
    try {
      final currentState = _repository.getCurrentState();
      state = AsyncValue.data(currentState);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
