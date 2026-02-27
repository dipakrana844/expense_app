import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/utils.dart';
import '../../../../features/expenses/presentation/providers/expense_providers.dart';
import '../../../../features/income/presentation/providers/income_providers.dart';
import '../../../../features/transfer/presentation/providers/transfer_providers.dart';
import '../../../../features/transfer/domain/entities/transfer_entity.dart';
import '../../../../features/daily_spend_guard/presentation/providers/daily_spend_providers.dart';
import '../../../../core/services/smart_suggestion_service.dart';
import '../../../../features/transactions/presentation/providers/transaction_providers.dart';
// NEW IMPORT

enum TransactionMode { income, expense, transfer }

class SmartEntryState {
  final TransactionMode mode;
  final String amountString;
  final String? category;
  final String? source;
  final String? account; // For income/expense
  final String? fromAccount; // For transfer
  final String? toAccount; // For transfer
  final double? transferFee;
  final String? note;
  final DateTime date;
  final TimeOfDay time;
  final bool isRecurring;
  final bool isLoading;
  final bool isEditing;
  final String? editingTransactionId;
  final String? error;

  SmartEntryState({
    this.mode = TransactionMode.expense,
    this.amountString = '',
    this.category,
    this.source,
    this.account,
    this.fromAccount,
    this.toAccount,
    this.transferFee,
    this.note,
    DateTime? date,
    TimeOfDay? time,
    this.isRecurring = false,
    this.isLoading = false,
    this.isEditing = false,
    this.editingTransactionId,
    this.error,
  }) : date = date ?? DateTime.now(), time = time ?? TimeOfDay.now();

  double get amount => CurrencyUtils.parseAmount(amountString) ?? 0.0;

  /// Get validation errors for current state
  List<String> get validationErrors {
    final errors = <String>[];
    
    // Amount validation
    if (amount <= 0) {
      errors.add('Amount must be greater than 0');
    }
    if (amount > AppConstants.maxExpenseAmount) {
      errors.add('Amount exceeds maximum limit of ${CurrencyUtils.formatAmount(AppConstants.maxExpenseAmount)}');
    }
    
    // Mode-specific validation
    switch (mode) {
      case TransactionMode.income:
        if (source == null || source!.trim().isEmpty) {
          errors.add('Source is required for income');
        }
        break;
      case TransactionMode.expense:
        if (category == null || category!.trim().isEmpty) {
          errors.add('Category is required for expense');
        }
        break;
      case TransactionMode.transfer:
        if (fromAccount == null || fromAccount!.trim().isEmpty) {
          errors.add('From account is required for transfer');
        }
        if (toAccount == null || toAccount!.trim().isEmpty) {
          errors.add('To account is required for transfer');
        }
        if (fromAccount != null && toAccount != null && fromAccount!.trim() == toAccount!.trim()) {
          errors.add('Cannot transfer to the same account');
        }
        break;
    }
    
    // Date validation
    if (date.isAfter(DateTime.now().add(const Duration(days: 1)))) {
      errors.add('Date cannot be in the future');
    }
    
    // Note length validation
    if (note != null && note!.length > AppConstants.maxNoteLength) {
      errors.add('Note is too long (maximum ${AppConstants.maxNoteLength} characters)');
    }
    
    return errors;
  }
  
  /// Check if form is ready for submission (more comprehensive than isValid)
  bool get isReadyForSubmission {
    // Must be valid
    if (!isValid) return false;
    
    // Must not be loading
    if (isLoading) return false;
    
    // Must have required fields filled
    switch (mode) {
      case TransactionMode.income:
        return source != null && source!.isNotEmpty && amount > 0;
      case TransactionMode.expense:
        return category != null && category!.isNotEmpty && amount > 0;
      case TransactionMode.transfer:
        return fromAccount != null && 
               toAccount != null && 
               fromAccount!.isNotEmpty && 
               toAccount!.isNotEmpty && 
               fromAccount != toAccount && 
               amount > 0;
    }
  }
  bool get isValid {
    // Amount validation
    if (amount <= 0) return false;
    if (amount > AppConstants.maxExpenseAmount) return false;
    
    // Mode-specific validation
    switch (mode) {
      case TransactionMode.income:
        return source != null && source!.isNotEmpty;
      case TransactionMode.expense:
        return category != null && category!.isNotEmpty;
      case TransactionMode.transfer:
        return fromAccount != null && 
               toAccount != null && 
               fromAccount!.isNotEmpty && 
               toAccount!.isNotEmpty && 
               fromAccount != toAccount;
    }
  }

