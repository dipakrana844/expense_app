import 'package:smart_expense_tracker/features/daily_spend_guard/domain/entities/daily_spend_state_entity.dart';
import 'package:smart_expense_tracker/features/daily_spend_guard/domain/repositories/daily_spend_repository.dart';

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
  final DailySpendRepository _repository;

  UpdateDailySpendUseCase(this._repository);

  /// Update daily spending with new amount
  /// Adds the amount to today's total and recalculates status
  Future<DailySpendStateEntity> addSpending(double amount) async {
    final currentState = _repository.getCurrentState();
    final newTotal = currentState.todaySpent + amount;
    
    return _updateStateWithNewTotal(currentState, newTotal);
  }

  /// Update daily spending by removing amount
  /// Subtracts the amount from today's total and recalculates status
  Future<DailySpendStateEntity> removeSpending(double amount) async {
    final currentState = _repository.getCurrentState();
    final newTotal = (currentState.todaySpent - amount).clamp(0.0, double.infinity);
    
    return _updateStateWithNewTotal(currentState, newTotal);
  }

  /// Reset today's spending to specific amount
  /// Used when editing existing expenses
  Future<DailySpendStateEntity> setSpending(double amount) async {
    final currentState = _repository.getCurrentState();
    return _updateStateWithNewTotal(currentState, amount);
  }

  /// Recalculate entire daily state
  /// Used when daily limit changes or at midnight reset
  Future<DailySpendStateEntity> recalculateState(double newDailyLimit) async {
    final currentState = _repository.getCurrentState();
    return _updateStateWithNewTotal(
      currentState.copyWith(dailyLimit: newDailyLimit),
      currentState.todaySpent
    );
  }

  /// Internal method to update state with new total and determine status
  Future<DailySpendStateEntity> _updateStateWithNewTotal(
    DailySpendStateEntity currentState,
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
    
    await _repository.saveCurrentState(newState);
    return newState;
  }

  /// Determine spending status based on thresholds
  /// Safe: Below 80% of daily limit
  /// Caution: 80-100% of daily limit
  /// Exceeded: Above 100% of daily limit
  SpendStatusEntity _determineStatus(double spent, double limit) {
    if (limit <= 0) return SpendStatusEntity.safe; // No limit set
    
    final percentage = spent / limit;
    
    if (percentage >= 1.0) {
      return SpendStatusEntity.exceeded;
    } else if (percentage >= 0.8) {
      return SpendStatusEntity.caution;
    } else {
      return SpendStatusEntity.safe;
    }
  }

  /// Get current daily spend state
  /// Convenience method for external access
  DailySpendStateEntity getCurrentState() {
    return _repository.getCurrentState();
  }
}
