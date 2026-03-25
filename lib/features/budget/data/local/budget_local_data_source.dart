import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/constants/app_constants.dart';
import '../models/budget_model.dart';

class BudgetLocalDataSource {
  late Box _budgetBox;
  bool _isInitialized = false;

  Future<void> init() async {
    if (_isInitialized) return;

    try {
      _budgetBox = await Hive.openBox(AppConstants.budgetBoxName);
      _isInitialized = true;
    } catch (e) {
      debugPrint('Failed to initialize Budget Hive box: $e');
      rethrow;
    }
  }

  /// Returns the stored budget model, or null if no budget set.
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
        currency: '₹', // default
        isActive: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      // Optionally save migrated model (lazy)
      return model;
    }
    return stored as BudgetModel;
  }

  /// Updates the budget with the given model.
  Future<void> updateBudget(BudgetModel model) async {
    _ensureInitialized();
    await _budgetBox.put('budget_model', model);
    // Keep legacy key for backward compatibility (optional)
    await _budgetBox.put('monthly_limit', model.amount);
  }

  /// Legacy method for compatibility.
  double getMonthlyBudget() {
    final model = getBudget();
    return model?.amount ?? 0.0;
  }

  /// Legacy method for compatibility.
  Future<void> updateMonthlyBudget(double amount) async {
    final model = BudgetModel(
      amount: amount,
      currency: '₹',
      isActive: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await updateBudget(model);
  }

  void _ensureInitialized() {
    if (!_isInitialized) {
      throw Exception('BudgetLocalDataSource not initialized');
    }
  }
}
