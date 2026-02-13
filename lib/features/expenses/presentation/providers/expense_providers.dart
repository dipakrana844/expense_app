import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';
import 'package:smart_expense_tracker/core/constants/app_constants.dart';
import 'package:smart_expense_tracker/core/services/aggregation_service.dart';
import 'package:smart_expense_tracker/features/settings/presentation/providers/settings_providers.dart';
import 'package:smart_expense_tracker/features/expenses/data/local/expense_local_data_source.dart';
import 'package:smart_expense_tracker/features/expenses/data/repositories/expense_repository.dart';
import 'package:smart_expense_tracker/features/expenses/domain/entities/expense_entity.dart';
import 'package:smart_expense_tracker/features/expenses/data/models/scheduled_expense_model.dart';

/// Provider: Connectivity
final connectivityProvider = StreamProvider<ConnectivityResult>((ref) {
  return Connectivity().onConnectivityChanged.map((results) => results.first);
});

final isOnlineProvider = Provider<bool>((ref) {
  final connectivity = ref.watch(connectivityProvider);
  return connectivity.maybeWhen(
    data: (result) => result != ConnectivityResult.none,
    orElse: () => true,
  );
});

/// Provider: Data Source
final expenseLocalDataSourceProvider = Provider<ExpenseLocalDataSource>((ref) {
  return ExpenseLocalDataSource(); // Overridden in main.dart
});

/// Provider: Repository (DI fixed with named parameter)
final expenseRepositoryProvider = Provider<ExpenseRepository>((ref) {
  final dataSource = ref.watch(expenseLocalDataSourceProvider);
  return ExpenseRepository(localDataSource: dataSource);
});

/// State Notifier for Expenses
class ExpensesNotifier extends StateNotifier<AsyncValue<List<ExpenseEntity>>> {
  final ExpenseRepository _repository;
  final Ref _ref;
  StreamSubscription? _subscription;

  ExpensesNotifier(this._repository, this._ref) : super(const AsyncValue.loading()) {
    _listenToExpenses();
  }

  void _listenToExpenses() {
    _subscription?.cancel();
    _subscription = _repository.watchExpenses().listen(
      (expenses) => state = AsyncValue.data(expenses),
      onError: (err, stack) => state = AsyncValue.error(err, stack),
    );
  }

