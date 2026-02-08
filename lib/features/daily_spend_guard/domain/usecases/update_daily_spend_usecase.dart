import 'package:smart_expense_tracker/features/daily_spend_guard/data/models/daily_spend_state.dart';
import 'package:smart_expense_tracker/features/daily_spend_guard/data/local/daily_spend_local_data_source.dart';

/// Use Case: UpdateDailySpendUseCase
///
/// Purpose: Updates the daily spending state in real-time based on:
/// - New expense additions
/// - Expense deletions
/// - Expense modifications
/// - Automatic recalculations
///
/// Design Decision: Centralized update logic to:
/// 1. Ensure consistent state management
/// 2. Handle complex status determination
/// 3. Provide single source of truth for daily spending

class UpdateDailySpendUseCase {
  final DailySpendLocalDataSource _dataSource;

  UpdateDailySpendUseCase(this._dataSource);

  /// Update daily spending with new amount
  /// Adds the amount to today's total and recalculates status
  Future<DailySpendState> addSpending(double amount) async {
    final currentState = _dataSource.getCurrentState();
    final newTotal = currentState.todaySpent + amount;
    
    return _updateStateWithNewTotal(currentState, newTotal);
  }

  /// Update daily spending by removing amount
  /// Subtracts the amount from today's total and recalculates status
  Future<DailySpendState> removeSpending(double amount) async {
    final currentState = _dataSource.getCurrentState();
    final newTotal = (currentState.todaySpent - amount).clamp(0.0, double.infinity);
    
    return _updateStateWithNewTotal(currentState, newTotal);
  }

  /// Reset today's spending to specific amount
  /// Used when editing existing expenses
  Future<DailySpendState> setSpending(double amount) async {
    final currentState = _dataSource.getCurrentState();
    return _updateStateWithNewTotal(currentState, amount);
  }

  /// Recalculate entire daily state
  /// Used when daily limit changes or at midnight reset
  Future<DailySpendState> recalculateState(double newDailyLimit) async {
    final currentState = _dataSource.getCurrentState();
    return _updateStateWithNewTotal(
      currentState.copyWith(dailyLimit: newDailyLimit),
      currentState.todaySpent
    );
  }

  /// Internal method to update state with new total and determine status
  Future<DailySpendState> _updateStateWithNewTotal(
    DailySpendState currentState, 
    double newTotal
  ) async {
    final remaining = currentState.dailyLimit - newTotal;
    final status = _determineStatus(newTotal, currentState.dailyLimit);
    
    final newState = currentState.copyWith(
      todaySpent: newTotal,
      remaining: remaining.clamp(0.0, double.infinity),
      status: status,
      lastUpdated: DateTime.now(),
    );
    
    await _dataSource.saveCurrentState(newState);
    return newState;
  }

  /// Determine spending status based on thresholds
  /// Safe: Below 80% of daily limit
  /// Caution: 80-100% of daily limit
  /// Exceeded: Above 100% of daily limit
  SpendStatus _determineStatus(double spent, double limit) {
    if (limit <= 0) return SpendStatus.safe; // No limit set
    
    final percentage = spent / limit;
    
    if (percentage >= 1.0) {
      return SpendStatus.exceeded;
    } else if (percentage >= 0.8) {
      return SpendStatus.caution;
    } else {
      return SpendStatus.safe;
    }
  }

  /// Get current daily spend state
  /// Convenience method for external access
  DailySpendState getCurrentState() {
    return _dataSource.getCurrentState();
  }
}