  SmartEntryState copyWith({
    TransactionMode? mode, String? amountString, String? category, String? source, String? account,
    String? fromAccount, String? toAccount, double? transferFee, String? note,
    DateTime? date, TimeOfDay? time, bool? isRecurring, bool? isLoading, bool? isEditing,
    String? editingTransactionId, String? error,
  }) {
    return SmartEntryState(
      mode: mode ?? this.mode, amountString: amountString ?? this.amountString,
      category: category ?? this.category, source: source ?? this.source, account: account ?? this.account,
      fromAccount: fromAccount ?? this.fromAccount, toAccount: toAccount ?? this.toAccount,
      transferFee: transferFee ?? this.transferFee, note: note ?? this.note,
      date: date ?? this.date, time: time ?? this.time, isRecurring: isRecurring ?? this.isRecurring,
      isLoading: isLoading ?? this.isLoading, isEditing: isEditing ?? this.isEditing,
      editingTransactionId: editingTransactionId ?? this.editingTransactionId, error: error,
    );
  }

  SmartEntryState resetForm() {
    return SmartEntryState(
      mode: mode, amountString: '', category: category, source: source, account: account,
      fromAccount: fromAccount, toAccount: toAccount, transferFee: null, note: null,
      date: DateTime.now(), time: TimeOfDay.now(), isRecurring: false, isLoading: false,
      isEditing: false, editingTransactionId: null, error: null,
    );
  }
}

final smartEntryControllerProvider = StateNotifierProvider<SmartEntryController, SmartEntryState>((ref) => SmartEntryController(ref));

class SmartEntryController extends StateNotifier<SmartEntryState> {
  final Ref _ref;
  late final _SmartEntryPersistenceCoordinator _persistence;

  SmartEntryController(this._ref) : super(SmartEntryState()) {
    _persistence = _SmartEntryPersistenceCoordinator(_ref);
    _initSuggestions();
  }

  void _initSuggestions() {
    final suggestionService = _ref.read(smartSuggestionServiceProvider);
    switch (state.mode) {
      case TransactionMode.expense:
        final category = suggestionService.getLastExpenseCategory();
        if (category != null) state = state.copyWith(category: category);
        break;
      case TransactionMode.income:
        final source = suggestionService.getLastIncomeSource();
        if (source != null) state = state.copyWith(source: source);
        break;
      case TransactionMode.transfer:
        final accounts = suggestionService.getLastTransferAccounts();
        if (accounts.from != null) state = state.copyWith(fromAccount: accounts.from);
        if (accounts.to != null) state = state.copyWith(toAccount: accounts.to);
        break;
    }
  }

  void switchMode(TransactionMode newMode) {
    if (newMode == state.mode) return;
    final suggestionService = _ref.read(smartSuggestionServiceProvider);
    switch (newMode) {
      case TransactionMode.expense:
        final category = suggestionService.getLastExpenseCategory();
        state = state.copyWith(mode: newMode, category: category ?? state.category, account: state.account);
        break;
      case TransactionMode.income:
        final source = suggestionService.getLastIncomeSource();
        state = state.copyWith(mode: newMode, source: source ?? state.source, account: state.account);
        break;
      case TransactionMode.transfer:
        final accounts = suggestionService.getLastTransferAccounts();
        state = state.copyWith(mode: newMode, fromAccount: accounts.from ?? state.fromAccount, toAccount: accounts.to ?? state.toAccount);
        break;
    }
  }

  void resetForCreate() {
    state = SmartEntryState();
    _initSuggestions();
  }