  Future<void> refresh() async {
    final (expenses, error) = _repository.getAllExpenses();
    if (error == null && expenses != null) {
      state = AsyncValue.data(expenses);
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  Future<void> addExpense({
    required double amount,
    required String category,
    required DateTime date,
    String? note,
    bool isRecurring = false,
  }) async {
    if (isRecurring) {
      final box = await Hive.openBox<ScheduledExpenseModel>(
        AppConstants.scheduledExpensesBoxName,
      );
      final schedule = ScheduledExpenseModel(
        id: const Uuid().v4(),
        amount: amount,
        category: category,
        dayOfMonth: date.day,
        nextRunDate: date,
        note: note,
        isActive: true,
      );
      await box.put(schedule.id, schedule);
    } else {
      await _repository.createExpense(
        amount: amount,
        category: category,
        date: date,
        note: note,
      );
    }
    
    // Update storage usage after adding expense
    try {
      final settingsNotifier = _ref.read(appSettingsNotifierProvider.notifier);
      await settingsNotifier.recalculateStorageUsage();
    } catch (e) {
      // Silently fail if settings not available
      debugPrint('Failed to update storage usage after adding expense: $e');
    }
  }

  Future<void> updateExpense({
    required String id,
    required double amount,
    required String category,
    required DateTime date,
    String? note,
  }) async {
    await _repository.updateExpense(
      id: id,
      amount: amount,
      category: category,
      date: date,
      note: note,
    );
    
    // Update storage usage after updating expense
    try {
      final settingsNotifier = _ref.read(appSettingsNotifierProvider.notifier);
      await settingsNotifier.recalculateStorageUsage();
    } catch (e) {
      // Silently fail if settings not available
      debugPrint('Failed to update storage usage after updating expense: $e');
    }
  }

  Future<void> deleteExpense(String id) async {
    await _repository.deleteExpense(id);
    
    // Update storage usage after deleting expense
    try {
      final settingsNotifier = _ref.read(appSettingsNotifierProvider.notifier);
      await settingsNotifier.recalculateStorageUsage();
    } catch (e) {
      // Silently fail if settings not available
      debugPrint('Failed to update storage usage after deleting expense: $e');
    }
  }

  /// Seed dummy data for testing purposes
  ///
  /// Adds a set of sample expenses to the repository
  Future<void> seedDummyData() async {
    final now = DateTime.now();
    final dummyData = [
      {
        'amount': 45.50,
        'category': 'Grocery',
        'note': 'Grocery shopping',
        'days': 0,
      },
      {
        'amount': 12.00,
        'category': 'Transportation',
        'note': 'Bus fare',
        'days': 0,
      },
      {
        'amount': 120.00,
        'category': 'Shopping',
        'note': 'New running shoes',
        'days': 1,
      },
      {
        'amount': 25.00,
        'category': 'Entertainment',
        'note': 'Cinema tickets',
        'days': 2,
      },
      {
        'amount': 85.00,
        'category': 'Healthcare',
        'note': 'Doctor visit',
        'days': 3,
      },
      {
        'amount': 200.00,
        'category': 'Bills & Utilities',
        'note': 'Electricity bill',
        'days': 5,
      },
      {
        'amount': 15.00,
        'category': 'Food & Dining',
        'note': 'Lunch with friend',
        'days': 6,
      },
      {
        'amount': 50.00,
        'category': 'Transportation',
        'note': 'Gas refill',
        'days': 8,
      },
      {'amount': 30.00, 'category': 'Shopping', 'note': 'Books', 'days': 10},
      {
        'amount': 10.00,
        'category': 'Food & Dining',
        'note': 'Coffee morning',
        'days': 12,
      },
    ];

    for (final data in dummyData) {
      await _repository.createExpense(
        amount: data['amount'] as double,
        category: data['category'] as String,
        date: now.subtract(Duration(days: data['days'] as int)),
        note: data['note'] as String?,
      );
    }
  }
}

/// Base Expenses Provider
final expensesProvider =
    StateNotifierProvider<ExpensesNotifier, AsyncValue<List<ExpenseEntity>>>((
      ref,
    ) {
      final repository = ref.watch(expenseRepositoryProvider);
      return ExpensesNotifier(repository, ref);
    });

/// Search & Filter State
final searchQueryProvider = StateProvider<String>((ref) => '');
final dateFilterProvider = StateProvider<DateTimeRange?>((ref) => null);

/// Filtered List Provider
final filteredExpensesProvider = Provider<List<ExpenseEntity>>((ref) {
  final expensesAsync = ref.watch(expensesProvider);
  final query = ref.watch(searchQueryProvider).toLowerCase();
  final range = ref.watch(dateFilterProvider);

  return expensesAsync.maybeWhen(
    data: (expenses) {
      return expenses.where((e) {
        final matchesSearch =
            e.category.toLowerCase().contains(query) ||
            (e.note?.toLowerCase().contains(query) ?? false);
        final matchesDate =
            range == null ||
            (e.date.isAfter(range.start.subtract(const Duration(seconds: 1))) &&
                e.date.isBefore(range.end.add(const Duration(days: 1))));
        return matchesSearch && matchesDate;
      }).toList();
    },
    orElse: () => [],
  );
});

/// Grouped Map Provider
final expensesGroupedByDateProvider =
    Provider<Map<String, List<ExpenseEntity>>>((ref) {
      final expenses = ref.watch(filteredExpensesProvider);
      final grouped = <String, List<ExpenseEntity>>{};
      for (final expense in expenses) {
        grouped.putIfAbsent(expense.dateKey, () => []).add(expense);
      }
      return grouped;
    });

/// Analytics Model
class MonthlyAnalytics {
  final double totalSpent;
  final Map<String, double> categoryBreakdown;
  final String? topCategory;
  final double topAmount;
  final int expenseCount;

  MonthlyAnalytics({
    required this.totalSpent,
    required this.categoryBreakdown,
    this.topCategory,
    required this.topAmount,
    required this.expenseCount,
  });

  double get total => totalSpent;
  bool get hasExpenses => expenseCount > 0;
  double get averageExpense =>
      expenseCount > 0 ? totalSpent / expenseCount : 0.0;

  factory MonthlyAnalytics.empty() => MonthlyAnalytics(
    totalSpent: 0,
    categoryBreakdown: {},
    topAmount: 0,
    expenseCount: 0,
  );
}

/// Monthly Analytics Provider
/// Uses shared AggregationService for consistent calculations
final monthlyAnalyticsProvider = Provider<MonthlyAnalytics>((ref) {
  final expensesAsync = ref.watch(expensesProvider);

  return expensesAsync.maybeWhen(
    data: (expenses) {
      final now = DateTime.now();
      final currentMonthExpenses = AggregationService.filterByMonth(
        transactions: expenses,
        year: now.year,
        month: now.month,
      );

      // Use shared service for calculations
      final total = AggregationService.calculateTotal(transactions: currentMonthExpenses);
      final categoryBreakdown = AggregationService.calculateCategoryBreakdown(
        transactions: currentMonthExpenses,
      );
      
      final topCategories = AggregationService.getTopCategories(
        transactions: currentMonthExpenses,
        limit: 1,
      );

      return MonthlyAnalytics(
        totalSpent: total,
        categoryBreakdown: categoryBreakdown.map((key, value) => MapEntry(key, value.amount)),
        topCategory: topCategories.isNotEmpty ? topCategories.first.category : null,
        topAmount: topCategories.isNotEmpty ? topCategories.first.amount : 0.0,
        expenseCount: currentMonthExpenses.length,
      );
    },
    orElse: () => MonthlyAnalytics.empty(),
  );
});

/// Provider: Monthly Trend Data (Last 6 Months)
/// Uses shared AggregationService for consistent monthly calculations
final monthlyTrendProvider = Provider<Map<String, double>>((ref) {
  final expensesAsync = ref.watch(expensesProvider);

  return expensesAsync.maybeWhen(
    data: (expenses) {
      final trend = <String, double>{};
      final now = DateTime.now();

      // Use shared service for consistent month-based filtering
      for (int i = 5; i >= 0; i--) {
        final monthDate = DateTime(now.year, now.month - i, 1);
        final monthKey = "${monthDate.month}/${monthDate.year}";

        final monthExpenses = AggregationService.filterByMonth(
          transactions: expenses,
          year: monthDate.year,
          month: monthDate.month,
        );
        
        final monthTotal = AggregationService.calculateTotal(transactions: monthExpenses);
        trend[monthKey] = monthTotal;
      }
      
      return trend;
    },
    orElse: () => {},
  );
});
