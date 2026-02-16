import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_expense_tracker/features/income/data/local/income_local_data_source.dart';
import 'package:smart_expense_tracker/features/income/data/repositories/income_repository_impl.dart';
import 'package:smart_expense_tracker/features/income/domain/repositories/income_repository.dart';
import 'package:smart_expense_tracker/features/income/domain/usecases/add_income_usecase.dart';
import 'package:smart_expense_tracker/features/income/domain/usecases/update_income_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:smart_expense_tracker/features/income/domain/usecases/delete_income_usecase.dart';
import '../../../transactions/presentation/providers/transaction_providers.dart';
import 'package:smart_expense_tracker/features/income/domain/usecases/get_incomes_usecase.dart';
import 'package:smart_expense_tracker/features/income/domain/entities/income_entity.dart';

/// Provider: incomeLocalDataSourceProvider
///
/// Purpose: Provides singleton instance of IncomeLocalDataSource
/// - Handles Hive initialization and adapter registration
/// - Ensures single source of data access
final incomeLocalDataSourceProvider = Provider<IncomeLocalDataSource>((ref) {
  return IncomeLocalDataSource();
});

/// Provider: incomeRepositoryProvider
///
/// Purpose: Provides IncomeRepository implementation
/// - Abstracts data source implementation details
/// - Enables dependency injection and testing
final incomeRepositoryProvider = Provider<IncomeRepository>((ref) {
  final dataSource = ref.watch(incomeLocalDataSourceProvider);
  return IncomeRepositoryImpl(dataSource);
});

/// Provider: addIncomeUseCaseProvider
///
/// Purpose: Provides AddIncomeUseCase instance
/// - Handles business logic for adding new incomes
final addIncomeUseCaseProvider = Provider<AddIncomeUseCase>((ref) {
  final repository = ref.watch(incomeRepositoryProvider);
  return AddIncomeUseCase(repository);
});

/// Provider: updateIncomeUseCaseProvider
///
/// Purpose: Provides UpdateIncomeUseCase instance
/// - Handles business logic for updating existing incomes
final updateIncomeUseCaseProvider = Provider<UpdateIncomeUseCase>((ref) {
  final repository = ref.watch(incomeRepositoryProvider);
  return UpdateIncomeUseCase(repository);
});

/// Provider: deleteIncomeUseCaseProvider
///
/// Purpose: Provides DeleteIncomeUseCase instance
/// - Handles business logic for deleting incomes
final deleteIncomeUseCaseProvider = Provider<DeleteIncomeUseCase>((ref) {
  final repository = ref.watch(incomeRepositoryProvider);
  return DeleteIncomeUseCase(repository);
});

/// Provider: getIncomesUseCaseProvider
///
/// Purpose: Provides GetIncomesUseCase instance
/// - Handles business logic for retrieving incomes
final getIncomesUseCaseProvider = Provider<GetIncomesUseCase>((ref) {
  final repository = ref.watch(incomeRepositoryProvider);
  return GetIncomesUseCase(repository);
});

/// Provider: incomesProvider
///
/// Purpose: Async data provider for all income records
/// - Fetches and manages income data state
/// - Handles loading, error, and data states
/// - Automatically updates when data changes
final incomesProvider = FutureProvider<List<IncomeEntity>>((ref) async {
  final useCase = ref.watch(getIncomesUseCaseProvider);
  return await useCase.getAllIncomes();
});

/// Provider: monthlyIncomeProvider
///
/// Purpose: Computed provider for current month's income total
/// - Calculates total income for the current month
/// - Updates automatically when incomes change
final monthlyIncomeProvider = FutureProvider<double>((ref) async {
  final incomesAsync = ref.watch(incomesProvider);
  
  return incomesAsync.when(
    data: (incomes) {
      final now = DateTime.now();
      final monthlyIncomes = incomes.where((income) => 
          income.date.year == now.year && 
          income.date.month == now.month);
      
      double total = 0.0;
      for (final income in monthlyIncomes) {
        total += income.amount;
      }
      return total;
    },
    loading: () => 0.0,
    error: (_, __) => 0.0,
  );
});

/// Provider: incomeSourcesProvider
///
/// Purpose: Provides list of all unique income sources
/// - Extracts distinct sources from income records
/// - Useful for dropdowns and filtering
final incomeSourcesProvider = FutureProvider<List<String>>((ref) async {
  final incomesAsync = ref.watch(incomesProvider);
  
  return incomesAsync.when(
    data: (incomes) {
      final sources = <String>{};
      for (final income in incomes) {
        sources.add(income.source);
      }
      final sourceList = sources.toList();
      sourceList.sort();
      return sourceList;
    },
    loading: () => [],
    error: (_, __) => [],
  );
});

/// Provider: recentIncomesProvider
///
/// Purpose: Provides recently added income records
/// - Shows last 10 income entries
/// - Useful for dashboard displays
final recentIncomesProvider = FutureProvider<List<IncomeEntity>>((ref) async {
  final useCase = ref.watch(getIncomesUseCaseProvider);
  return await useCase.getRecentIncomes(10);
});

