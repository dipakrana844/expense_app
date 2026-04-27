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
    AsyncNotifierProvider<DailySpendNotifier, DailySpendStateEntity>(
      DailySpendNotifier.new,
    );

class DailySpendNotifier extends AsyncNotifier<DailySpendStateEntity> {
  late final DailySpendRepository _repository;
  late final UpdateDailySpendUseCase _updateUseCase;
  late final CalculateDailyLimitUseCase _calculateUseCase;

  @override
  Future<DailySpendStateEntity> build() async {
    _repository = ref.watch(dailySpendRepositoryProvider);
    _updateUseCase = ref.watch(updateDailySpendUseCaseProvider);
    _calculateUseCase = ref.watch(calculateDailyLimitUseCaseProvider);

    return await _initialize();
  }

  Future<DailySpendStateEntity> _initialize() async {
    try {
      await _repository.init();

      final dailyLimit = await _calculateUseCase.calculateDailyLimit();
      var currentState = _repository.getCurrentState();

      if (currentState.dailyLimit != dailyLimit) {
        currentState = await _updateUseCase.recalculateState(dailyLimit);
      }

      return currentState;
    } catch (e, stackTrace) {
      throw Exception('Failed to initialize: $e');
    }
  }

  Future<void> addSpending(double amount) async {
    try {
      final currentState = await _updateUseCase.addSpending(amount);
      state = AsyncData(currentState);
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }

  Future<void> removeSpending(double amount) async {
    try {
      final currentState = await _updateUseCase.removeSpending(amount);
      state = AsyncData(currentState);
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }

  Future<void> setSpending(double amount) async {
    try {
      final currentState = await _updateUseCase.setSpending(amount);
      state = AsyncData(currentState);
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }

  Future<void> recalculateDailyLimit() async {
    try {
      final newDailyLimit = await _calculateUseCase.calculateDailyLimit();
      final currentState = await _updateUseCase.recalculateState(newDailyLimit);
      state = AsyncData(currentState);
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }

  Future<void> resetDailyState() async {
    try {
      await _repository.resetDailyState();
      state = await AsyncValue.guard(() => _initialize());
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }

  Future<void> refresh() async {
    try {
      final currentState = _repository.getCurrentState();
      state = AsyncData(currentState);
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }
}
