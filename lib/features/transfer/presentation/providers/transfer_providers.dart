import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/local/transfer_local_data_source.dart';
import '../../data/repositories/transfer_repository_impl.dart';
import '../../domain/entities/transfer_entity.dart';
import '../../domain/repositories/transfer_repository.dart';
import '../../domain/usecases/add_transfer_usecase.dart';
import '../../../transactions/presentation/providers/transaction_providers.dart';

/// --------------------
/// DATA SOURCE
/// --------------------
final transferLocalDataSourceProvider = Provider<TransferLocalDataSource>((
  ref,
) {
  return TransferLocalDataSource();
});

/// --------------------
/// REPOSITORY
/// --------------------
final transferRepositoryProvider = Provider<TransferRepository>((ref) {
  return TransferRepositoryImpl(ref.read(transferLocalDataSourceProvider));
});

/// --------------------
/// USECASE
/// --------------------
final addTransferUseCaseProvider = Provider<AddTransferUseCase>((ref) {
  return AddTransferUseCase(ref.read(transferRepositoryProvider), ref);
});

/// --------------------
/// STATE PROVIDER
/// --------------------
final transfersProvider =
    AsyncNotifierProvider<TransfersNotifier, List<TransferEntity>>(
      TransfersNotifier.new,
    );

/// --------------------
/// NOTIFIER
/// --------------------
class TransfersNotifier extends AsyncNotifier<List<TransferEntity>> {
  TransferRepository get _repository => ref.read(transferRepositoryProvider);

  /// Initial load
  @override
  Future<List<TransferEntity>> build() async {
    return _fetchAndSortTransfers();
  }

  /// --------------------
  /// CORE HELPERS
  /// --------------------

  Future<List<TransferEntity>> _fetchAndSortTransfers() async {
    final transfers = await _repository.getAllTransfers();
    transfers.sort((a, b) => b.date.compareTo(a.date));
    return transfers;
  }

  void _refreshTransactionsSafely() {
    try {
      ref.read(transactionActionsProvider.notifier).refresh();
    } catch (e) {
      debugPrint('Transaction refresh failed: $e');
    }
  }

  Future<void> _updateState(Future<void> Function() action) async {
    final previousState = state;

    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await action();
      return _fetchAndSortTransfers();
    });

    // Optional: fallback if something fails
    if (state.hasError) {
      state = previousState;
    }
  }

  /// --------------------
  /// ACTIONS
  /// --------------------

  Future<void> addTransfer({
    required double amount,
    required String fromAccount,
    required String toAccount,
    DateTime? date,
    double? fee,
    String? note,
  }) async {
    final now = DateTime.now();

    final transfer = TransferEntity(
      id: now.millisecondsSinceEpoch.toString(),
      amount: amount,
      fromAccount: fromAccount,
      toAccount: toAccount,
      date: date ?? now,
      fee: fee ?? 0.0,
      note: note,
      createdAt: now,
    );

    await _updateState(() async {
      await _repository.addTransfer(transfer);
      _refreshTransactionsSafely();
    });
  }

  Future<void> updateTransfer(TransferEntity transfer) async {
    await _updateState(() async {
      await _repository.updateTransfer(transfer);
      _refreshTransactionsSafely();
    });
  }

  Future<void> deleteTransfer(String id) async {
    await _updateState(() async {
      await _repository.deleteTransfer(id);
      _refreshTransactionsSafely();
    });
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_fetchAndSortTransfers);
  }
}
