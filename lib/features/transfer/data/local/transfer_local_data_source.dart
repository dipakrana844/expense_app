import 'package:hive_flutter/hive_flutter.dart';
import '../models/transfer_model.dart';

/// Local Data Source: Hive Implementation for Transfers
///
/// Responsibilities:
/// - Direct interaction with Hive database
/// - CRUD operations for transfers
/// - Error handling for storage operations
/// - No business logic - pure data persistence
class TransferLocalDataSource {
  static const String boxName = 'transfers_box';
  late Box<TransferModel> _transferBox;
  bool _isInitialized = false;

  /// Initialize Hive and open transfer box
  Future<void> init() async {
    if (_isInitialized) return;

    try {
      await Hive.initFlutter();

      // Register adapter if not already registered
      if (!Hive.isAdapterRegistered(4)) {
        Hive.registerAdapter(TransferModelAdapter());
      }

      _transferBox = await Hive.openBox<TransferModel>(boxName);
      _isInitialized = true;
    } catch (e) {
      throw Exception('Failed to initialize transfer data source: $e');
    }
  }

  void _ensureInitialized() {
    if (!_isInitialized) {
      throw Exception('TransferLocalDataSource not initialized. Call init() first.');
    }
  }

  /// Create a new transfer
  Future<void> createTransfer(TransferModel transfer) async {
    _ensureInitialized();
    try {
      await _transferBox.put(transfer.id, transfer);
    } catch (e) {
      throw Exception('Failed to create transfer: $e');
    }
  }

  /// Update an existing transfer
  Future<void> updateTransfer(TransferModel transfer) async {
    _ensureInitialized();
    try {
      await _transferBox.put(transfer.id, transfer);
    } catch (e) {
      throw Exception('Failed to update transfer: $e');
    }
  }

  /// Delete a transfer
  Future<void> deleteTransfer(String id) async {
    _ensureInitialized();
    try {
      await _transferBox.delete(id);
    } catch (e) {
      throw Exception('Failed to delete transfer: $e');
    }
  }

  /// Get all transfers
  Future<List<TransferModel>> getAllTransfers() async {
    _ensureInitialized();
    return _transferBox.values.toList();
  }

  /// Get transfer by ID
  Future<TransferModel?> getTransferById(String id) async {
    _ensureInitialized();
    return _transferBox.get(id);
  }

  /// Get transfers for specific month
  Future<List<TransferModel>> getTransfersByMonth(int year, int month) async {
    _ensureInitialized();
    return _transferBox.values.where((transfer) {
      return transfer.date.year == year && transfer.date.month == month;
    }).toList();
  }

  /// Get transfers for specific date range
  Future<List<TransferModel>> getTransfersByDateRange(
      DateTime start, DateTime end) async {
    _ensureInitialized();
    return _transferBox.values.where((transfer) {
      return !transfer.date.isBefore(start) && !transfer.date.isAfter(end);
    }).toList();
  }

  /// Get total transfer amount for a period
  Future<double> getTotalTransfersByMonth(int year, int month) async {
    _ensureInitialized();
    final transfers = await getTransfersByMonth(year, month);
    double total = 0.0;
    for (final transfer in transfers) {
      total += transfer.amount + transfer.fee;
    }
    return total;
  }

  /// Clear all transfer data
  Future<void> clearAllData() async {
    _ensureInitialized();
    await _transferBox.clear();
  }

  /// Get count of all transfer records
  int getCount() {
    _ensureInitialized();
    return _transferBox.length;
  }

  /// Check if transfer exists by ID
  bool exists(String id) {
    _ensureInitialized();
    return _transferBox.containsKey(id);
  }
}
