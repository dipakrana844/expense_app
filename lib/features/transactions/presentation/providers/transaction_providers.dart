import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/entities/transaction_summary.dart';
import '../../domain/enums/transaction_type.dart';
import '../../shared/utils/transaction_utils.dart';
import '../../../income/presentation/providers/income_providers.dart';
import '../../../expenses/presentation/providers/expense_providers.dart';
import 'transaction_infrastructure_providers.dart';

// ---------------------------------------------------------------------------
// Filter State
// ---------------------------------------------------------------------------

/// State for transaction filtering
class TransactionFilterState {
  final TransactionType? type;
  final DateTime? selectedDate;
  final String? searchTerm;

  const TransactionFilterState({this.type, this.selectedDate, this.searchTerm});

  factory TransactionFilterState.initial() => const TransactionFilterState();

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

  bool get hasFilters =>
      type != null || selectedDate != null || searchTerm?.isNotEmpty == true;
}

// ---------------------------------------------------------------------------
// Transaction Filter — NotifierProvider (replaces StateNotifierProvider)
// ---------------------------------------------------------------------------

final transactionFilterProvider =
    NotifierProvider<TransactionFilterNotifier, TransactionFilterState>(
      TransactionFilterNotifier.new,
    );

class TransactionFilterNotifier extends Notifier<TransactionFilterState> {
  @override
  TransactionFilterState build() => TransactionFilterState.initial();

  void setType(TransactionType? type) => state = state.copyWith(type: type);

  void setSelectedDate(DateTime date) =>
      state = state.copyWith(selectedDate: date);

  void setSearchTerm(String term) => state = state.copyWith(searchTerm: term);

  void clearFilters() => state = TransactionFilterState.initial();

  void toggleType(TransactionType type) {
    state.type == type ? setType(null) : setType(type);
  }
}

// ---------------------------------------------------------------------------
// Current displayed month — StateProvider (simple scalar, fine as-is)
// ---------------------------------------------------------------------------

final currentMonthProvider = StateProvider<DateTime>((ref) => DateTime.now());

// ---------------------------------------------------------------------------
// All transactions — AsyncNotifierProvider (replaces FutureProvider)
// ---------------------------------------------------------------------------

final allTransactionsProvider =
    AsyncNotifierProvider<AllTransactionsNotifier, List<TransactionEntity>>(
      AllTransactionsNotifier.new,
    );

class AllTransactionsNotifier extends AsyncNotifier<List<TransactionEntity>> {
  @override
  Future<List<TransactionEntity>> build() async {
    // Re-run whenever either data source changes.
    ref.watch(incomesProvider);
    ref.watch(expensesProvider);
    final repository = ref.watch(transactionRepositoryProvider);
    return repository.getAllTransactions();
  }
}

// ---------------------------------------------------------------------------
// Filtered transactions — AsyncNotifierProvider
// ---------------------------------------------------------------------------

final filteredTransactionsProvider =
    AsyncNotifierProvider<
      FilteredTransactionsNotifier,
      List<TransactionEntity>
    >(FilteredTransactionsNotifier.new);

class FilteredTransactionsNotifier
    extends AsyncNotifier<List<TransactionEntity>> {
  @override
  Future<List<TransactionEntity>> build() async {
    final repository = ref.watch(transactionRepositoryProvider);
    final filterState = ref.watch(transactionFilterProvider);
    final currentMonth = ref.watch(currentMonthProvider);

    // Re-run on underlying data changes.
    ref.watch(incomesProvider);
    ref.watch(expensesProvider);

    List<TransactionEntity> transactions;

    if (filterState.type != null) {
      transactions = await repository.getTransactionsByType(filterState.type);
    } else {
      transactions = await repository.getMonthlyTransactions(currentMonth);
    }

    // Apply search filter
    if (filterState.searchTerm?.isNotEmpty == true) {
      final lowerSearch = filterState.searchTerm!.toLowerCase();
      transactions = transactions.where((t) {
        return t.categoryOrSource.toLowerCase().contains(lowerSearch) ||
            (t.note != null && t.note!.toLowerCase().contains(lowerSearch));
      }).toList();
    }

    return transactions;
  }
}

// ---------------------------------------------------------------------------
// Grouped transactions — derived async provider
// ---------------------------------------------------------------------------

