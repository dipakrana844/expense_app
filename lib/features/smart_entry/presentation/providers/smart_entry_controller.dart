import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/utils.dart';
import '../../../../features/expenses/presentation/providers/expense_providers.dart';
import '../../../../features/income/presentation/providers/income_providers.dart';
import '../../../../features/transfer/presentation/providers/transfer_providers.dart';
import '../../../../features/daily_spend_guard/presentation/providers/daily_spend_providers.dart';
import '../../../../core/services/smart_suggestion_service.dart';

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
    this.error,
  }) : date = date ?? DateTime.now(), time = time ?? TimeOfDay.now();

  double get amount => CurrencyUtils.parseAmount(amountString) ?? 0.0;

  bool get isValid {
    if (amount <= 0) return false;
    switch (mode) {
      case TransactionMode.income:
        return source != null && source!.isNotEmpty;
      case TransactionMode.expense:
        return category != null && category!.isNotEmpty;
      case TransactionMode.transfer:
        return fromAccount != null && toAccount != null && fromAccount!.isNotEmpty && toAccount!.isNotEmpty && fromAccount != toAccount;
    }
  }

  SmartEntryState copyWith({
    TransactionMode? mode, String? amountString, String? category, String? source, String? account,
    String? fromAccount, String? toAccount, double? transferFee, String? note,
    DateTime? date, TimeOfDay? time, bool? isRecurring, bool? isLoading, String? error,
  }) {
    return SmartEntryState(
      mode: mode ?? this.mode, amountString: amountString ?? this.amountString,
      category: category ?? this.category, source: source ?? this.source, account: account ?? this.account,
      fromAccount: fromAccount ?? this.fromAccount, toAccount: toAccount ?? this.toAccount,
      transferFee: transferFee ?? this.transferFee, note: note ?? this.note,
      date: date ?? this.date, time: time ?? this.time, isRecurring: isRecurring ?? this.isRecurring,
      isLoading: isLoading ?? this.isLoading, error: error,
    );
  }

  SmartEntryState resetForm() {
    return SmartEntryState(
      mode: mode, amountString: '', category: category, source: source, account: account,
      fromAccount: fromAccount, toAccount: toAccount, transferFee: null, note: null,
      date: DateTime.now(), time: TimeOfDay.now(), isRecurring: false, isLoading: false, error: null,
    );
  }
}

final smartEntryControllerProvider = StateNotifierProvider<SmartEntryController, SmartEntryState>((ref) => SmartEntryController(ref));

class SmartEntryController extends StateNotifier<SmartEntryState> {
  final Ref _ref;

  SmartEntryController(this._ref) : super(SmartEntryState()) { _initSuggestions(); }

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

  void updateAmount(String digits) {
    if (digits.isEmpty) { state = state.copyWith(amountString: ''); return; }
    if (digits == 'BACK') {
      if (state.amountString.isNotEmpty) state = state.copyWith(amountString: state.amountString.substring(0, state.amountString.length - 1));
      return;
    }
    if (digits == '.') {
      if (!state.amountString.contains('.')) state = state.copyWith(amountString: state.amountString + '.');
      return;
    }
    String newAmount = state.amountString + digits;
    if (newAmount.contains('.')) {
      final parts = newAmount.split('.');
      if (parts.length > 1 && parts[1].length > 2) return;
    }
    final parsed = CurrencyUtils.parseAmount(newAmount);
    if (parsed != null && parsed > AppConstants.maxExpenseAmount) return;
    state = state.copyWith(amountString: newAmount);
  }

  void setAmount(double amount) => state = state.copyWith(amountString: amount.toStringAsFixed(2).replaceAll('.', ''));
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
      switch (state.mode) {
        case TransactionMode.expense: await _saveExpense(); break;
        case TransactionMode.income: await _saveIncome(); break;
        case TransactionMode.transfer: await _saveTransfer(); break;
      }
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

  Future<void> _saveExpense() async {
    final notifier = _ref.read(expensesProvider.notifier);
    await notifier.addExpense(amount: state.amount, category: state.category!, date: state.date, note: state.note, isRecurring: state.isRecurring);
    final dailySpendNotifier = _ref.read(dailySpendStateProvider.notifier);
    await dailySpendNotifier.addSpending(state.amount);
  }

  Future<void> _saveIncome() async {
    final addUseCase = _ref.read(addIncomeUseCaseProvider);
    await addUseCase.execute(amount: state.amount, source: state.source!, date: state.date, note: state.note);
  }

  Future<void> _saveTransfer() async {
    final notifier = _ref.read(transfersProvider.notifier);
    await notifier.addTransfer(amount: state.amount, fromAccount: state.fromAccount!, toAccount: state.toAccount!, date: state.date, fee: state.transferFee, note: state.note);
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
    return state.fromAccount! + ' -> ' + state.toAccount!;
  }

  String getFormattedAmount() {
    if (state.amountString.isEmpty) return AppConstants.currencySymbol + '0';
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