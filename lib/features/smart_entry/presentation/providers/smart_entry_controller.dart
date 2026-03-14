import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/utils/smart_parser.dart';
import '../../../../core/services/smart_suggestion_service.dart';
import '../../../expenses/presentation/providers/expense_providers.dart';
import '../../domain/enums/transaction_mode.dart';
import '../../domain/services/smart_entry_service.dart';

// Re-export so existing imports elsewhere don't break.
export '../../domain/enums/transaction_mode.dart';

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
  final bool isDuplicateWarning;

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
    this.isDuplicateWarning = false,
  }) : date = date ?? DateTime.now(),
       time = time ?? TimeOfDay.now();

  double get amount => CurrencyUtils.parseAmount(amountString) ?? 0.0;

  /// Get validation errors for current state
  List<String> get validationErrors {
    final errors = <String>[];

    // Amount validation
    if (amount <= 0) {
      errors.add('Amount must be greater than 0');
    }
    if (amount > AppConstants.maxExpenseAmount) {
      errors.add(
        'Amount exceeds maximum limit of ${CurrencyUtils.formatAmount(AppConstants.maxExpenseAmount)}',
      );
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
        if (fromAccount != null &&
            toAccount != null &&
            fromAccount!.trim() == toAccount!.trim()) {
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
      errors.add(
        'Note is too long (maximum ${AppConstants.maxNoteLength} characters)',
      );
    }

    return errors;
  }

  /// Check if form is ready for submission (more comprehensive than isValid)
  bool get isReadyForSubmission {
    if (!isValid) return false;
    if (isLoading) return false;

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
    if (amount <= 0) return false;
    if (amount > AppConstants.maxExpenseAmount) return false;

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
    TransactionMode? mode,
    String? amountString,
    String? category,
    String? source,
    String? account,
    String? fromAccount,
    String? toAccount,
    double? transferFee,
    String? note,
    DateTime? date,
    TimeOfDay? time,
    bool? isRecurring,
    bool? isLoading,
    bool? isEditing,
    String? editingTransactionId,
    String? error,
    bool? isDuplicateWarning,
  }) {
    return SmartEntryState(
      mode: mode ?? this.mode,
      amountString: amountString ?? this.amountString,
      category: category ?? this.category,
      source: source ?? this.source,
      account: account ?? this.account,
      fromAccount: fromAccount ?? this.fromAccount,
      toAccount: toAccount ?? this.toAccount,
      transferFee: transferFee ?? this.transferFee,
      note: note ?? this.note,
      date: date ?? this.date,
      time: time ?? this.time,
      isRecurring: isRecurring ?? this.isRecurring,
      isLoading: isLoading ?? this.isLoading,
      isEditing: isEditing ?? this.isEditing,
      editingTransactionId: editingTransactionId ?? this.editingTransactionId,
      error: error,
      isDuplicateWarning: isDuplicateWarning ?? this.isDuplicateWarning,
    );
  }

  SmartEntryState resetForm() {
    return SmartEntryState(
      mode: mode,
      amountString: '',
      category: category,
      source: source,
      account: account,
      fromAccount: fromAccount,
      toAccount: toAccount,
      transferFee: null,
      note: null,
      date: DateTime.now(),
      time: TimeOfDay.now(),
      isRecurring: false,
      isLoading: false,
      isEditing: false,
      editingTransactionId: null,
      error: null,
    );
  }
}

// ---------------------------------------------------------------------------
// Modern Riverpod: NotifierProvider
// ---------------------------------------------------------------------------

final smartEntryControllerProvider =
    NotifierProvider<SmartEntryController, SmartEntryState>(
      SmartEntryController.new,
    );

class SmartEntryController extends Notifier<SmartEntryState> {
  @override
  SmartEntryState build() {
    final initialState = SmartEntryState();
    // Apply smart suggestions after first build
    return _applyInitialSuggestions(initialState);
  }

  SmartEntryState _applyInitialSuggestions(SmartEntryState s) {
    final suggestionService = ref.read(smartSuggestionServiceProvider);
    switch (s.mode) {
      case TransactionMode.expense:
        final timeSuggested = suggestionService.getSuggestedCategoryForTime();
        final lastCategory = suggestionService.getLastExpenseCategory();
        if (timeSuggested != null) {
          return s.copyWith(category: timeSuggested);
        } else if (lastCategory != null) {
          return s.copyWith(category: lastCategory);
        }
        break;
      case TransactionMode.income:
        final source = suggestionService.getLastIncomeSource();
        if (source != null) return s.copyWith(source: source);
        break;
      case TransactionMode.transfer:
        final accounts = suggestionService.getLastTransferAccounts();
        SmartEntryState updated = s;
        if (accounts.from != null) {
          updated = updated.copyWith(fromAccount: accounts.from);
        }
        if (accounts.to != null) {
          updated = updated.copyWith(toAccount: accounts.to);
        }
        return updated;
    }
    return s;
  }

  void _initSuggestions() {
    state = _applyInitialSuggestions(state);
  }

