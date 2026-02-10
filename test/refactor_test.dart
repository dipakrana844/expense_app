import 'package:flutter_test/flutter_test.dart';
import 'package:smart_expense_tracker/core/services/aggregation_service.dart';
import 'package:smart_expense_tracker/core/services/financial_calculator.dart';
import 'package:smart_expense_tracker/core/domain/interfaces/transaction_interface.dart';
import 'package:smart_expense_tracker/features/expenses/domain/entities/expense_entity.dart';

void main() {
  group('AggregationService Tests', () {
    late List<ExpenseEntity> testExpenses;

    setUp(() {
      final now = DateTime.now();
      testExpenses = [
        ExpenseEntity(
          id: '1',
          amount: 100.0,
          category: 'Grocery',
          date: now,
          createdAt: now,
        ),
        ExpenseEntity(
          id: '2',
          amount: 50.0,
          category: 'Transportation',
          date: now,
          createdAt: now,
        ),
        ExpenseEntity(
          id: '3',
          amount: 75.0,
          category: 'Grocery',
          date: DateTime(now.year, now.month, now.day - 1),
          createdAt: now,
        ),
      ];
    });

    test('calculateTotal returns correct sum', () {
      final total = AggregationService.calculateTotal(transactions: testExpenses);
      expect(total, 225.0);
    });

    test('filterByMonth returns correct expenses', () {
      final now = DateTime.now();
      final monthlyExpenses = AggregationService.filterByMonth(
        transactions: testExpenses,
        year: now.year,
        month: now.month,
      );
      
      // Should include all 3 expenses since they're all in the current month
      expect(monthlyExpenses.length, 3);
      final monthlyTotal = AggregationService.calculateTotal(transactions: monthlyExpenses);
      expect(monthlyTotal, 225.0);
    });

    test('calculateCategoryBreakdown returns correct breakdown', () {
      final breakdown = AggregationService.calculateCategoryBreakdown(
        transactions: testExpenses,
      );
      
      expect(breakdown['Grocery']?.amount, 175.0);
      expect(breakdown['Transportation']?.amount, 50.0);
    });

    test('getTopCategories returns categories sorted by amount', () {
      final topCategories = AggregationService.getTopCategories(
        transactions: testExpenses,
        limit: 2,
      );
      
      expect(topCategories.length, 2);
      expect(topCategories[0].category, 'Grocery');
      expect(topCategories[0].amount, 175.0);
      expect(topCategories[1].category, 'Transportation');
      expect(topCategories[1].amount, 50.0);
    });
  });

  group('FinancialCalculator Tests', () {
    test('calculateDailyLimit with budget returns correct value', () {
      final dailyLimit = FinancialCalculator.calculateDailyLimit(
        monthlyBudget: 3000.0,
      );
      
      final daysInMonth = DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day;
      expect(dailyLimit, 3000.0 / daysInMonth);
    });

    test('calculateSavingsRate calculates correctly', () {
      // Mock transaction-like objects
      final mockTransactions = [
        _MockTransaction(true, 1000.0), // Income
        _MockTransaction(false, 300.0), // Expense
        _MockTransaction(false, 200.0), // Expense
      ];
      
      final savingsRate = FinancialCalculator.calculateSavingsRate(
        transactions: mockTransactions,
      );
      
      // (1000 - 500) / 1000 = 50%
      expect(savingsRate, 50.0);
    });
  });
}

// Simple mock class for testing
class _MockTransaction implements TransactionInterface {
  final bool _isIncome;
  final double _amount;
  
  _MockTransaction(this._isIncome, this._amount);
  
  @override
  String get id => 'test-id';
  
  @override
  double get amount => _amount;
  
  @override
  DateTime get date => DateTime.now();
  
  @override
  String? get note => null;
  
  @override
  DateTime get createdAt => DateTime.now();
  
  @override
  DateTime? get updatedAt => null;
  
  @override
  Map<String, dynamic>? get metadata => null;
  
  @override
  String get categoryOrSource => 'Test';
  
  @override
  bool get isIncome => _isIncome;
  
  @override
  bool get isExpense => !_isIncome;
  
  @override
  String get dateKey => DateTime.now().toString();
  
  @override
  String get monthKey => DateTime.now().toString().substring(0, 7);
  
  @override
  bool get isCurrentMonth => true;
  
  @override
  bool get wasModified => false;
  
  @override
  double get displayAmount => _amount;
  
  @override
  String? validate() => null;
}