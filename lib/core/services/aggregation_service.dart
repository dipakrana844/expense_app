import 'package:collection/collection.dart';
import '../domain/interfaces/transaction_interface.dart';

/// Service: AggregationService
///
/// Purpose: Single source of truth for all financial aggregation calculations
/// - Eliminates duplication across features
/// - Ensures consistent calculation logic
/// - Provides reusable aggregation patterns
///
/// Design Principles:
/// 1. Pure functions - No side effects
/// 2. Generic - Works with any TransactionInterface implementation
/// 3. Efficient - Single pass calculations where possible
/// 4. Immutable - Returns new data structures
class AggregationService {
  AggregationService._();

  /// Calculate total amount from list of transactions
  ///
  /// Parameters:
  /// - transactions: List of transactions to aggregate
  /// - predicate: Optional filter function
  ///
  /// Returns: Sum of amounts for matching transactions
  static double calculateTotal<T extends TransactionInterface>({
    required List<T> transactions,
    bool Function(T)? predicate,
  }) {
    Iterable<T> filtered = transactions;
    if (predicate != null) {
      filtered = filtered.where(predicate);
    }
    
    return filtered.fold(0.0, (sum, transaction) => sum + transaction.amount);
  }

  /// Calculate net balance (income - expenses)
  ///
  /// Parameters:
  /// - transactions: List of mixed income/expense transactions
  ///
  /// Returns: Net balance where income adds and expenses subtract
  static double calculateNetBalance<T extends TransactionInterface>({
    required List<T> transactions,
  }) {
    return transactions.fold(0.0, (sum, transaction) {
      return transaction.isIncome 
          ? sum + transaction.amount 
          : sum - transaction.amount;
    });
  }

  /// Calculate daily average for current month
  ///
  /// Parameters:
  /// - transactions: List of transactions (filtered to current month)
  ///
  /// Returns: Average daily spending for the month so far
  static double calculateDailyAverage<T extends TransactionInterface>({
    required List<T> transactions,
  }) {
    if (transactions.isEmpty) return 0.0;
    
    final now = DateTime.now();
    final daysPassed = now.day;
    
    final monthTotal = calculateTotal(
      transactions: transactions,
      predicate: (t) => t.date.year == now.year && t.date.month == now.month,
    );
    
    return daysPassed > 0 ? monthTotal / daysPassed : 0.0;
  }

  /// Calculate category breakdown with percentages
  ///
  /// Parameters:
  /// - transactions: List of transactions to analyze
  /// - includePercentages: Whether to calculate percentage of total
  ///
  /// Returns: Map of category to {amount, percentage} breakdown
  static Map<String, CategoryBreakdown> calculateCategoryBreakdown<
      T extends TransactionInterface>({
    required List<T> transactions,
    bool includePercentages = true,
  }) {
    if (transactions.isEmpty) return {};
    
    final breakdown = <String, CategoryBreakdown>{};
    double totalAmount = 0.0;
    
    // Calculate totals per category
    for (final transaction in transactions) {
      final category = transaction.categoryOrSource;
      final currentAmount = breakdown[category]?.amount ?? 0.0;
      breakdown[category] = CategoryBreakdown(
        amount: currentAmount + transaction.amount,
        count: (breakdown[category]?.count ?? 0) + 1,
      );
      totalAmount += transaction.amount;
    }
    
    // Add percentages if requested
    if (includePercentages && totalAmount > 0) {
      return breakdown.map((category, data) => MapEntry(
            category,
            CategoryBreakdown(
              amount: data.amount,
              count: data.count,
              percentage: (data.amount / totalAmount) * 100,
            ),
          ));
    }
    
    return breakdown;
  }

  /// Group transactions by date
  ///
  /// Parameters:
  /// - transactions: List of transactions to group
  /// - sortByDate: Whether to sort groups chronologically
  ///
  /// Returns: Map of date keys to transaction lists
  static Map<String, List<T>> groupByDate<T extends TransactionInterface>({
    required List<T> transactions,
    bool sortByDate = true,
  }) {
    final grouped = groupBy(transactions, (transaction) => transaction.dateKey);
    
    if (sortByDate) {
      // Sort by date descending (newest first)
      final sortedEntries = grouped.entries.toList()
        ..sort((a, b) => b.key.compareTo(a.key));
      
      return Map.fromEntries(sortedEntries);
    }
    
    return grouped;
  }

