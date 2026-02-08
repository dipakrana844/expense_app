import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_expense_tracker/core/constants/app_constants.dart';
import '../models/daily_spend_state.dart';

/// Local Data Source: DailySpendLocalDataSource
///
/// Purpose: Handles all local persistence operations for daily spend tracking
/// - Manages Hive box operations for DailySpendState
/// - Provides CRUD operations for daily spend data
/// - Handles daily reset and initialization logic
///
/// Design Decision: Centralized data access to:
/// 1. Encapsulate Hive operations
/// 2. Provide consistent error handling
/// 3. Enable easy migration if storage mechanism changes

class DailySpendLocalDataSource {
  static const String _dailySpendBoxName = 'daily_spend_box';
  static const String _currentStateKey = 'current_state';

  late Box<DailySpendState> _dailySpendBox;

  /// Initialize the data source
  /// Opens the Hive box and ensures proper setup
  Future<void> init() async {
    _dailySpendBox = await Hive.openBox<DailySpendState>(_dailySpendBoxName);
  }

  /// Get current daily spend state
  /// Returns initial state if no state exists or if state is from previous day
  DailySpendState getCurrentState() {
    final storedState = _dailySpendBox.get(_currentStateKey);

    if (storedState == null) {
      return DailySpendState.initial();
    }

    // If stored state is from previous day, reset to initial state
    if (!storedState.isForToday) {
      return DailySpendState.initial();
    }

    return storedState;
  }

  /// Save current daily spend state
  /// Persists the state to Hive storage
  Future<void> saveCurrentState(DailySpendState state) async {
    await _dailySpendBox.put(_currentStateKey, state);
  }

  /// Reset daily state to initial values
  /// Called at midnight or when starting fresh
  Future<void> resetDailyState() async {
    final initialState = DailySpendState.initial();
    await saveCurrentState(initialState);
  }

  /// Update today's spending amount
  /// Convenience method to update just the spending amount
  Future<void> updateTodaySpent(double amount) async {
    final currentState = getCurrentState();
    final updatedState = currentState.copyWith(
      todaySpent: amount,
      lastUpdated: DateTime.now(),
    );
    await saveCurrentState(updatedState);
  }

  /// Update daily limit
  /// Convenience method to update just the daily limit
  Future<void> updateDailyLimit(double limit) async {
    final currentState = getCurrentState();
    final updatedState = currentState.copyWith(
      dailyLimit: limit,
      lastUpdated: DateTime.now(),
    );
    await saveCurrentState(updatedState);
  }

  /// Close the Hive box
  /// Should be called when the app is shutting down
  Future<void> close() async {
    await _dailySpendBox.close();
  }

  /// Clear all data (for testing/debugging purposes)
  Future<void> clearAll() async {
    await _dailySpendBox.clear();
  }
}