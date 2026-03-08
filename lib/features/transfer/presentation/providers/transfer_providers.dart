import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/local/transfer_local_data_source.dart';
import '../../data/repositories/transfer_repository_impl.dart';
import '../../domain/entities/transfer_entity.dart';
import '../../domain/repositories/transfer_repository.dart';
import '../../domain/usecases/add_transfer_usecase.dart';
import '../../../transactions/presentation/providers/transaction_providers.dart';

final transferLocalDataSourceProvider = Provider<TransferLocalDataSource>((
  ref,
) {
  return TransferLocalDataSource();
});

final transferRepositoryProvider = Provider<TransferRepository>((ref) {
  final dataSource = ref.watch(transferLocalDataSourceProvider);
  return TransferRepositoryImpl(dataSource);
});

final addTransferUseCaseProvider = Provider<AddTransferUseCase>((ref) {
  final repository = ref.watch(transferRepositoryProvider);
  return AddTransferUseCase(repository, ref);
});

final transfersProvider =
    AsyncNotifierProvider<TransfersNotifier, List<TransferEntity>>(
      TransfersNotifier.new,
    );

class TransfersNotifier extends AsyncNotifier<List<TransferEntity>> {
  @override
  Future<List<TransferEntity>> build() async {
    final repository = ref.watch(transferRepositoryProvider);
    final transfers = await repository.getAllTransfers();
    transfers.sort((a, b) => b.date.compareTo(a.date));
    return transfers;
  }

  Future<void> addTransfer({
    required double amount,
    required String fromAccount,
    required String toAccount,
    DateTime? date,
    double? fee,
    String? note,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(transferRepositoryProvider);
      final now = DateTime.now();
      final transfer = TransferEntity(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        amount: amount,
        fromAccount: fromAccount,
        toAccount: toAccount,
        date: date ?? now,
        fee: fee ?? 0.0,
        note: note,
        createdAt: now,
      );

      await repository.addTransfer(transfer);

      // Refresh transaction providers to update the UI
      try {
        ref.read(transactionActionsProvider.notifier).refresh();
      } catch (e) {
        debugPrint(
          'Failed to refresh transaction providers after adding transfer: $e',
        );
      }

      final transfers = await repository.getAllTransfers();
      transfers.sort((a, b) => b.date.compareTo(a.date));
      return transfers;
    });
  }

  Future<void> updateTransfer(TransferEntity transfer) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(transferRepositoryProvider);
      await repository.updateTransfer(transfer);

      // Refresh transaction providers to update the UI
      try {
        ref.read(transactionActionsProvider.notifier).refresh();
      } catch (e) {
        debugPrint(
          'Failed to refresh transaction providers after updating transfer: $e',
        );
      }

      final transfers = await repository.getAllTransfers();
      transfers.sort((a, b) => b.date.compareTo(a.date));
      return transfers;
    });
  }

  Future<void> deleteTransfer(String id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(transferRepositoryProvider);
      await repository.deleteTransfer(id);

      // Refresh transaction providers to update the UI
      try {
        ref.read(transactionActionsProvider.notifier).refresh();
      } catch (e) {
        debugPrint(
          'Failed to refresh transaction providers after deleting transfer: $e',
        );
      }

      final transfers = await repository.getAllTransfers();
      transfers.sort((a, b) => b.date.compareTo(a.date));
      return transfers;
    });
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(transferRepositoryProvider);
      final transfers = await repository.getAllTransfers();
      transfers.sort((a, b) => b.date.compareTo(a.date));
      return transfers;
    });
  }
}
