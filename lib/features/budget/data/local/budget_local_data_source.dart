import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/constants/app_constants.dart';

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

  double getMonthlyBudget() {
    _ensureInitialized();
    return _budgetBox.get('monthly_limit', defaultValue: 0.0);
  }

  Future<void> updateMonthlyBudget(double amount) async {
    _ensureInitialized();
    await _budgetBox.put('monthly_limit', amount);
  }

  void _ensureInitialized() {
    if (!_isInitialized) {
      throw Exception('BudgetLocalDataSource not initialized');
    }
  }
}
