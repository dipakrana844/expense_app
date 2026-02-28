import 'package:smart_expense_tracker/features/daily_spend_guard/domain/entities/daily_spend_state_entity.dart';
import 'package:smart_expense_tracker/features/daily_spend_guard/domain/repositories/daily_spend_repository.dart';
import 'package:smart_expense_tracker/features/daily_spend_guard/domain/services/spend_status_policy.dart';

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
  final SpendStatusPolicy _statusPolicy;

  UpdateDailySpendUseCase(
    this._repository, {
    SpendStatusPolicy statusPolicy = const SpendStatusPolicy(),
  }) : _statusPolicy = statusPolicy;

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
    final status = _statusPolicy.determineStatus(
      spent: newTotal,
      limit: currentState.dailyLimit,
    );
    
    final newState = currentState.copyWith(
      todaySpent: newTotal,
      remaining: remaining.clamp(0.0, double.infinity),
      status: status,
      lastUpdated: DateTime.now(),
    );
    
    await _repository.saveCurrentState(newState);
    return newState;
  }
  /// Get current daily spend state
  /// Convenience method for external access
  DailySpendStateEntity getCurrentState() {
    return _repository.getCurrentState();
  }
}
