import '../../domain/entities/transfer_entity.dart';
import '../../domain/repositories/transfer_repository.dart';
import '../local/transfer_local_data_source.dart';
import '../models/transfer_model.dart';

/// Repository Implementation: TransferRepositoryImpl
///
/// Purpose: Implements TransferRepository using local data source
/// - Handles conversion between entity and model
/// - Coordinates data operations
/// - Manages error handling
class TransferRepositoryImpl implements TransferRepository {
  final TransferLocalDataSource _dataSource;

  TransferRepositoryImpl(this._dataSource);

  @override
  Future<List<TransferEntity>> getAllTransfers() async {
    final models = await _dataSource.getAllTransfers();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<TransferEntity?> getTransferById(String id) async {
    final model = await _dataSource.getTransferById(id);
    return model?.toEntity();
  }

  @override
  Future<TransferEntity> addTransfer(TransferEntity transfer) async {
    final model = TransferModel.fromEntity(transfer);
    await _dataSource.createTransfer(model);
    return transfer;
  }

  @override
  Future<TransferEntity> updateTransfer(TransferEntity transfer) async {
    final updatedModel = TransferModel(
      id: transfer.id,
      amount: transfer.amount,
      fromAccount: transfer.fromAccount,
      toAccount: transfer.toAccount,
      date: transfer.date,
      fee: transfer.fee,
      note: transfer.note,
      createdAt: transfer.createdAt,
      updatedAt: DateTime.now(),
      metadata: transfer.metadata,
    );
    await _dataSource.updateTransfer(updatedModel);
    return updatedModel.toEntity();
  }

  @override
  Future<void> deleteTransfer(String id) async {
    await _dataSource.deleteTransfer(id);
  }

  @override
  Future<List<TransferEntity>> getTransfersByMonth(int year, int month) async {
    final models = await _dataSource.getTransfersByMonth(year, month);
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<TransferEntity>> getTransfersByDateRange(
      DateTime start, DateTime end) async {
    final models = await _dataSource.getTransfersByDateRange(start, end);
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<double> getTotalTransfersByMonth(int year, int month) async {
    return await _dataSource.getTotalTransfersByMonth(year, month);
  }
}
