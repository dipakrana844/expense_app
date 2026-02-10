import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/enums/transaction_type.dart';
import '../../data/repositories/transaction_repository.dart';
import '../../shared/utils/transaction_utils.dart';

/// State for transaction filtering
class TransactionFilterState {
  final TransactionType? type;
  final DateTime? selectedDate;
  final String? searchTerm;

  TransactionFilterState({
    this.type,
    this.selectedDate,
    this.searchTerm,
  });

  /// Create initial state (show all transactions)
  factory TransactionFilterState.initial() {
    return TransactionFilterState();
  }

  /// Copy with new values
  TransactionFilterState copyWith({
    TransactionType? type,
    DateTime? selectedDate,
    String? searchTerm,
  }) {
    return TransactionFilterState(
      type: type ?? this.type,
      selectedDate: selectedDate ?? this.selectedDate,
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }

  /// Check if any filters are applied
  bool get hasFilters {
    return type != null || selectedDate != null || searchTerm?.isNotEmpty == true;
  }
}

/// Provider for current transaction filter state
final transactionFilterProvider =
    StateNotifierProvider<TransactionFilterNotifier, TransactionFilterState>(
        (ref) {
  return TransactionFilterNotifier();
});

/// State notifier for managing transaction filters
class TransactionFilterNotifier extends StateNotifier<TransactionFilterState> {
  TransactionFilterNotifier() : super(TransactionFilterState.initial());

  /// Set transaction type filter
  void setType(TransactionType? type) {
    state = state.copyWith(type: type);
  }

  /// Set selected date for navigation
  void setSelectedDate(DateTime date) {
    state = state.copyWith(selectedDate: date);
  }

  /// Set search term
  void setSearchTerm(String term) {
    state = state.copyWith(searchTerm: term);
  }

  /// Clear all filters
  void clearFilters() {
    state = TransactionFilterState.initial();
  }

  /// Toggle between transaction types
  void toggleType(TransactionType type) {
    if (state.type == type) {
      setType(null); // Clear filter if same type clicked
    } else {
      setType(type);
    }
  }
}

/// Provider for current displayed month
final currentMonthProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});

/// Provider for all transactions (unfiltered)
final allTransactionsProvider =
    FutureProvider<List<TransactionEntity>>((ref) async {
  final repository = ref.watch(transactionRepositoryProvider);
  return await repository.getAllTransactions();
});

/// Provider for filtered transactions
final filteredTransactionsProvider =
    FutureProvider<List<TransactionEntity>>((ref) async {
  final repository = ref.watch(transactionRepositoryProvider);
  final filterState = ref.watch(transactionFilterProvider);
  final currentMonth = ref.watch(currentMonthProvider);

  List<TransactionEntity> transactions;

  // Apply type filter
  if (filterState.type != null) {
    transactions = await repository.getTransactionsByType(filterState.type);
  } else {
    transactions = await repository.getMonthlyTransactions(currentMonth);
  }

  // Apply search filter
  if (filterState.searchTerm?.isNotEmpty == true) {
    final lowerSearch = filterState.searchTerm!.toLowerCase();
    transactions = transactions.where((transaction) {
      return transaction.categoryOrSource.toLowerCase().contains(lowerSearch) ||
          (transaction.note != null &&
              transaction.note!.toLowerCase().contains(lowerSearch));
    }).toList();
  }

  return transactions;
});

/// Provider for grouped transactions (by date)
final groupedTransactionsProvider =
    FutureProvider<Map<String, List<TransactionEntity>>>((ref) async {
  final transactionsAsync = ref.watch(filteredTransactionsProvider);

  return transactionsAsync.when(
    data: (transactions) {
      return TransactionUtils.groupByDate(transactions);
    },
    loading: () => {},
    error: (_, __) => {},
  );
});

/// Provider for transaction summary statistics
final transactionSummaryProvider =
    FutureProvider<TransactionSummary>((ref) async {
  final repository = ref.watch(transactionRepositoryProvider);
  final currentMonth = ref.watch(currentMonthProvider);
  
  return await repository.getMonthSummary(currentMonth);
});

/// Provider for quick transaction actions
class TransactionActionsNotifier extends StateNotifier<bool> {
  final Ref _ref;

  TransactionActionsNotifier(this._ref) : super(false);

  /// Refresh all transaction data
  Future<void> refresh() async {
    // Invalidate dependent providers to trigger refresh
    _ref.invalidate(allTransactionsProvider);
    _ref.invalidate(filteredTransactionsProvider);
    _ref.invalidate(groupedTransactionsProvider);
    _ref.invalidate(transactionSummaryProvider);
  }

  /// Navigate to previous month
  void goToPreviousMonth() {
    final currentMonth = _ref.read(currentMonthProvider);
    final previousMonth = DateTime(currentMonth.year, currentMonth.month - 1);
    _ref.read(currentMonthProvider.notifier).state = previousMonth;
    
    // Refresh data for new month
    refresh();
  }

  /// Navigate to next month
  void goToNextMonth() {
    final currentMonth = _ref.read(currentMonthProvider);
    final nextMonth = DateTime(currentMonth.year, currentMonth.month + 1);
    _ref.read(currentMonthProvider.notifier).state = nextMonth;
    
    // Refresh data for new month
    refresh();
  }

  /// Navigate to today
  void goToToday() {
    _ref.read(currentMonthProvider.notifier).state = DateTime.now();
    refresh();
  }
}

/// Provider for transaction actions
final transactionActionsProvider =
    StateNotifierProvider<TransactionActionsNotifier, bool>((ref) {
  return TransactionActionsNotifier(ref);
});

/// Selector provider for income transactions only
final incomeTransactionsProvider =
    FutureProvider<List<TransactionEntity>>((ref) async {
  final transactionsAsync = ref.watch(filteredTransactionsProvider);
  
  return transactionsAsync.when(
    data: (transactions) {
      return transactions.where((t) => t.isIncome).toList();
    },
    loading: () => [],
    error: (_, __) => [],
  );
});

/// Selector provider for expense transactions only
final expenseTransactionsProvider =
    FutureProvider<List<TransactionEntity>>((ref) async {
  final transactionsAsync = ref.watch(filteredTransactionsProvider);
  
  return transactionsAsync.when(
    data: (transactions) {
      return transactions.where((t) => t.isExpense).toList();
    },
    loading: () => [],
    error: (_, __) => [],
  );
});

/// Selector provider for net balance
final netBalanceProvider = FutureProvider<double>((ref) async {
  final summaryAsync = ref.watch(transactionSummaryProvider);
  
  return summaryAsync.when(
    data: (summary) => summary.netBalance,
    loading: () => 0.0,
    error: (_, __) => 0.0,
  );
});