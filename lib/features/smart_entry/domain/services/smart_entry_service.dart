import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_expense_tracker/features/expenses/presentation/providers/expense_providers.dart';
import 'package:smart_expense_tracker/features/income/presentation/providers/income_providers.dart';
import 'package:smart_expense_tracker/features/transfer/presentation/providers/transfer_providers.dart';
import 'package:smart_expense_tracker/features/transfer/domain/entities/transfer_entity.dart';
import 'package:smart_expense_tracker/features/daily_spend_guard/presentation/providers/daily_spend_providers.dart';
import 'package:smart_expense_tracker/features/transactions/presentation/providers/transaction_providers.dart';
import '../enums/transaction_mode.dart';

/// Domain Service: SmartEntryService
///
/// Orchestrates transaction persistence across multiple feature domains.
/// Prevents the presentation controller from depending directly on multiple repositories.
class SmartEntryService {
  final Ref _ref;

  SmartEntryService(this._ref);

  Future<void> saveTransaction({
    required TransactionMode mode,
    required double amount,
    required DateTime date,
    String? category,
    String? source,
    String? fromAccount,
    String? toAccount,
    double? transferFee,
    String? note,
    bool isRecurring = false,
    bool isEditing = false,
    String? editingTransactionId,
  }) async {
    switch (mode) {
      case TransactionMode.expense:
        await _saveExpense(
          amount: amount,
          category: category!,
          date: date,
          note: note,
          isRecurring: isRecurring,
          isEditing: isEditing,
          editingTransactionId: editingTransactionId,
        );
        break;
      case TransactionMode.income:
        await _saveIncome(
          amount: amount,
          source: source!,
          date: date,
          note: note,
          isEditing: isEditing,
          editingTransactionId: editingTransactionId,
        );
        break;
      case TransactionMode.transfer:
        await _saveTransfer(
          amount: amount,
          fromAccount: fromAccount!,
          toAccount: toAccount!,
          date: date,
          fee: transferFee,
          note: note,
          isEditing: isEditing,
          editingTransactionId: editingTransactionId,
        );
        break;
    }
  }

  Future<void> _saveExpense({
    required double amount,
    required String category,
    required DateTime date,
    String? note,
    bool isRecurring = false,
    bool isEditing = false,
    String? editingTransactionId,
  }) async {
    if (isEditing && editingTransactionId != null) {
      final repository = _ref.read(expenseRepositoryProvider);
      await repository.updateExpense(
        id: editingTransactionId,
        amount: amount,
        category: category,
        date: date,
        note: note,
      );
      _refreshTransactions();
      return;
    }

    final notifier = _ref.read(expensesProvider.notifier);
    await notifier.addExpense(
      amount: amount,
      category: category,
      date: date,
      note: note,
      isRecurring: isRecurring,
    );
    final dailySpendNotifier = _ref.read(dailySpendStateProvider.notifier);
    await dailySpendNotifier.addSpending(amount);
  }

  Future<void> _saveIncome({
    required double amount,
    required String source,
    required DateTime date,
    String? note,
    bool isEditing = false,
    String? editingTransactionId,
  }) async {
    if (isEditing && editingTransactionId != null) {
      final updateUseCase = _ref.read(updateIncomeUseCaseProvider);
      await updateUseCase.execute(
        id: editingTransactionId,
        amount: amount,
        source: source,
        date: date,
        note: note,
      );
      _ref.invalidate(incomesProvider);
    } else {
      final addUseCase = _ref.read(addIncomeUseCaseProvider);
      await addUseCase.execute(
        amount: amount,
        source: source,
        date: date,
        note: note,
      );
    }
    _refreshTransactions();
  }

  Future<void> _saveTransfer({
    required double amount,
    required String fromAccount,
    required String toAccount,
    required DateTime date,
    double? fee,
    String? note,
    bool isEditing = false,
    String? editingTransactionId,
  }) async {
    final notifier = _ref.read(transfersProvider.notifier);
    if (isEditing && editingTransactionId != null) {
      final repository = _ref.read(transferRepositoryProvider);
      final existing = await repository.getTransferById(editingTransactionId);
      if (existing == null) {
        throw Exception('Transfer with id $editingTransactionId not found');
      }

      await notifier.updateTransfer(
        TransferEntity(
          id: existing.id,
          amount: amount,
          fromAccount: fromAccount,
          toAccount: toAccount,
          date: date,
          fee: fee ?? 0.0,
          note: note,
          createdAt: existing.createdAt,
          updatedAt: DateTime.now(),
          metadata: existing.metadata,
        ),
      );
      return;
    }

    await notifier.addTransfer(
      amount: amount,
      fromAccount: fromAccount,
      toAccount: toAccount,
      date: date,
      fee: fee,
      note: note,
    );
  }

  void _refreshTransactions() {
    try {
      _ref.read(transactionActionsProvider.notifier).refresh();
    } catch (_) {}
  }
}

final smartEntryServiceProvider = Provider((ref) => SmartEntryService(ref));
