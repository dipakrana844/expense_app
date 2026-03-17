import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/constants/app_constants.dart';
import '../models/expense_model.dart';
import '../models/scheduled_expense_model.dart';

/// Local Data Source: Hive Implementation
///
/// Responsibilities:
/// - Direct interaction with Hive database
/// - CRUD operations for expenses
/// - Error handling for storage operations
/// - No business logic - pure data persistence
///
/// Design Decision: Abstract data source from repository
/// - Allows easy testing with mock implementations
/// - Single Responsibility: only handles Hive operations
/// - Repository coordinates business logic and error handling
class ExpenseLocalDataSource {
  late Box<ExpenseModel> _expenseBox;
  late Box<ScheduledExpenseModel> _scheduledBox;
  bool _isInitialized = false;

  /// Initialize Hive and open boxes
  ///
  /// CRITICAL: Must be called before any other operations
  /// Throws exception if initialization fails - app cannot function without storage
  ///
  /// Performance Note: This is async but should be called once at app startup
  Future<void> init() async {
    if (_isInitialized) return;

    try {
      // Initialize Hive with Flutter-specific path
      await Hive.initFlutter();

      // Register Adapters
      // Note: Using individual checks to prevent duplicate registration errors
      if (!Hive.isAdapterRegistered(0)) {
        Hive.registerAdapter(ExpenseModelAdapter());
      }

      if (!Hive.isAdapterRegistered(1)) {
        Hive.registerAdapter(ScheduledExpenseModelAdapter());
      }

      // Open boxes
      _expenseBox = await Hive.openBox<ExpenseModel>(
        AppConstants.expensesBoxName,
      );

      _scheduledBox = await Hive.openBox<ScheduledExpenseModel>(
        AppConstants.scheduledExpensesBoxName,
      );

      _isInitialized = true;
    } catch (e) {
      debugPrint('Failed to initialize Hive: $e');
      rethrow;
    }
  }


  /// Create a new expense
  ///
  /// Uses expense ID as key for direct access by ID
  /// Throws if storage write fails
  Future<void> createExpense(ExpenseModel expense) async {
    _ensureInitialized();
    try {
      await _expenseBox.put(expense.id, expense);
    } catch (e) {
      throw Exception('Failed to create expense: $e');
    }
  }

  /// Update an existing expense
  ///
  /// Same as create - Hive's put() handles both insert and update
  /// Returns updated model with new timestamp
  Future<void> updateExpense(ExpenseModel expense) async {
    _ensureInitialized();
    try {
      // Add update timestamp before saving
      final updatedExpense = expense.withUpdateTimestamp();
      await _expenseBox.put(updatedExpense.id, updatedExpense);
    } catch (e) {
      throw Exception('Failed to update expense: $e');
    }
  }

  /// Delete an expense by ID
  ///
  /// Idempotent: doesn't throw if ID doesn't exist
  Future<void> deleteExpense(String id) async {
    _ensureInitialized();
    try {
      await _expenseBox.delete(id);
    } catch (e) {
      throw Exception('Failed to delete expense: $e');
    }
  }

  /// Get all expenses
  ///
  /// Returns list of all expenses in storage
  /// Performance: O(n) - Hive loads all values
  /// For large datasets, consider lazy loading or pagination
  List<ExpenseModel> getAllExpenses() {
    _ensureInitialized();
    return _expenseBox.values.toList();
  }

  /// Get expense by ID
  ///
  /// Performance: O(1) - direct key access
  /// Returns null if not found
  ExpenseModel? getExpenseById(String id) {
    _ensureInitialized();
    return _expenseBox.get(id);
  }

  /// Get expenses for a specific date range
  ///
  /// Filters in-memory after loading all expenses
  /// For better performance with large datasets, consider indexing
  List<ExpenseModel> getExpensesByDateRange(DateTime start, DateTime end) {
    _ensureInitialized();
    final allExpenses = _expenseBox.values;

    return allExpenses.where((expense) {
      return expense.date.isAfter(start.subtract(const Duration(seconds: 1))) &&
          expense.date.isBefore(end.add(const Duration(seconds: 1)));
    }).toList();
  }

  /// Get expenses for a specific month
  ///
  /// Optimized query for monthly analytics
  List<ExpenseModel> getExpensesByMonth(int year, int month) {
    final start = DateTime(year, month, 1);
    final end = DateTime(year, month + 1, 0, 23, 59, 59);
    return getExpensesByDateRange(start, end);
  }

  /// Delete all expenses
  ///
  /// WARNING: Destructive operation - used for testing or reset functionality
  Future<void> clearAllExpenses() async {
    _ensureInitialized();
    try {
      await _expenseBox.clear();
    } catch (e) {
      throw Exception('Failed to clear expenses: $e');
    }
  }

  /// Watch expenses for real-time updates
  ///
  /// Returns a stream that emits when box changes
  /// Useful for reactive UI updates without polling
  Stream<BoxEvent> watchExpenses() {
    _ensureInitialized();
    return _expenseBox.watch();
  }

  /// Get total count of expenses
  ///
  /// Performance: O(1) - Hive maintains count
  int getExpenseCount() {
    _ensureInitialized();
    return _expenseBox.length;
  }

  /// Get all scheduled expenses
  List<ScheduledExpenseModel> getAllScheduledExpenses() {
    _ensureInitialized();
    return _scheduledBox.values.toList();
  }

  /// Clear all scheduled expenses
  Future<void> clearAllScheduledExpenses() async {
    _ensureInitialized();
    await _scheduledBox.clear();
  }

  /// Close the Hive box
  ///
  /// Should be called when app is disposed
  /// Prevents resource leaks
  Future<void> close() async {
    if (_isInitialized && _expenseBox.isOpen) {
      await _expenseBox.close();
      _isInitialized = false;
    }
  }

  /// Compact storage to reclaim space
  ///
  /// Hive doesn't automatically reclaim deleted space
  /// Call periodically or after bulk deletes
  Future<void> compact() async {
    _ensureInitialized();
    try {
      await _expenseBox.compact();
    } catch (e) {
      throw Exception('Failed to compact storage: $e');
    }
  }

  /// Internal helper to ensure initialization
  void _ensureInitialized() {
    if (!_isInitialized) {
      throw Exception('Local data source not initialized. Call init() first.');
    }
  }
}
