import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_expense_tracker/features/daily_spend_guard/data/local/daily_spend_local_data_source.dart';
import 'package:smart_expense_tracker/features/daily_spend_guard/data/models/daily_spend_state.dart';
import 'package:smart_expense_tracker/features/daily_spend_guard/domain/usecases/calculate_daily_limit_usecase.dart';
import 'package:smart_expense_tracker/features/daily_spend_guard/domain/usecases/update_daily_spend_usecase.dart';

/// Provider: dailySpendLocalDataSourceProvider
///
/// Purpose: Provides singleton instance of DailySpendLocalDataSource
/// - Handles Hive initialization and adapter registration
/// - Ensures single source of data access
final dailySpendLocalDataSourceProvider =
    Provider<DailySpendLocalDataSource>((ref) {
  return DailySpendLocalDataSource();
});

/// Provider: calculateDailyLimitUseCaseProvider
///
/// Purpose: Provides CalculateDailyLimitUseCase instance
/// - Depends on Riverpod Ref for accessing budget data
final calculateDailyLimitUseCaseProvider =
    Provider<CalculateDailyLimitUseCase>((ref) {
  return CalculateDailyLimitUseCase(ref);
});

/// Provider: updateDailySpendUseCaseProvider
///
/// Purpose: Provides UpdateDailySpendUseCase instance
/// - Depends on local data source for state persistence
final updateDailySpendUseCaseProvider =
    Provider<UpdateDailySpendUseCase>((ref) {
  final dataSource = ref.watch(dailySpendLocalDataSourceProvider);
  return UpdateDailySpendUseCase(dataSource);
});

/// Provider: dailySpendStateProvider
///
/// Purpose: Main state provider for daily spending tracking
/// - Manages AsyncValue<DailySpendState> for UI consumption
/// - Handles loading, data, and error states
/// - Initializes with current persisted state
final dailySpendStateProvider =
    StateNotifierProvider<DailySpendNotifier, AsyncValue<DailySpendState>>(
        (ref) {
  final dataSource = ref.watch(dailySpendLocalDataSourceProvider);
  final updateUseCase = ref.watch(updateDailySpendUseCaseProvider);
  final calculateUseCase = ref.watch(calculateDailyLimitUseCaseProvider);

  return DailySpendNotifier(
    dataSource: dataSource,
    updateUseCase: updateUseCase,
    calculateUseCase: calculateUseCase,
  );
});

/// State Notifier: DailySpendNotifier
///
/// Purpose: Manages daily spending state with real-time updates
/// - Handles initialization and state loading
/// - Provides methods for expense interactions
/// - Manages automatic recalculations
class DailySpendNotifier extends StateNotifier<AsyncValue<DailySpendState>> {
  final DailySpendLocalDataSource _dataSource;
  final UpdateDailySpendUseCase _updateUseCase;
  final CalculateDailyLimitUseCase _calculateUseCase;

  DailySpendNotifier({
    required DailySpendLocalDataSource dataSource,
    required UpdateDailySpendUseCase updateUseCase,
    required CalculateDailyLimitUseCase calculateUseCase,
  })  : _dataSource = dataSource,
        _updateUseCase = updateUseCase,
        _calculateUseCase = calculateUseCase,
        super(const AsyncValue.loading()) {
    _initialize();
  }

  /// Initialize the notifier
  /// Loads persisted state and sets up initial values
  Future<void> _initialize() async {
    try {
      await _dataSource.init();
      
      // Calculate initial daily limit
      final dailyLimit = await _calculateUseCase.calculateDailyLimit();
      
      // Get current state and ensure daily limit is set
      var currentState = _dataSource.getCurrentState();
      
      if (currentState.dailyLimit != dailyLimit) {
        currentState = await _updateUseCase.recalculateState(dailyLimit);
      }
      
      state = AsyncValue.data(currentState);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// Add spending amount to today's total
  /// Called when new expense is added
  Future<void> addSpending(double amount) async {
    try {
      final currentState = await _updateUseCase.addSpending(amount);
      state = AsyncValue.data(currentState);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// Remove spending amount from today's total
  /// Called when expense is deleted
  Future<void> removeSpending(double amount) async {
    try {
      final currentState = await _updateUseCase.removeSpending(amount);
      state = AsyncValue.data(currentState);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// Set today's spending to specific amount
  /// Called when expense is edited
  Future<void> setSpending(double amount) async {
    try {
      final currentState = await _updateUseCase.setSpending(amount);
      state = AsyncValue.data(currentState);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// Recalculate daily limit and update state
  /// Called when budget changes or at periodic intervals
  Future<void> recalculateDailyLimit() async {
    try {
      final newDailyLimit = await _calculateUseCase.calculateDailyLimit();
      final currentState = await _updateUseCase.recalculateState(newDailyLimit);
      state = AsyncValue.data(currentState);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// Reset daily state to initial values
  /// Called manually or by background service
  Future<void> resetDailyState() async {
    try {
      await _dataSource.resetDailyState();
      await _initialize(); // Re-initialize with fresh state
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// Force refresh of current state
  /// Useful for manual updates or debugging
  Future<void> refresh() async {
    try {
      final currentState = _dataSource.getCurrentState();
      state = AsyncValue.data(currentState);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}