  void switchMode(TransactionMode newMode) {
    if (newMode == state.mode) return;
    final suggestionService = ref.read(smartSuggestionServiceProvider);
    switch (newMode) {
      case TransactionMode.expense:
        final category = suggestionService.getLastExpenseCategory();
        state = state.copyWith(
          mode: newMode,
          category: category ?? state.category,
          account: state.account,
        );
        break;
      case TransactionMode.income:
        final source = suggestionService.getLastIncomeSource();
        state = state.copyWith(
          mode: newMode,
          source: source ?? state.source,
          account: state.account,
        );
        break;
      case TransactionMode.transfer:
        final accounts = suggestionService.getLastTransferAccounts();
        state = state.copyWith(
          mode: newMode,
          fromAccount: accounts.from ?? state.fromAccount,
          toAccount: accounts.to ?? state.toAccount,
        );
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
    _checkDuplicate();
  }

  void handleMagicInput(String text) {
    if (text.isEmpty) return;
    final result = SmartParser.parse(text);
    
    state = state.copyWith(
      amountString: result.amount != null ? result.amount!.toStringAsFixed(2) : state.amountString,
      category: result.categoryOrSource ?? state.category,
      source: result.categoryOrSource ?? state.source,
      note: result.note ?? state.note,
    );
    _checkDuplicate();
  }

  void _checkDuplicate() {
    if (state.amount <= 0 || state.category == null) {
      state = state.copyWith(isDuplicateWarning: false);
      return;
    }

    final expensesState = ref.read(expensesProvider);
    expensesState.whenData((expenses) {
      final isDuplicate = expenses.any((e) {
        // Check if same amount and category in the last 2 hours
        final timeDiff = DateTime.now().difference(e.date).inHours.abs();
        return e.amount == state.amount && 
               e.category == state.category && 
               timeDiff < 2 &&
               e.id != state.editingTransactionId;
      });
      state = state.copyWith(isDuplicateWarning: isDuplicate);
    });
  }

  void updateAmount(String digits) {
    if (digits.isEmpty) {
      state = state.copyWith(amountString: '');
      _checkDuplicate();
      return;
    }
    if (digits == 'BACK') {
      if (state.amountString.isNotEmpty) {
        state = state.copyWith(
          amountString: state.amountString.substring(
            0,
            state.amountString.length - 1,
          ),
        );
      }
      _checkDuplicate();
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
    _checkDuplicate();
  }

  void setAmount(double amount) {
    state = state.copyWith(amountString: amount.toStringAsFixed(2));
    _checkDuplicate();
  }

  void setCategory(String? category) {
    state = state.copyWith(category: category);
    _checkDuplicate();
  }
  void setSource(String? source) => state = state.copyWith(source: source);
  void setAccount(String? account) => state = state.copyWith(account: account);
  void setFromAccount(String? account) =>
      state = state.copyWith(fromAccount: account);
  void setToAccount(String? account) =>
      state = state.copyWith(toAccount: account);
  void setTransferFee(double? fee) => state = state.copyWith(transferFee: fee);
  void setNote(String? note) => state = state.copyWith(note: note);
  void setDate(DateTime date) => state = state.copyWith(date: date);
  void setTime(TimeOfDay time) => state = state.copyWith(time: time);
  void toggleRecurring() =>
      state = state.copyWith(isRecurring: !state.isRecurring);
  void setRecurring(bool value) => state = state.copyWith(isRecurring: value);

  Future<bool> save() async {
    if (!state.isReadyForSubmission) return false;
    state = state.copyWith(isLoading: true, error: null);
    try {
      final service = ref.read(smartEntryServiceProvider);
      await service.saveTransaction(
        mode: state.mode,
        amount: state.amount,
        date: state.date,
        category: state.category,
        source: state.source,
        fromAccount: state.fromAccount,
        toAccount: state.toAccount,
        transferFee: state.transferFee,
        note: state.note,
        isRecurring: state.isRecurring,
        isEditing: state.isEditing,
        editingTransactionId: state.editingTransactionId,
      );
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<bool> saveAndContinue() async {
    final success = await save();
    if (success) {
      state = state.resetForm();
      _initSuggestions();
    }
    return success;
  }

  // --- UI Helpers ---

  Color getAccentColor(BuildContext context) {
    switch (state.mode) {
      case TransactionMode.expense:
        return Theme.of(context).primaryColor;
      case TransactionMode.income:
        return Colors.green;
      case TransactionMode.transfer:
        return Colors.orange;
    }
  }

  String getFormattedAmount() {
    return CurrencyUtils.formatAmount(state.amount);
  }

  double? getDailySpendPreview() {
    if (state.mode != TransactionMode.expense || state.amount <= 0) return null;
    // Placeholder logic: 1000 is a hypothetical daily budget
    return 1000.0 - state.amount;
  }

  double? getIncomeBalancePreview() {
    if (state.mode != TransactionMode.income || state.amount <= 0) return null;
    // Placeholder logic: 5000 is a hypothetical current balance
    return 5000.0 + state.amount;
  }

  String? getTransferPreview() {
    if (state.mode != TransactionMode.transfer || state.amount <= 0) return null;
    if (state.fromAccount == null || state.toAccount == null) return null;
    return 'Moving ${CurrencyUtils.formatAmount(state.amount)} from ${state.fromAccount} to ${state.toAccount}';
  }
}
