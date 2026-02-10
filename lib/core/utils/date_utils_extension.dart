import 'package:intl/intl.dart';
import '../constants/app_constants.dart';
import '../domain/interfaces/transaction_interface.dart';

/// Extension: DateUtilsExtension
///
/// Purpose: Enhanced date utilities with generic transaction support
/// - Extends existing DateUtils with transaction-specific functionality
/// - Provides reusable date grouping and filtering patterns
/// - Maintains backward compatibility with existing code
extension DateUtilsExtension on DateTime {
  /// Get formatted date key for grouping (YYYY-MM-DD)
  String get dateKey {
    return '${year}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
  }

  /// Get month key for analytics (YYYY-MM)
  String get monthKey {
    return '${year}-${month.toString().padLeft(2, '0')}';
  }

  /// Check if this date is in the current month
  bool get isCurrentMonth {
    final now = DateTime.now();
    return year == now.year && month == now.month;
  }

  /// Get start of day
  DateTime get startOfDay => DateTime(year, month, day);

  /// Get end of day
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999);

  /// Get start of month
  DateTime get startOfMonth => DateTime(year, month, 1);

  /// Get end of month
  DateTime get endOfMonth => DateTime(year, month + 1, 0, 23, 59, 59, 999);
}

/// Utility class: TransactionDateUtils
///
/// Purpose: Centralized date operations for transaction entities
/// - Generic grouping and filtering functions
/// - Consistent date key generation
/// - Reusable date comparison logic
class TransactionDateUtils {
  TransactionDateUtils._();

  /// Group transactions by date
  ///
  /// Parameters:
  /// - transactions: List of transactions to group
  /// - sortByDate: Whether to sort groups chronologically (newest first)
  ///
  /// Returns: Map of date keys to transaction lists
  static Map<String, List<T>> groupByDate<T extends TransactionInterface>({
    required List<T> transactions,
    bool sortByDate = true,
  }) {
    final grouped = <String, List<T>>{};
    
    for (final transaction in transactions) {
      final dateKey = transaction.dateKey;
      if (!grouped.containsKey(dateKey)) {
        grouped[dateKey] = [];
      }
      grouped[dateKey]!.add(transaction);
    }
    
    if (sortByDate) {
      // Sort by date key descending (newest first)
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

  /// Get current month key (YYYY-MM format)
  static String getCurrentMonthKey() {
    final now = DateTime.now();
    return now.monthKey;
  }

  /// Get previous month key
  static String getPreviousMonthKey() {
    final now = DateTime.now();
    final previousMonth = DateTime(now.year, now.month - 1);
    return previousMonth.monthKey;
  }

  /// Parse date key back to DateTime
  ///
  /// Parameters:
  /// - dateKey: String in YYYY-MM-DD format
  ///
  /// Returns: DateTime object or null if invalid format
  static DateTime? parseDateKey(String dateKey) {
    try {
      final parts = dateKey.split('-');
      if (parts.length != 3) return null;
      
      final year = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final day = int.parse(parts[2]);
      
      return DateTime(year, month, day);
    } catch (e) {
      return null;
    }
  }

  /// Format date for display using app constants
  static String formatDisplayDate(DateTime date) {
    return DateFormat(AppConstants.displayDateFormat).format(date);
  }

  /// Format date for grouping (more detailed)
  static String formatGroupingDate(DateTime date) {
    return DateFormat(AppConstants.groupingDateFormat).format(date);
  }

  /// Format month and year for analytics
  static String formatMonthYear(DateTime date) {
    return DateFormat(AppConstants.monthYearFormat).format(date);
  }

  /// Get days passed in current month
  static int getDaysPassedInMonth() {
    return DateTime.now().day;
  }

  /// Get total days in month
  static int getDaysInMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0).day;
  }

  /// Check if two dates are on the same day
  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
           date1.month == date2.month &&
           date1.day == date2.day;
  }
}