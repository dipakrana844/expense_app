import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/budget_constants.dart';
import '../models/budget_model.dart';

/// Local data source for budget persistence using Hive.
///
/// This class handles all local storage operations for budget data.
/// It must be initialized by calling [init()] before any other methods.
class BudgetLocalDataSource {
  late Box _budgetBox;
  bool _isInitialized = false;

  /// Initializes the Hive box for budget storage.
  /// This method is idempotent - calling it multiple times is safe.
  ///
  /// Throws [Exception] if initialization fails.
  Future<void> init() async {
    if (_isInitialized) return;

    try {
      _budgetBox = await Hive.openBox(AppConstants.budgetBoxName);
      _isInitialized = true;
      debugPrint('BudgetLocalDataSource: Initialized successfully');
    } catch (e) {
      debugPrint('BudgetLocalDataSource: Failed to initialize Hive box: $e');
      rethrow;
    }
  }

  /// Returns the stored budget model, or null if no budget set.
  ///
  /// Automatically migrates legacy storage format if needed.
  ///
  /// Throws [Exception] if the data source is not initialized.
  BudgetModel? getBudget() {
    _ensureInitialized();
    final stored = _budgetBox.get('budget_model');
    if (stored == null) {
      // Check legacy storage
      final amount = _budgetBox.get('monthly_limit', defaultValue: 0.0);
      if (amount <= 0) return null;
      // Migrate to new format
      final model = BudgetModel(
        amount: amount,
        currency: BudgetConstants.defaultCurrency,
        isActive: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      // Optionally save migrated model (lazy migration)
      debugPrint('BudgetLocalDataSource: Migrating legacy budget format');
      return model;
    }
    return stored as BudgetModel;
  }

  /// Updates the budget with the given model.
  ///
  /// Also updates the legacy 'monthly_limit' key for backward compatibility.
  ///
  /// Throws [Exception] if the data source is not initialized.
  Future<void> updateBudget(BudgetModel model) async {
    _ensureInitialized();

    // Validate model before saving
    final validationError = model.validate();
    if (validationError != null) {
      throw Exception('Budget validation failed: $validationError');
    }

    await _budgetBox.put('budget_model', model);
    // Keep legacy key for backward compatibility
    await _budgetBox.put('monthly_limit', model.amount);
    debugPrint('BudgetLocalDataSource: Budget updated to ${model.amount}');
  }

  /// Legacy method for compatibility.
  ///
  /// @deprecated Use [getBudget] instead.
  @Deprecated('Use getBudget() instead')
  double getMonthlyBudget() {
    final model = getBudget();
    return model?.amount ?? 0.0;
  }

  /// Legacy method for compatibility.
  ///
  /// @deprecated Use [updateBudget] instead.
  @Deprecated('Use updateBudget() instead')
  Future<void> updateMonthlyBudget(double amount) async {
    final model = BudgetModel(
      amount: amount,
      currency: BudgetConstants.defaultCurrency,
      isActive: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await updateBudget(model);
  }

  /// Clears all budget data from storage.
  ///
  /// Throws [Exception] if the data source is not initialized.
  Future<void> clearBudget() async {
    _ensureInitialized();
    await _budgetBox.delete('budget_model');
    await _budgetBox.delete('monthly_limit');
    debugPrint('BudgetLocalDataSource: Budget cleared');
  }

  /// Checks if the data source has been initialized.
  bool get isInitialized => _isInitialized;

  void _ensureInitialized() {
    if (!_isInitialized) {
      throw StateError(
        'BudgetLocalDataSource not initialized. Call init() before use.',
      );
    }
  }
}