  /// Filter transactions by month
  ///
  /// Parameters:
  /// - transactions: List of transactions to filter
  /// - year: Target year
  /// - month: Target month (1-12)
  ///
  /// Returns: Filtered list of transactions for the specified month
  static List<T> filterByMonth<T extends TransactionInterface>({
    required List<T> transactions,
    required int year,
    required int month,
  }) {
    return transactions.where((transaction) {
      return transaction.date.year == year && transaction.date.month == month;
    }).toList();
  }

  /// Filter transactions by date range
  ///
  /// Parameters:
  /// - transactions: List of transactions to filter
  /// - start: Start date (inclusive)
  /// - end: End date (inclusive)
  ///
  /// Returns: Filtered list of transactions within the date range
  static List<T> filterByDateRange<T extends TransactionInterface>({
    required List<T> transactions,
    required DateTime start,
    required DateTime end,
  }) {
    return transactions.where((transaction) {
      return !transaction.date.isBefore(start) && !transaction.date.isAfter(end);
    }).toList();
  }

  /// Get top categories by spending amount
  ///
  /// Parameters:
  /// - transactions: List of transactions to analyze
  /// - limit: Maximum number of categories to return
  ///
  /// Returns: List of top categories sorted by amount descending
  static List<CategorySummary> getTopCategories<T extends TransactionInterface>({
    required List<T> transactions,
    int limit = 5,
  }) {
    final breakdown = calculateCategoryBreakdown(transactions: transactions);
    
    return breakdown.entries
        .map((entry) => CategorySummary(
              category: entry.key,
              amount: entry.value.amount,
              count: entry.value.count,
              percentage: entry.value.percentage,
            ))
        .sorted((a, b) => b.amount.compareTo(a.amount))
        .take(limit)
        .toList();
  }

  /// Calculate savings rate (income - expenses) / income
  ///
  /// Parameters:
  /// - transactions: Mixed list of income and expense transactions
  ///
  /// Returns: Savings rate as percentage (0-100)
  static double calculateSavingsRate<T extends TransactionInterface>({
    required List<T> transactions,
  }) {
    double totalIncome = 0.0;
    double totalExpenses = 0.0;
    
    for (final transaction in transactions) {
      if (transaction.isIncome) {
        totalIncome += transaction.amount;
      } else {
        totalExpenses += transaction.amount;
      }
    }
    
    if (totalIncome <= 0) return 0.0;
    
    final savings = totalIncome - totalExpenses;
    return (savings / totalIncome) * 100;
  }

  /// Calculate month-over-month growth/change
  ///
  /// Parameters:
  /// - currentMonthTransactions: Transactions for current month
  /// - previousMonthTransactions: Transactions for previous month
  ///
  /// Returns: Percentage change from previous month
  static double calculateMonthOverMonthChange<T extends TransactionInterface>({
    required List<T> currentMonthTransactions,
    required List<T> previousMonthTransactions,
  }) {
    final currentTotal = calculateTotal(transactions: currentMonthTransactions);
    final previousTotal = calculateTotal(transactions: previousMonthTransactions);
    
    if (previousTotal <= 0) return 0.0;
    
    return ((currentTotal - previousTotal) / previousTotal) * 100;
  }
}

/// Data class for category breakdown information
class CategoryBreakdown {
  final double amount;
  final int count;
  final double? percentage;

  CategoryBreakdown({
    required this.amount,
    required this.count,
    this.percentage,
  });

  @override
  String toString() => 'CategoryBreakdown(amount: $amount, count: $count, percentage: $percentage)';
}

/// Data class for category summary with ranking
class CategorySummary {
  final String category;
  final double amount;
  final int count;
  final double? percentage;

  CategorySummary({
    required this.category,
    required this.amount,
    required this.count,
    this.percentage,
  });

  @override
  String toString() => 'CategorySummary(category: $category, amount: $amount, count: $count, percentage: $percentage)';
}