  void loadForEdit(Map<String, dynamic> editData) {
    final id = editData['transactionId'] as String?;
    final modeValue = (editData['mode'] as String? ?? '').toLowerCase();
    final amount = (editData['amount'] as num?)?.toDouble() ?? 0.0;
    final dateMillis = editData['date'] as int?;
    final note = editData['note'] as String?;

    if (id == null || amount <= 0) {
      state = state.copyWith(error: 'Invalid edit transaction payload');
      return;
    }

    final parsedMode = switch (modeValue) {
      'income' => TransactionMode.income,
      'expense' => TransactionMode.expense,
      'transfer' => TransactionMode.transfer,
      _ => null,
    };

    if (parsedMode == null) {
      state = state.copyWith(error: 'Invalid edit mode');
      return;
    }

    final parsedDate = dateMillis != null
        ? DateTime.fromMillisecondsSinceEpoch(dateMillis)
        : DateTime.now();

    state = SmartEntryState(
      mode: parsedMode,
      amountString: amount.toStringAsFixed(2),
      category: editData['category'] as String?,
      source: editData['source'] as String?,
      account: editData['account'] as String?,
      note: note,
      date: parsedDate,
      time: TimeOfDay.fromDateTime(parsedDate),
      isEditing: true,
      editingTransactionId: id,
    );
  }

  void updateAmount(String digits) {
    if (digits.isEmpty) { state = state.copyWith(amountString: ''); return; }
    if (digits == 'BACK') {
      if (state.amountString.isNotEmpty) state = state.copyWith(amountString: state.amountString.substring(0, state.amountString.length - 1));
      return;
    }
    if (digits == '.') {
      if (!state.amountString.contains('.')) {
        state = state.copyWith(amountString: '${state.amountString}.');
      }
      return;
    }
    String newAmount = '${state.amountString}$digits';
    if (newAmount.contains('.')) {
      final parts = newAmount.split('.');
      if (parts.length > 1 && parts[1].length > 2) return;
    }
    final parsed = CurrencyUtils.parseAmount(newAmount);
    if (parsed != null && parsed > AppConstants.maxExpenseAmount) return;
    state = state.copyWith(amountString: newAmount);
  }

  void setAmount(double amount) =>
      state = state.copyWith(amountString: amount.toStringAsFixed(2));
  void setCategory(String? category) => state = state.copyWith(category: category);
  void setSource(String? source) => state = state.copyWith(source: source);
  void setAccount(String? account) => state = state.copyWith(account: account);
  void setFromAccount(String? account) => state = state.copyWith(fromAccount: account);
  void setToAccount(String? account) => state = state.copyWith(toAccount: account);
  void setTransferFee(double? fee) => state = state.copyWith(transferFee: fee);
  void setNote(String? note) => state = state.copyWith(note: note);
  void setDate(DateTime date) => state = state.copyWith(date: date);
  void setTime(TimeOfDay time) => state = state.copyWith(time: time);
  void toggleRecurring() => state = state.copyWith(isRecurring: !state.isRecurring);
  void setRecurring(bool value) => state = state.copyWith(isRecurring: value);

  Future<bool> save() async {
    if (!state.isValid) return false;
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _persistence.saveForState(state);
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<bool> saveAndContinue() async {
    final success = await save();
    if (success) { state = state.resetForm(); _initSuggestions(); }
    return success;
  }

  double? getDailySpendPreview() {
    if (state.mode != TransactionMode.expense) return null;
    if (state.amount <= 0) return null;
    final dailySpendState = _ref.read(dailySpendStateProvider);
    return dailySpendState.maybeWhen(
      data: (s) => s.dailyLimit - s.todaySpent - state.amount,
      orElse: () => null,
    );
  }

  double? getIncomeBalancePreview() {
    if (state.mode != TransactionMode.income) return null;
    if (state.amount <= 0) return null;
    // For now, just return the income amount - in a full implementation,
    // this would calculate the new total balance
    return state.amount;
  }

  String? getTransferPreview() {
    if (state.mode != TransactionMode.transfer) return null;
    if (state.fromAccount == null || state.toAccount == null) return null;
    if (state.amount <= 0) return null;
    return '${state.fromAccount!} -> ${state.toAccount!}';
  }

  String getFormattedAmount() {
    if (state.amountString.isEmpty) return '${AppConstants.currencySymbol}0';
    final amount = CurrencyUtils.parseAmount(state.amountString) ?? 0;
    return CurrencyUtils.formatAmount(amount);
  }

  Color getAccentColor(BuildContext context) {
    switch (state.mode) {
      case TransactionMode.income: return const Color(0xFF2196F3);
      case TransactionMode.expense: return const Color(0xFFF44336);
      case TransactionMode.transfer: return const Color(0xFF757575);
    }
  }
}

class _SmartEntryPersistenceCoordinator {
  final Ref _ref;