final groupedTransactionsProvider =
    AsyncNotifierProvider<
      GroupedTransactionsNotifier,
      Map<String, List<TransactionEntity>>
    >(GroupedTransactionsNotifier.new);

class GroupedTransactionsNotifier
    extends AsyncNotifier<Map<String, List<TransactionEntity>>> {
  @override
  Future<Map<String, List<TransactionEntity>>> build() async {
    final transactionsAsync = await ref.watch(
      filteredTransactionsProvider.future,
    );
    return TransactionUtils.groupByDate(transactionsAsync);
  }
}

// ---------------------------------------------------------------------------
// Transaction summary — AsyncNotifierProvider
// ---------------------------------------------------------------------------

final transactionSummaryProvider =
    AsyncNotifierProvider<TransactionSummaryNotifier, TransactionSummary>(
      TransactionSummaryNotifier.new,
    );

class TransactionSummaryNotifier extends AsyncNotifier<TransactionSummary> {
  @override
  Future<TransactionSummary> build() async {
    final repository = ref.watch(transactionRepositoryProvider);
    final currentMonth = ref.watch(currentMonthProvider);

    ref.watch(incomesProvider);
    ref.watch(expensesProvider);

    return repository.getMonthSummary(currentMonth);
  }
}

// ---------------------------------------------------------------------------
// Transaction Actions — Notifier<void> (replaces dummy StateNotifier<bool>)
// ---------------------------------------------------------------------------

final transactionActionsProvider =
    NotifierProvider<TransactionActionsNotifier, void>(
      TransactionActionsNotifier.new,
    );

class TransactionActionsNotifier extends Notifier<void> {
  @override
  void build() {
    // No state — this notifier only exposes imperative actions.
  }

  /// Invalidate all transaction data providers to trigger re-fetch.
  void refresh() {
    ref.invalidate(allTransactionsProvider);
    ref.invalidate(filteredTransactionsProvider);
    ref.invalidate(groupedTransactionsProvider);
    ref.invalidate(transactionSummaryProvider);
  }

  /// Navigate to previous month
  void goToPreviousMonth() {
    final current = ref.read(currentMonthProvider);
    ref.read(currentMonthProvider.notifier).state = DateTime(
      current.year,
      current.month - 1,
    );
    refresh();
  }

  /// Navigate to next month
  void goToNextMonth() {
    final current = ref.read(currentMonthProvider);
    ref.read(currentMonthProvider.notifier).state = DateTime(
      current.year,
      current.month + 1,
    );
    refresh();
  }

  /// Navigate to today
  void goToToday() {
    ref.read(currentMonthProvider.notifier).state = DateTime.now();
    refresh();
  }
}

// ---------------------------------------------------------------------------
// Derived selector providers
// ---------------------------------------------------------------------------

/// Income-only transactions
final incomeTransactionsProvider =
    AsyncNotifierProvider<IncomeTransactionsNotifier, List<TransactionEntity>>(
      IncomeTransactionsNotifier.new,
    );

class IncomeTransactionsNotifier
    extends AsyncNotifier<List<TransactionEntity>> {
  @override
  Future<List<TransactionEntity>> build() async {
    final transactions = await ref.watch(filteredTransactionsProvider.future);
    return transactions.where((t) => t.isIncome).toList();
  }
}

/// Expense-only transactions
final expenseTransactionsProvider =
    AsyncNotifierProvider<ExpenseTransactionsNotifier, List<TransactionEntity>>(
      ExpenseTransactionsNotifier.new,
    );

class ExpenseTransactionsNotifier
    extends AsyncNotifier<List<TransactionEntity>> {
  @override
  Future<List<TransactionEntity>> build() async {
    final transactions = await ref.watch(filteredTransactionsProvider.future);
    return transactions.where((t) => t.isExpense).toList();
  }
}

/// Net balance for current month
final netBalanceProvider = AsyncNotifierProvider<NetBalanceNotifier, double>(
  NetBalanceNotifier.new,
);

class NetBalanceNotifier extends AsyncNotifier<double> {
  @override
  Future<double> build() async {
    final summary = await ref.watch(transactionSummaryProvider.future);
    return summary.netBalance;
  }
}
