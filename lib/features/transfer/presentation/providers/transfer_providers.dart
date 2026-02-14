import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/local/transfer_local_data_source.dart';
import '../../data/repositories/transfer_repository_impl.dart';
import '../../domain/entities/transfer_entity.dart';
import '../../domain/repositories/transfer_repository.dart';
import '../../domain/usecases/add_transfer_usecase.dart';

final transferLocalDataSourceProvider = Provider<TransferLocalDataSource>((ref) {
  return TransferLocalDataSource();
});

final transferRepositoryProvider = Provider<TransferRepository>((ref) {
  final dataSource = ref.watch(transferLocalDataSourceProvider);
  return TransferRepositoryImpl(dataSource);
});

final addTransferUseCaseProvider = Provider<AddTransferUseCase>((ref) {
  final repository = ref.watch(transferRepositoryProvider);
  return AddTransferUseCase(repository);
});

final transfersProvider =
    StateNotifierProvider<TransfersNotifier, AsyncValue<List<TransferEntity>>>(
        (ref) {
  final repository = ref.watch(transferRepositoryProvider);
  return TransfersNotifier(repository);
});

class TransfersNotifier extends StateNotifier<AsyncValue<List<TransferEntity>>> {
  final TransferRepository _repository;

  TransfersNotifier(this._repository) : super(const AsyncLoading()) {
    _loadTransfers();
  }

  Future<void> _loadTransfers() async {
    try {
      final transfers = await _repository.getAllTransfers();
      transfers.sort((a, b) => b.date.compareTo(a.date));
      state = AsyncValue.data(transfers);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> addTransfer({
    required double amount,
    required String fromAccount,
    required String toAccount,
    DateTime? date,
    double? fee,
    String? note,
  }) async {
    try {
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

      await _repository.addTransfer(transfer);
      await _loadTransfers();
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> updateTransfer(TransferEntity transfer) async {
    try {
      await _repository.updateTransfer(transfer);
      await _loadTransfers();
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> deleteTransfer(String id) async {
    try {
      await _repository.deleteTransfer(id);
      await _loadTransfers();
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> refresh() async {
    await _loadTransfers();
  }
}
