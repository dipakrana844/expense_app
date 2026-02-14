import '../../domain/entities/transfer_entity.dart';

/// Repository Interface: TransferRepository
///
/// Purpose: Defines the contract for transfer data operations
/// - Abstracts data source implementation details
/// - Provides clean interface for use cases
/// - Enables dependency inversion principle
abstract class TransferRepository {
  /// Get all transfer records
  Future<List<TransferEntity>> getAllTransfers();

  /// Get transfer by ID
  Future<TransferEntity?> getTransferById(String id);

  /// Add new transfer record
  Future<TransferEntity> addTransfer(TransferEntity transfer);

  /// Update existing transfer
  Future<TransferEntity> updateTransfer(TransferEntity transfer);

  /// Delete transfer
  Future<void> deleteTransfer(String id);

  /// Get transfers for specific month
  Future<List<TransferEntity>> getTransfersByMonth(int year, int month);

  /// Get transfers for specific date range
  Future<List<TransferEntity>> getTransfersByDateRange(
      DateTime start, DateTime end);

  /// Get total transfer amount for a period
  Future<double> getTotalTransfersByMonth(int year, int month);
}