/// Provider: significantIncomesProvider
///
/// Purpose: Provides significant income records (above threshold)
/// - Shows incomes above specified minimum amount
/// - Useful for highlighting major income events
final significantIncomesProvider = FutureProvider.family<List<IncomeEntity>, double>((ref, minAmount) async {
  final useCase = ref.watch(getIncomesUseCaseProvider);
  return await useCase.getSignificantIncomes(minAmount);
});

/// Provider: incomeBySourceProvider
///
/// Purpose: Provides incomes filtered by specific source
/// - Useful for source-based analysis
final incomeBySourceProvider = FutureProvider.family<List<IncomeEntity>, String>((ref, source) async {
  final useCase = ref.watch(getIncomesUseCaseProvider);
  return await useCase.getIncomesBySource(source);
});

/// Provider: incomeByMonthProvider
///
/// Purpose: Provides incomes for specific month
/// - Useful for monthly reporting and analytics
final incomeByMonthProvider = FutureProvider.family<List<IncomeEntity>, DateTime>((ref, month) async {
  final useCase = ref.watch(getIncomesUseCaseProvider);
  return await useCase.getIncomesByMonth(month.year, month.month);
});

/// Provider: totalIncomeByMonthProvider
///
/// Purpose: Provides total income for specific month
/// - Optimized calculation without loading all entities
final totalIncomeByMonthProvider = FutureProvider.family<double, DateTime>((ref, month) async {
  final useCase = ref.watch(getIncomesUseCaseProvider);
  return await useCase.getTotalIncomeByMonth(month.year, month.month);
});

/// Notifier for managing income form state
/// Handles form validation and submission logic
class IncomeFormNotifier extends StateNotifier<IncomeFormState> {
  final AddIncomeUseCase _addUseCase;
  final UpdateIncomeUseCase _updateUseCase;
  final Ref _ref;

  IncomeFormNotifier({
    required AddIncomeUseCase addUseCase,
    required UpdateIncomeUseCase updateUseCase,
    required Ref ref,
    IncomeEntity? initialIncome,
  })  : _addUseCase = addUseCase,
        _updateUseCase = updateUseCase,
        _ref = ref,
        super(
          IncomeFormState(
            id: initialIncome?.id,
            amount: initialIncome?.amount.toString() ?? '',
            source: initialIncome?.source ?? '',
            note: initialIncome?.note ?? '',
            date: initialIncome?.date ?? DateTime.now(),
            isEditing: initialIncome != null,
            isLoading: false,
            error: null,
          ),
        );

  void setAmount(String amount) {
    state = state.copyWith(amount: amount, error: null);
  }

  void setSource(String source) {
    state = state.copyWith(source: source, error: null);
  }

  void setNote(String note) {
    state = state.copyWith(note: note);
  }

  void setDate(DateTime date) {
    state = state.copyWith(date: date, error: null);
  }

  Future<void> submit() async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final amount = double.tryParse(state.amount);
      if (amount == null || amount <= 0) {
        state = state.copyWith(
          isLoading: false,
          error: 'Please enter a valid amount greater than 0',
        );
        return;
      }

      if (state.source.trim().isEmpty) {
        state = state.copyWith(
          isLoading: false,
          error: 'Please select an income source',
        );
        return;
      }

      if (state.isEditing && state.id != null) {
        // Update existing income
        await _updateUseCase.execute(
          id: state.id!,
          amount: amount,
          source: state.source,
          date: state.date,
          note: state.note.isEmpty ? null : state.note,
        );
      } else {
        // Add new income
        await _addUseCase.execute(
          amount: amount,
          source: state.source,
          date: state.date,
          note: state.note.isEmpty ? null : state.note,
        );
      }

      // Refresh the incomes provider
      _ref.invalidate(incomesProvider);
      
      // Also refresh transaction providers to update the UI
      try {
        _ref.read(transactionActionsProvider.notifier).refresh();
      } catch (e) {
        debugPrint('Failed to refresh transaction providers after income operation: $e');
      }
      
      state = state.copyWith(isLoading: false, error: null);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}

/// State class for income form
class IncomeFormState {
  final String? id;
  final String amount;
  final String source;
  final String note;
  final DateTime date;
  final bool isEditing;
  final bool isLoading;
  final String? error;

  IncomeFormState({
    this.id,
    required this.amount,
    required this.source,
    required this.note,
    required this.date,
    required this.isEditing,
    required this.isLoading,
    this.error,
  });

  IncomeFormState copyWith({
    String? id,
    String? amount,
    String? source,
    String? note,
    DateTime? date,
    bool? isEditing,
    bool? isLoading,
    String? error,
  }) {
    return IncomeFormState(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      source: source ?? this.source,
      note: note ?? this.note,
      date: date ?? this.date,
      isEditing: isEditing ?? this.isEditing,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

/// Provider for income form notifier
final incomeFormProvider = StateNotifierProvider.family<IncomeFormNotifier, IncomeFormState, IncomeEntity?>(
  (ref, initialIncome) {
    return IncomeFormNotifier(
      addUseCase: ref.watch(addIncomeUseCaseProvider),
      updateUseCase: ref.watch(updateIncomeUseCaseProvider),
      ref: ref,
      initialIncome: initialIncome,
    );
  },
);