  const _SmartEntryPersistenceCoordinator(this._ref);

  Future<void> saveForState(SmartEntryState state) async {
    switch (state.mode) {
      case TransactionMode.expense:
        await _saveExpense(state);
        break;
      case TransactionMode.income:
        await _saveIncome(state);
        break;
      case TransactionMode.transfer:
        await _saveTransfer(state);
        break;
    }
  }

  Future<void> _saveExpense(SmartEntryState state) async {
    if (state.isEditing && state.editingTransactionId != null) {
      final repository = _ref.read(expenseRepositoryProvider);
      await repository.updateExpense(
        id: state.editingTransactionId!,
        amount: state.amount,
        category: state.category!,
        date: state.date,
        note: state.note,
      );
      try {
        _ref.read(transactionActionsProvider.notifier).refresh();
      } catch (e) {
        debugPrint(
          'Failed to refresh transaction providers after updating expense: $e',
        );
      }
      return;
    }

    final notifier = _ref.read(expensesProvider.notifier);
    await notifier.addExpense(
      amount: state.amount,
      category: state.category!,
      date: state.date,
      note: state.note,
      isRecurring: state.isRecurring,
    );
    final dailySpendNotifier = _ref.read(dailySpendStateProvider.notifier);
    await dailySpendNotifier.addSpending(state.amount);
  }

  Future<void> _saveIncome(SmartEntryState state) async {
    if (state.isEditing && state.editingTransactionId != null) {
      final updateUseCase = _ref.read(updateIncomeUseCaseProvider);
      await updateUseCase.execute(
        id: state.editingTransactionId!,
        amount: state.amount,
        source: state.source!,
        date: state.date,
        note: state.note,
      );
      _ref.invalidate(incomesProvider);
    } else {
      final addUseCase = _ref.read(addIncomeUseCaseProvider);
      await addUseCase.execute(
        amount: state.amount,
        source: state.source!,
        date: state.date,
        note: state.note,
      );
    }

    try {
      _ref.read(transactionActionsProvider.notifier).refresh();
    } catch (e) {
      debugPrint(
        'Failed to refresh transaction providers after smart entry income: $e',
      );
    }
  }

  Future<void> _saveTransfer(SmartEntryState state) async {
    final notifier = _ref.read(transfersProvider.notifier);
    if (state.isEditing && state.editingTransactionId != null) {
      final repository = _ref.read(transferRepositoryProvider);
      final existing = await repository.getTransferById(state.editingTransactionId!);
      if (existing == null) {
        throw Exception('Transfer with id ${state.editingTransactionId!} not found');
      }

      await notifier.updateTransfer(
        TransferEntity(
          id: existing.id,
          amount: state.amount,
          fromAccount: state.fromAccount!,
          toAccount: state.toAccount!,
          date: state.date,
          fee: state.transferFee ?? 0.0,
          note: state.note,
          createdAt: existing.createdAt,
          updatedAt: DateTime.now(),
          metadata: existing.metadata,
        ),
      );
      return;
    }

    await notifier.addTransfer(
      amount: state.amount,
      fromAccount: state.fromAccount!,
      toAccount: state.toAccount!,
      date: state.date,
      fee: state.transferFee,
      note: state.note,
    );
  }
}
