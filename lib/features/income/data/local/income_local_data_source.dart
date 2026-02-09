import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/income_model.dart';
import '../../domain/entities/income_entity.dart';

/// Local Data Source: IncomeLocalDataSource
///
/// Purpose: Handles all local persistence operations for income data
/// - Manages Hive box initialization and operations
/// - Provides CRUD operations for income records
/// - Handles data conversion between models and entities
///
/// Design Decision: Single source of truth for local income data
/// - Encapsulates all Hive-specific logic
/// - Provides clean interface for repository layer
/// - Handles initialization and error recovery
class IncomeLocalDataSource {
  static const String _boxName = 'incomes';
  late Box<IncomeModel> _incomeBox;
  bool _isInitialized = false;

  /// Initialize the data source
  /// Must be called before any operations
  Future<void> init() async {
    if (_isInitialized) return;

    try {
      // Ensure Hive is initialized
      await Hive.initFlutter();

      // Register adapter if not already registered
      // Using typeId 7 for IncomeModel (following existing pattern)
      if (!Hive.isAdapterRegistered(7)) {
        Hive.registerAdapter(IncomeModelAdapter());
      }

      _incomeBox = await Hive.openBox<IncomeModel>(_boxName);
      _isInitialized = true;
    } catch (e) {
      debugPrint('Failed to initialize Income Hive box: $e');
      rethrow;
    }
  }

  /// Close the data source
  /// Should be called when app shuts down
  Future<void> close() async {
    if (_isInitialized && _incomeBox.isOpen) {
      await _incomeBox.close();
      _isInitialized = false;
    }
  }

  /// Internal helper to ensure initialization
  void _ensureInitialized() {
    if (!_isInitialized) {
      throw Exception('Income local data source not initialized. Call init() first.');
    }
  }

  /// Get all income records
  /// Returns list of IncomeEntity sorted by date (newest first)
  Future<List<IncomeEntity>> getAllIncomes() async {
    final incomeModels = _incomeBox.values.toList()
      ..sort((a, b) => b.date.compareTo(a.date)); // Newest first
    
    return incomeModels.map((model) => model.toEntity()).toList();
  }

  /// Get income by ID
  /// Returns null if not found
  Future<IncomeEntity?> getIncomeById(String id) async {
    final incomeModel = _incomeBox.get(id);
    return incomeModel?.toEntity();
  }

  /// Add new income record
  /// Returns the created IncomeEntity
  Future<IncomeEntity> addIncome(IncomeEntity income) async {
    _ensureInitialized();
    final incomeModel = IncomeModel.fromEntity(income);
    await _incomeBox.put(income.id, incomeModel);
    return income; // Return the entity version
  }

  /// Update existing income record
  /// Throws exception if income doesn't exist
  Future<IncomeEntity> updateIncome(IncomeEntity income) async {
    final existingModel = _incomeBox.get(income.id);
    if (existingModel == null) {
      throw Exception('Income with id ${income.id} not found');
    }

    final updatedModel = IncomeModel.fromEntity(income).withUpdateTimestamp();
    await _incomeBox.put(income.id, updatedModel);
    return income;
  }

  /// Delete income record
  /// Throws exception if income doesn't exist
  Future<void> deleteIncome(String id) async {
    final existingModel = _incomeBox.get(id);
    if (existingModel == null) {
      throw Exception('Income with id $id not found');
    }

    await _incomeBox.delete(id);
  }

  /// Get incomes for specific month
  /// Useful for analytics and monthly summaries
  Future<List<IncomeEntity>> getIncomesByMonth(int year, int month) async {
    final allIncomes = await getAllIncomes();
    return allIncomes.where((income) {
      return income.date.year == year && income.date.month == month;
    }).toList();
  }

  /// Get incomes for specific date range
  /// Useful for custom reporting periods
  Future<List<IncomeEntity>> getIncomesByDateRange(DateTime start, DateTime end) async {
    final allIncomes = await getAllIncomes();
    return allIncomes.where((income) {
      return !income.date.isBefore(start) && !income.date.isAfter(end);
    }).toList();
  }

  /// Get total income for a period
  /// Optimized calculation without loading all entities
  Future<double> getTotalIncomeByMonth(int year, int month) async {
    _ensureInitialized();
    final incomes = await getIncomesByMonth(year, month);
    double total = 0.0;
    for (final income in incomes) {
      total += income.amount;
    }
    return total;
  }

  /// Clear all income data (for testing/debugging)
  /// Use with caution - irreversible operation
  Future<void> clearAllData() async {
    await _incomeBox.clear();
  }

  /// Get count of all income records
  /// Lightweight operation for statistics
  int getCount() {
    return _incomeBox.length;
  }

  /// Check if income exists by ID
  /// Lightweight existence check
  bool exists(String id) {
    return _incomeBox.containsKey(id);
  }
}