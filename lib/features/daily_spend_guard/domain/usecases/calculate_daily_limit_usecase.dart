import 'package:smart_expense_tracker/features/budget/presentation/providers/budget_providers.dart';
import 'package:smart_expense_tracker/features/expenses/data/models/expense_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Use Case: CalculateDailyLimitUseCase
///
/// Purpose: Calculates the appropriate daily spending limit based on:
/// - Monthly budget and remaining days (primary method)
/// - 30-day average spending (fallback when no budget set)
///
/// Design Decision: Separated business logic from presentation layer to:
/// 1. Enable testability of calculation logic
/// 2. Support different calculation strategies
/// 3. Facilitate future enhancements (weekly limits, etc.)

class CalculateDailyLimitUseCase {
  final Ref _ref;
  
  CalculateDailyLimitUseCase(this._ref);

  /// Calculate daily spending limit
  /// Returns the recommended daily limit based on current conditions
  Future<double> calculateDailyLimit() async {
    // First, try to get monthly budget
    final budgetAsync = _ref.read(monthlyBudgetProvider);
    
    if (budgetAsync is AsyncData<double> && budgetAsync.value > 0) {
      return _calculateFromMonthlyBudget(budgetAsync.value);
    }
    
    // Fallback to 30-day average if no budget set
    return _calculateFromAverageSpending();
  }

  /// Calculate daily limit based on monthly budget
  /// Formula: (Remaining budget) / (Days remaining in month)
  double _calculateFromMonthlyBudget(double monthlyBudget) {
    final now = DateTime.now();
    final daysInMonth = _getDaysInMonth(now.year, now.month);
    final daysRemaining = daysInMonth - now.day + 1; // Include today
    
    // Ensure we don't divide by zero
    if (daysRemaining <= 0) {
      return monthlyBudget; // Last day of month
    }
    
    return monthlyBudget / daysRemaining;
  }

  /// Calculate daily limit based on 30-day average spending
  /// Provides intelligent fallback when no budget is set
  Future<double> _calculateFromAverageSpending() async {
    try {
      final expenses = await _getAllRecentExpenses();
      
      if (expenses.isEmpty) {
        return 0.0; // No spending history
      }
      
      // Filter to last 30 days
      final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
      final recentExpenses = expenses.where((expense) => 
        expense.date.isAfter(thirtyDaysAgo)
      ).toList();
      
      if (recentExpenses.isEmpty) {
        return 0.0;
      }
      
      // Calculate average daily spending
      final totalAmount = recentExpenses.fold<double>(
        0.0, 
        (sum, expense) => sum + expense.amount
      );
      
      // Average per day over the period we have data for
      final daysOfData = DateTime.now().difference(
        recentExpenses.last.date
      ).inDays + 1; // +1 to include both start and end dates
      
      return totalAmount / daysOfData;
    } catch (e) {
      // Fallback to very conservative estimate
      return 0.0;
    }
  }

  /// Get all expenses from repository
  /// Helper method to fetch expense data
  Future<List<ExpenseModel>> _getAllRecentExpenses() async {
    // This would typically use the expense repository
    // For now, returning empty list - will be implemented when integrating with expense system
    return [];
  }

  /// Helper method to get days in a given month
  int _getDaysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }
}